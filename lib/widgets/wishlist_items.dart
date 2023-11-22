import 'package:flutter/material.dart';

class WishlistItems extends StatefulWidget {
  @override
  State<WishlistItems> createState() => _WishlistItemsState();

  final String itemId;
  final String title;
  final String description;
  final double price;
  final String imageURL;
  final Function()? onRemove;

  const WishlistItems({
    super.key,
    required this.itemId,
    required this.title,
    required this.description,
    required this.price,
    required this.imageURL,
    this.onRemove,
  });
}

class _WishlistItemsState extends State<WishlistItems> {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
              SizedBox(
                width: 200,
                height: 200,
                child: Image.network(
                  widget.imageURL,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) {
                    print('Error loading image: $error');
                    return const Icon(Icons.error); // Show an error icon
                  },
                ),
              ),
              const SizedBox(
                width: 70,
              ),
              SizedBox(
                width: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
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
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 150,
              ),
              TextButton(
                onPressed: () {
                  if (widget.onRemove != null) {
                    widget.onRemove!();
                  }
                },
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
    );
  }
}
