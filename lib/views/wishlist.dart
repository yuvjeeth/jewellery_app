import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jewellery_app/views/product_catalog.dart';

import '../widgets/wishlist_items.dart';
import 'contact_us.dart';
import 'our_story.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  @override
  void initState() {
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 1));
    super.initState();
    // Call the function to fetch data when the widget is initialized
    fetchDataFromFirestore();
  }

  List<WishlistItems> wishlistItems = [];

  void fetchDataFromFirestore() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Wishlist Items').get();

      // Map Firestore data to WishlistItems widgets
      List<WishlistItems> items = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        String title = data['itemName'] ?? 'Default Title';
        String description = data['itemDesc'] ?? 'Default Description';
        double price = data['itemPrice'] ?? 0.0;
        String imageURL = data['itemlink'] ?? 'Default Image URL';

        return WishlistItems(
          itemId: doc.id,
          title: title,
          description: description,
          price: price,
          imageURL: imageURL,
          onRemove: () => _removeItemFromWishlist(doc.id),
        );
      }).toList();

      // Update the state with the fetched data
      setState(() {
        wishlistItems = items;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching data: $e');
      }
    }
  }

  Future<void> _removeItemFromWishlist(String itemId) async {
    try {
      await FirebaseFirestore.instance
          .collection('Wishlist Items')
          .doc(itemId)
          .delete();

      if (kDebugMode) {
        print('Item removed from Firebase with ID: $itemId');
      }

      // Update the state by removing the item from the wishlistItems list
      setState(() {
        wishlistItems.removeWhere((item) => item.itemId == itemId);
      });

      // Print a message to the console
      if (kDebugMode) {
        print('Item with ID $itemId has been removed from the wishlist.');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error removing item from Firebase: $e');
      }
      // Handle error appropriately
    }
  }

  late ConfettiController _confettiController;

  @override
  void dispose() {
    // Dispose the ConfettiController
    _confettiController.dispose();
    super.dispose();
  }

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey _buttonKey = GlobalKey();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductCatalog(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              child: Text(
                "The Jewellery Store",
                textAlign: TextAlign.center,
                style: GoogleFonts.aboreto(
                  textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OurStory(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text('Our story'),
            ),
            const SizedBox(
              width: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContactUs(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text('Contact Us'),
            ),
            const SizedBox(
              width: 30,
            ),
            const Text(
              'Wishlist',
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(
              width: 70,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProductCatalog(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
                child: const Row(
                  children: [
                    Icon(Icons.arrow_back),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Continue Shopping',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your wishlist ♥️',
                style: TextStyle(
                  fontSize: 28,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: wishlistItems.isEmpty
                ? const Center(
                    child: Text(
                      'No items in the wishlist.',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    itemCount: wishlistItems.length,
                    itemBuilder: (context, index) {
                      try {
                        return WishlistItems(
                          itemId: wishlistItems[index].itemId,
                          title: wishlistItems[index].title,
                          description: wishlistItems[index].description,
                          price: wishlistItems[index].price,
                          imageURL: wishlistItems[index].imageURL,
                          onRemove: () => _removeItemFromWishlist(
                              wishlistItems[index].itemId),
                        );
                      } catch (e) {
                        if (kDebugMode) {
                          print(
                              'Error building wishlist item at index $index: $e');
                        }
                        return Container(); // Return an empty container in case of an error
                      }
                    },
                  ),
          ),
          const SizedBox(
            height: 30,
          ),
          wishlistItems.isNotEmpty
              ? ElevatedButton(
                  key: _buttonKey,
                  onPressed: () {
                    double totalAmount = 0.0;

                    for (var item in wishlistItems) {
                      totalAmount += item.price;
                    }

                    if (kDebugMode) {
                      print('Total Amount of Items in Wishlist: ₹$totalAmount');
                    }
                    _confettiController.play();
                  },
                  child: const Text('Proceed'),
                )
              : Container(),
          // ConfettiWidget(
          //   confettiController: _confettiController,
          //   blastDirection: -pi / 2,
          //   emissionFrequency: 0.02,
          //   numberOfParticles: 20,
          //   gravity: 0.1,
          //   createParticlePath: drawStar,
          // ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
