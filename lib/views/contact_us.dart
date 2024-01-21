import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jewellery_app/views/wishlist.dart';
import 'our_story.dart';
import 'product_catalog.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController query = TextEditingController();
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
                    builder: (context) => const ProductCatalog(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text('Home'),
            ),
            const SizedBox(
              width: 30,
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
            const Text(
              'Contact Us',
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
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
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Contact Us',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(
              height: 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Material(
                  elevation: 10,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: SizedBox(
                    height: 155,
                    width: 320,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(FontAwesomeIcons.instagram),
                              SizedBox(
                                width: 20,
                              ),
                              Text('rishabhjewellers_nagarathpete')
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(FontAwesomeIcons.facebook),
                              SizedBox(
                                width: 20,
                              ),
                              Text('https://www.facebook.com/rishabhgold/')
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(FontAwesomeIcons.phone),
                              SizedBox(
                                width: 20,
                              ),
                              Text('+91 74835 59880 & +91 80-40957333'),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(Icons.email),
                              SizedBox(
                                width: 20,
                              ),
                              Text('riddhisiddhi916k@gmail.com'),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  height: 200,
                  width: 2,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 20,
                ),
                Material(
                  elevation: 10,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: SizedBox(
                    height: 450,
                    width: 310,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.info),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Get Info',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Have any queries? Drop us your info below and we will contact you',
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: name,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                borderSide:
                                    BorderSide(color: Colors.deepPurple),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                borderSide:
                                    BorderSide(color: Colors.deepPurple),
                              ),
                              floatingLabelStyle:
                                  TextStyle(color: Colors.deepPurple),
                              labelText: 'Your name',
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: email,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                borderSide:
                                    BorderSide(color: Colors.deepPurple),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                borderSide:
                                    BorderSide(color: Colors.deepPurple),
                              ),
                              floatingLabelStyle:
                                  TextStyle(color: Colors.deepPurple),
                              labelText: 'Your email',
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: query,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                borderSide:
                                    BorderSide(color: Colors.deepPurple),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                borderSide:
                                    BorderSide(color: Colors.deepPurple),
                              ),
                              floatingLabelStyle:
                                  TextStyle(color: Colors.deepPurple),
                              labelText: 'Your query',
                            ),
                            maxLines: null,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                        'Thank you for contacting us'),
                                    content: const Text(
                                        'We have received your message and will get back to you shortly :)'),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          name.clear();
                                          email.clear();
                                          query.clear();
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: const Text('Submit'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
