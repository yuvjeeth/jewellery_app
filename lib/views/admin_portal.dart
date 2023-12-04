import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jewellery_app/views/product_catalog.dart';

class AdminPortal extends StatefulWidget {
  const AdminPortal({super.key});

  @override
  State<AdminPortal> createState() => _AdminPortalState();
}

class _AdminPortalState extends State<AdminPortal> {
  TextEditingController name = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController imageLink = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductCatalog(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Add new items',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: 200,
                height: 1,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 40,
              ),
              TextField(
                controller: name,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  floatingLabelStyle: TextStyle(color: Colors.deepPurple),
                  labelText: 'Item Name',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: description,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  floatingLabelStyle: TextStyle(color: Colors.deepPurple),
                  labelText: 'Description',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: weight,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  floatingLabelStyle: TextStyle(color: Colors.deepPurple),
                  labelText: 'Weight of gold (in gms)',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: imageLink,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  floatingLabelStyle: TextStyle(color: Colors.deepPurple),
                  labelText: 'Image link',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (name.text == '' ||
                      description.text == '' ||
                      weight.text == '' ||
                      imageLink.text == '') {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content: const Text('All fields are required!'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    try {
                      final FirebaseFirestore firestore =
                          FirebaseFirestore.instance;
                      CollectionReference itemsCollection =
                          firestore.collection('Jewellery Items');

                      Map<String, dynamic> data = {
                        'Item Name': name.text,
                        'Item Description': description.text,
                        'Item Weight': weight.text,
                        'Item imageLink': imageLink.text,
                      };

                      await itemsCollection.add(data);

                      if (kDebugMode) {
                        print('Document added successfully');
                      }
                      if (!mounted) return;
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Success'),
                            content: const Text('Item added successfully.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );

                      name.clear();
                      description.clear();
                      weight.clear();
                      imageLink.clear();
                    } catch (error) {
                      if (kDebugMode) {
                        print('Error adding document: $error');
                      }

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: Text('An error occurred: $error'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
                child: const Text('Submit'),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () async {
                  const String apiKey = 'goldapi-d6zfrlpqsa4d3-io';

                  // Make a GET request to the Gold API
                  final response = await http.get(
                    Uri.parse('https://www.goldapi.io/api/XAU/INR'),
                    headers: {'x-access-token': apiKey},
                  );

                  if (response.statusCode == 200) {
                    // Parse the JSON response
                    final Map<String, dynamic> data =
                        json.decode(response.body);

                    // Extract the gold rate from the response
                    final double goldRate = data['price_gram_24k'];

                    // Update the data in Firebase collection 'gold price'
                    try {
                      await FirebaseFirestore.instance
                          .collection('Daily Gold Rate')
                          .doc('gold_rate')
                          .set(
                        {'rate': goldRate},
                      );

                      // Print a message to the console
                      if (kDebugMode) {
                        print('Gold rate updated in Firebase: $goldRate');
                      }
                    } catch (e) {
                      // Handle error appropriately
                      if (kDebugMode) {
                        print('Error updating gold rate in Firebase: $e');
                      }
                    }
                  } else {
                    // Handle HTTP error
                    if (kDebugMode) {
                      print(
                          'Error fetching gold rate from API. Status Code: ${response.statusCode}');
                    }
                  }
                },
                child: const Text('Update Goldrate'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
