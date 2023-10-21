import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jewellery_app/widgets/product_entry.dart';

class ProductCatalog extends StatefulWidget {
  const ProductCatalog({super.key});

  @override
  State<ProductCatalog> createState() => _ProductCatalog();
}

class _ProductCatalog extends State<ProductCatalog> {
  List<Widget?> listOfProducts = [
    ProductEntry(
        height: 500,
        width: 500,
        id: 1,
        title: "Gold Finish Traditional Golden Balls Short Necklace",
        description:
            "This timeless Gold Finish Traditional Golden Balls Short Necklace Set is a classic addition to any collection. It is crafted with quality materials for a long-lasting, radiant shine and rich golden color. The intricate design is sure to impress, making this a perfect jewelry gift for any occasion.",
        price: 4500,
        imageURL:
            "https://www.griiham.in/cdn/shop/products/Gold-Finish-Traditional-Golden-balls-Short-Necklace-Set-1063N-Necklace-Set-Griiham.jpg"),
    ProductEntry(
        height: 500,
        width: 500,
        id: 1,
        title: "Gold Finish Traditional Golden Balls Short Necklace",
        description:
            "This timeless Gold Finish Traditional Golden Balls Short Necklace Set is a classic addition to any collection. It is crafted with quality materials for a long-lasting, radiant shine and rich golden color. The intricate design is sure to impress, making this a perfect jewelry gift for any occasion.",
        price: 4500,
        imageURL:
            "https://www.griiham.in/cdn/shop/products/Gold-Finish-Traditional-Golden-balls-Short-Necklace-Set-1063N-Necklace-Set-Griiham.jpg")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text(
          "The Jewellery Store",
          textAlign: TextAlign.center,
          style: GoogleFonts.aboreto(
            textStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            
            child: GridView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: listOfProducts.length,
              itemBuilder: (BuildContext context, index) {
                return listOfProducts[index];
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
               crossAxisCount: 3,
                childAspectRatio: 0.5625,
                crossAxisSpacing: 0.0,
                mainAxisSpacing: 5,
                mainAxisExtent: 500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
