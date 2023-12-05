import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jewellery_app/views/admin_login.dart';
import 'package:jewellery_app/widgets/product_entry.dart';

import 'contact_us.dart';
import 'login_page.dart';
import 'our_story.dart';
import 'wishlist.dart';

class ProductCatalog extends StatefulWidget {
  const ProductCatalog({super.key});

  @override
  State<ProductCatalog> createState() => _ProductCatalog();
}

class _ProductCatalog extends State<ProductCatalog> {
  TextEditingController search = TextEditingController();
  List<Widget?> allProducts = [];
  List<Widget?> listOfProducts = [];
  double goldRate = 0.0;

  List<Widget?> filterProducts(String query, List<Widget?> allProducts) {
    return allProducts.where((product) {
      return product != null &&
          (product as ProductEntry)
              .title
              .toLowerCase()
              .contains(query.toLowerCase());
    }).toList();
  }

  void updateUI(String query) {
    setState(() {
      listOfProducts = filterProducts(query, allProducts);
    });
  }

  Future<String?> getUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      return userSnapshot['name'];
    }
    return null;
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

  String? userName;

  @override
  void initState() {
    super.initState();
    setState(() {
      fetchGoldRate();
    });
    getUserName().then((name) {
      setState(() {
        userName = name;
      });
    });
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
            SizedBox(
              width: 200,
              child: TextField(
                controller: search,
                onSubmitted: (value) {
                  updateUI(value);
                },
                decoration: const InputDecoration(
                  hintText: 'Search items...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(
              width: 60,
            ),
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
            InkWell(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Wishlist(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text('Wishlist'),
            ),
            const SizedBox(
              width: 70,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminLogin(),
                  ),
                  (Route<dynamic> route) => false,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Welcome, $userName!',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        if (!mounted) return;
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                          (route) => false,
                        );
                      },
                      child: const Row(
                        children: [
                          Text(
                            'Logout',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.logout),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              const Text(
                'Todays Goldrate: ',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                width: 2,
              ),
              Text(
                '₹${goldRate.toStringAsFixed(2)}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {},
                child: const Text(
                  'Sort by price',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
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
                  allProducts = snapshot.data!.docs.map((doc) {
                    return ProductEntry(
                      height: 570,
                      width: double.infinity,
                      title: doc['Item Name'],
                      description: doc['Item Description'],
                      weight: double.parse(doc['Item Weight']),
                      imageURL: doc['Item imageLink'],
                    );
                  }).toList();

                  listOfProducts = filterProducts(search.text, allProducts);

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount:
                        listOfProducts.isEmpty ? 1 : listOfProducts.length,
                    itemBuilder: (BuildContext context, index) {
                      return listOfProducts.isNotEmpty
                          ? listOfProducts[index] ?? const SizedBox.shrink()
                          : const Text(
                              'No items found',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            );
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
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
