import 'package:flutter/material.dart';

import '../../../../../utilities/app_properties.dart';
import '../../../../../utilities/models/cartProduct.dart';

class ShopProduct extends StatelessWidget {
  final CartProduct product;
  final VoidCallback onRemove;
  final bool fromcart;

  const ShopProduct(
    this.product, {
    required this.onRemove,
    required this.fromcart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        width: MediaQuery.of(context).size.width / 2,
        child: Column(
          children: <Widget>[
            ShopProductDisplay(
              product,
              fromcart: fromcart,
              onPressed: onRemove,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product.productName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: darkGrey,
                ),
              ),
            ),
            Text(
              '\$${product.productPrice}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: darkGrey, fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
          ],
        ));
  }
}

class ShopProductDisplay extends StatelessWidget {
  final CartProduct product;
  final VoidCallback? onPressed;
  final bool fromcart;

  const ShopProductDisplay(this.product,
      {required this.onPressed, required this.fromcart});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 200,
      child: Stack(children: <Widget>[
        Positioned(
          left: 15,
          child: SizedBox(
            height: 150,
            width: 150,
            child: Transform.scale(
              scale: 1.2,
              child: Image.asset('assets/bottom_yellow.png'),
            ),
          ),
        ),
        Positioned(
          left: 70,
          top: 40,
          child: SizedBox(
              height: 60,
              width: 60,
              child: Image.network(
                product.productImage,
                fit: BoxFit.contain,
              )),
        ),
        fromcart
            ? Positioned(
                right: 40,
                bottom: 25,
                child: Align(
                  child: IconButton(
                    icon: Image.asset('assets/red_clear.png'),
                    onPressed: onPressed,
                  ),
                ),
              )
            : Positioned(child: Text(''))
      ]),
    );
  }
}
