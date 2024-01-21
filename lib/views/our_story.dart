import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jewellery_app/views/contact_us.dart';
import 'package:jewellery_app/views/wishlist.dart';

import 'product_catalog.dart';

class OurStory extends StatefulWidget {
  const OurStory({super.key});

  @override
  State<OurStory> createState() => _OurStoryState();
}

class _OurStoryState extends State<OurStory> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
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
            const Text(
              'Our story',
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
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: w * 0.8,
                height: h * 0.4,
                child: Image.network(
                    fit: BoxFit.fitWidth,
                    'https://cdn.shopify.com/s/files/1/2026/1561/files/our-story.jpg?v=1552221709'),
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Founder's Message:",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "‘Investing in gold is a wise decision to make as it is a great store of value.’",
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                width: 700,
                child: Text(
                  "With that philosophy, we started off what's known as Rishabh Jewellers. We identify ourselves as a mass product retailer of traditional and classic Muslim jewellery at the lowest per gram cost in the country. Only the finest and low-wastage designs become part of our collection. The idea is to deliver investment value to the common man through gold jewellery.",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "How it all started?",
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                width: 800,
                child: Text(
                  "Originating from a non-jewellery business background, our founder Mr. Ajay Kumar Jain was sure of one thing, if not anything else, to sell jewellery. He started from scratch with an internship and learnt the craft to the minutest detail. What followed next was a market search that led to the roads of Bengaluru, Karnataka with an immense potential market for jewellery. He set up a store in the bustling city market of the city with meagre capital but with a vision in multiples thereof. Having humble beginnings with silver he gradually diversified into a mass gold jewellery retailer. Our founder knew the craft from the heart and introduced 22K 916 gold to the common man, which was then popular only with the elites.",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                width: 800,
                child: Text(
                  "Having experienced a wide appreciation for his philosophy and quality of raw material used, he wanted to reach out to the extended audience of the city. He then opened doors for another store to cater to the increased demand. It's been 29 years that we have been doing this with an ever-increasing and loyal customer base. The motto here is very simple, sell attractive plain gold jewellery with the lowest possible per gram cost and highest buy-back value to customers.",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
