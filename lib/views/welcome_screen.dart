import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jewellery_app/views/product_catalog.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreen();
}

class _WelcomeScreen extends State<WelcomeScreen> {
  @override
  void initState() {
    //globalFunctions.readDataLocally();
    super.initState();
  }

  void test() {}

  void goToHomeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ProductCatalog()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 80,
        width: 350,
        child: FloatingActionButton.extended(
          isExtended: true,
          onPressed: goToHomeScreen,
          label: const Row(
            children: [
              Text(
                "View Catalog",
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Lato',
                ),
              ),
               Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
              ),
              Icon(Icons.arrow_right_alt_rounded, size: 96,),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: const AssetImage("assets/images/welcome_bg.jpg"),
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.7), BlendMode.darken)),
            ),
          ),
          Align(
            alignment: const Alignment(-0.8, 0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Text(
                "The Jewellery Store",
                textAlign: TextAlign.center,
                style: GoogleFonts.aboreto(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0.2, -0.2),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: const VerticalDivider(
                color: Colors.white54,
              ),
            ),
          ),
          Align(
            alignment: const Alignment(1, 0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2.4,
              child: const Text(
                "The Place Where Art Meets Craftsmanship",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36,
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
