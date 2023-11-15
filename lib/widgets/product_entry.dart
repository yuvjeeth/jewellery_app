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
                  child: Stack(
                    children: [
                      Container(
                        height: widget.height * 0.6,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(widget.imageURL),
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                      if (isMouseHover)
                        Container(
                          height: widget.height * 0.6,
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: const Column(
                            children: [
                              Icon(Icons.search_rounded),
                              Text("View More"),
                            ],
                          ),
                        ),
                    ],
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
