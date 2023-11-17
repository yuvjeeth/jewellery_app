import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductEntry extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProductEntry();

  final String title;
  final String description;
  final double price;
  final String imageURL;
  final double height;
  final double width;

  const ProductEntry({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.imageURL,
    this.height = 0,
    this.width = 0,
  });
}

class _ProductEntry extends State<ProductEntry> {
  bool isMouseHover = false;
  bool addedToWishlist = false;

  @override
  void initState() {
    super.initState();
    checkWishlistStatus();
  }

  // Function to check if the item is already in the Wishlist
  // Function to check if the item is already in the Wishlist
  void checkWishlistStatus() async {
    var wishlistQuery = await FirebaseFirestore.instance
        .collection('Wishlist Items')
        .where('itemName', isEqualTo: widget.title)
        .get();

    setState(() {
      addedToWishlist = wishlistQuery.docs.isNotEmpty;
    });
  }

  // Function to add an item to the Wishlist Items collection
  void addToWishlist(BuildContext context) async {
    // Check if the item already exists in the Wishlist Items collection
    var wishlistQuery = await FirebaseFirestore.instance
        .collection('Wishlist Items')
        .where('itemName', isEqualTo: widget.title)
        .get();

    // If the item doesn't exist, create a new document
    if (wishlistQuery.docs.isEmpty) {
      await FirebaseFirestore.instance.collection('Wishlist Items').add({
        'itemName': widget.title,
        'itemDesc': widget.description,
        'itemPrice': widget.price,
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
      if (!mounted) return;
      // Show a SnackBar indicating the item already exists
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item already exists in Wishlist!',
              textAlign: TextAlign.center),
          backgroundColor: Colors.red,
        ),
      );
    }
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
                        "₹${widget.price}",
                        style: GoogleFonts.aboreto(
                            textStyle: const TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Align(
                      alignment: const Alignment(0.95, 0),
                      child: SizedBox(
                        width: 175,
                        child: ElevatedButton(
                          onPressed: () {
                            if (!addedToWishlist) {
                              addToWishlist(context);
                            }
                          },
                          child: Text(addedToWishlist
                              ? 'Added to Wishlist'
                              : 'Add to Wishlist'),
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
