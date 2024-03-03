import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductEntry extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProductEntry();

  final String title;
  final String description;
  final double weight;
  final String imageURL;
  final double height;
  final double width;

  const ProductEntry({
    super.key,
    required this.title,
    required this.description,
    required this.weight,
    required this.imageURL,
    this.height = 0,
    this.width = 0,
  });
}

class _ProductEntry extends State<ProductEntry> {
  bool isMouseHover = false;
  bool addedToWishlist = false;
  late Future<bool> wishlistStatus;
  double goldRate = 0.0;

  @override
  void initState() {
    super.initState();
    wishlistStatus = checkWishlistStatus();
    fetchGoldRate();
  }

  Future<void> fetchGoldRate() async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('Daily Gold Rate')
          .doc('gold_rate')
          .get();

      if (snapshot.exists) {
        setState(() {
          goldRate = snapshot['rate'];
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching gold rate: $e');
      }
    }
  }

  double calculateFinalAmount() {
    // Assuming GST is standard at 3%
    const gstRate = 3 / 100; // Convert GST rate to decimal or use 0.03 directly

    // Calculate making charges based on weight
    double makingCharges = 0.0;
    if (widget.weight <= 1) {
      makingCharges = 600;
    } else if (widget.weight <= 2) {
      makingCharges = 550;
    } else if (widget.weight <= 4) {
      makingCharges = 500;
    } else {
      makingCharges = 450 * widget.weight;
    }

    double goldAmount = goldRate * widget.weight;

    double gstAmount = (goldAmount + makingCharges) * gstRate;

    double finalAmount = goldAmount + makingCharges + gstAmount;

    return finalAmount;
  }

  // Function to check if the item is already in the Wishlist
  Future<bool> checkWishlistStatus() async {
    var wishlistQuery = await FirebaseFirestore.instance
        .collection('Wishlist Items')
        .where('itemName', isEqualTo: widget.title)
        .get();

    return wishlistQuery.docs.isNotEmpty;
  }

  // Function to add an item to the Wishlist Items collection
  void toggleWishlist(BuildContext context) async {
    var wishlistQuery = await FirebaseFirestore.instance
        .collection('Wishlist Items')
        .where('itemName', isEqualTo: widget.title)
        .get();

    if (wishlistQuery.docs.isEmpty) {
      // If the item doesn't exist, add it to the Wishlist
      await FirebaseFirestore.instance.collection('Wishlist Items').add({
        'itemName': widget.title,
        'itemDesc': widget.description,
        'itemPrice': calculateFinalAmount(), // Use the calculated amount
        'itemlink': widget.imageURL,
      });

      setState(() {
        addedToWishlist = true;
      });

      // Show a success SnackBar
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Item added to Wishlist!',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      // If the item exists, remove it from the Wishlist
      await FirebaseFirestore.instance
          .collection('Wishlist Items')
          .doc(wishlistQuery.docs.first.id)
          .delete();
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Item removed from Wishlist!',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
    setState(() {
      wishlistStatus = checkWishlistStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Column(
            children: [
              MouseRegion(
                onEnter: (function) => setState(() => isMouseHover = true),
                onExit: (function) => setState(() => isMouseHover = false),
                child: GestureDetector(
                  child: // Replace the existing Container code
                      Image.network(
                    widget.imageURL,
                    height: widget.height * 0.6,
                    width: double.infinity, // Occupy full width
                    fit: BoxFit.cover, // Adjust to cover the entire container
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 6)),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 6)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  widget.description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 6)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Stack(
                  children: [
                    Align(
                      alignment: const Alignment(-0.5, 0),
                      child: Text(
                        "₹${calculateFinalAmount().toStringAsFixed(0)}",
                        style: GoogleFonts.aboreto(
                            textStyle: const TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Align(
                      alignment: const Alignment(0.95, 0),
                      child: SizedBox(
                        width: 175,
                        child: ElevatedButton(
                          onPressed: () {
                            toggleWishlist(context);
                          },
                          child: FutureBuilder<bool>(
                            future: wishlistStatus,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else {
                                return Text(
                                  snapshot.data!
                                      ? 'Added to Wishlist. Click to remove'
                                      : 'Add to Wishlist',
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
