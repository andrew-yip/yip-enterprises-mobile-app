import 'package:ecommerce_project/screens/product_details.dart';
import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final String productId;
  final Function onPressed;
  final String imageUrl;
  final String title;
  final String price;
  Products({this.productId, this.onPressed, this.imageUrl, this.title, this.price});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ProductPage(productId: productId),
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
        ),
        height: 350.0,
        margin: EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 24.0,
        ),
        child: Stack(
          children: [
            Container(
              height: 350.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  "$imageUrl",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600, color: Colors.red),

                    ),
                    Text(
                        price,
                        style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600, color: Colors.red)
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
