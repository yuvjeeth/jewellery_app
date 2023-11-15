import 'dart:developer';

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

  void test() {}

  void goToProductPage() {}

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
                  onTap: goToProductPage,
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
                        width: 150,
                        child: ElevatedButton(
                            onPressed: test,
                            child: const Row(
                              children: [
                                Text("Add to cart"),
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4)),
                                Icon(Icons.add_shopping_cart_rounded),
                              ],
                            )),
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
