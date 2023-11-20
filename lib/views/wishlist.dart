import 'package:cloud_firestore/cloud_firestore.dart';
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
    super.initState();
    // Call the function to fetch data when the widget is initialized
    fetchDataFromFirestore();
  }

  List<WishlistItems> wishlistItems = [];

  void fetchDataFromFirestore() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Wishlist Items').get();

      print('Number of documents: ${querySnapshot.docs.length}');

      if (querySnapshot.docs.isNotEmpty) {
        print('First document data: ${querySnapshot.docs.first.data()}');
      }

      // Map Firestore data to WishlistItems widgets
      List<WishlistItems> items = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return WishlistItems(
          title: data['itemName'],
          description: data['itemDesc'],
          price: data['itemPrice'],
          imageURL: data['itemLink'],
        );
      }).toList();

      // Update the state with the fetched data
      setState(() {
        wishlistItems = items;
      });
    } catch (e) {
      print('Error fetching data: $e');
      // Handle error as needed
    }
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
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductCatalog(),
                  ),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OurStory(),
                  ),
                );
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
              child: const Text(
                'Wishlist',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
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
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProductCatalog(),
                ),
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
            child: ListView.builder(
              itemCount: wishlistItems.length,
              itemBuilder: (context, index) {
                return WishlistItems(
                  title: wishlistItems[index].title,
                  description: wishlistItems[index].description,
                  price: wishlistItems[index].price,
                  imageURL: wishlistItems[index].imageURL,
                );
              },
            ),
          ),
          // ElevatedButton(
          //   onPressed: () {},
          //   child: const Text('Proceed'),
          // ),
        ],
      ),
    );
  }
}
