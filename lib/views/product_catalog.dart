import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jewellery_app/views/admin_login.dart';
import 'package:jewellery_app/widgets/product_entry.dart';

import '../models/item.dart';
import 'contact_us.dart';
import 'our_story.dart';
import 'wishlist.dart';

class ProductCatalog extends StatefulWidget {
  const ProductCatalog({super.key});

  @override
  State<ProductCatalog> createState() => _ProductCatalog();
}

class _ProductCatalog extends State<ProductCatalog> {
  // List<Widget?> listOfProducts = [
  //   const ProductEntry(
  //       height: 500,
  //       width: 500,
  //       id: 1,
  //       title: "Gold Finish Traditional Golden Balls Short Necklace",
  //       description:
  //           "This timeless Gold Finish Traditional Golden Balls Short Necklace Set is a classic addition to any collection. It is crafted with quality materials for a long-lasting, radiant shine and rich golden color. The intricate design is sure to impress, making this a perfect jewelry gift for any occasion.",
  //       price: 4500,
  //       imageURL:
  //           "https://www.griiham.in/cdn/shop/products/Gold-Finish-Traditional-Golden-balls-Short-Necklace-Set-1063N-Necklace-Set-Griiham.jpg"),
  //   const ProductEntry(
  //       height: 500,
  //       width: 500,
  //       id: 1,
  //       title: "Gold Finish Traditional Golden Balls Short Necklace",
  //       description:
  //           "This timeless Gold Finish Traditional Golden Balls Short Necklace Set is a classic addition to any collection. It is crafted with quality materials for a long-lasting, radiant shine and rich golden color. The intricate design is sure to impress, making this a perfect jewelry gift for any occasion.",
  //       price: 4500,
  //       imageURL:
  //           "https://www.griiham.in/cdn/shop/products/Gold-Finish-Traditional-Golden-balls-Short-Necklace-Set-1063N-Necklace-Set-Griiham.jpg"),
  // ];
  Future<List<Item>> getItems() async {
    // Fetch data from Firestore
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Jewellery Items').get();

    // Process data and convert it to List<Item>
    List<Item> items = querySnapshot.docs.map((doc) {
      // Print data to console for verification
      print("Item Name: ${doc['Item Name']}");
      print("Item Description: ${doc['Item Description']}");
      print("Item Price: ${doc['Item Price']}");
      print("Item ImageLink: ${doc['Item imageLink']}");

      return Item(
        name: doc['Item Name'],
        price: (doc['Item Price'] as num).toDouble(),
        description: doc['Item Description'],
        imageLink: doc['Item ImageLink'],
      );
    }).toList();

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "The Jewellery Store",
              textAlign: TextAlign.center,
              style: GoogleFonts.aboreto(
                textStyle: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const OurStory(),
                //   ),
                // );
                getItems();
              },
              child: const Text('Our story'),
            ),
            const SizedBox(
              width: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContactUs(),
                  ),
                );
              },
              child: const Text('Contact Us'),
            ),
            const SizedBox(
              width: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Wishlist(),
                  ),
                );
              },
              child: const Text('Wishlist'),
            ),
            const SizedBox(
              width: 70,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminLogin(),
                  ),
                );
              },
              child: const Column(
                children: [
                  Icon(Icons.person),
                  Text(
                    'Admin Login',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Jewellery Items')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<Widget?> listOfProducts = snapshot.data!.docs.map((doc) {
                    return ProductEntry(
                      // Use appropriate field names based on your Firestore structure
                      title: doc['Item Name'],
                      description: doc['Item Description'],
                      price: double.parse(doc['Item Price']),
                      // imageURL: doc['Item imageLink'],
                      imageURL:
                          'https://www.griiham.in/cdn/shop/products/Gold-Finish-Traditional-Golden-balls-Short-Necklace-Set-1063N-Necklace-Set-Griiham.jpg',
                    );
                  }).toList();

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: listOfProducts.length,
                    itemBuilder: (BuildContext context, index) {
                      return listOfProducts[index] ?? const SizedBox.shrink();
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.5625,
                      crossAxisSpacing: 0.0,
                      mainAxisSpacing: 5,
                      mainAxisExtent: 500,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
