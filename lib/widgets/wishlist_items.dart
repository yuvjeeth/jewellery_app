import 'package:flutter/material.dart';

class WishlistItems extends StatefulWidget {
  @override
  State<WishlistItems> createState() => _WishlistItemsState();

  final String title;
  final String description;
  final double price;
  final String imageURL;

  const WishlistItems({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.imageURL,
  });
}

class _WishlistItemsState extends State<WishlistItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Container(
          height: 150,
          width: double.infinity,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.0, color: Colors.black),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Image.network(widget.imageURL),
                const SizedBox(
                  width: 70,
                ),
                SizedBox(
                  width: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(widget.description)
                    ],
                  ),
                ),
                const SizedBox(
                  width: 150,
                ),
                Text(
                  "₹${widget.price}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 150,
                ),
                TextButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Row(
                    children: [
                      Text(
                        'Remove from Wishlist',
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.delete,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
