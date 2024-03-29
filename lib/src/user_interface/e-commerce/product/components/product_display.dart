import 'package:flutter/material.dart';

import '../../../../../utilities/app_properties.dart';
import '../../../../../utilities/models/product.dart';

class ProductDisplay extends StatelessWidget {
  final Product product;

  const ProductDisplay({
    super.key,
    required this.product,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
            top: 30.0,
            right: 0,
            child: Container(
                width: MediaQuery.of(context).size.width / 1.5,
                height: 85,
                padding: const EdgeInsets.only(right: 24),
                decoration: const BoxDecoration(
                    color: darkGrey,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.16),
                          offset: Offset(0, 3),
                          blurRadius: 6.0),
                    ]),
                child: Align(
                  alignment: const Alignment(1, 0),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: '\$ ${product.price}',
                        style: const TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Montserrat",
                            fontSize: 36.0)),
                    const TextSpan(
                        text: '.58',
                        style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Montserrat",
                            fontSize: 18.0))
                  ])),
                ))),
        Align(
          alignment: const Alignment(-1, 0),
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0),
            child: SizedBox(
              height: screenAwareSize(220, context),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 18.0,
                    ),
                    child: Image.network(
                      product.image,
                      fit: BoxFit.contain,
                      height: 230,
                      width: 230,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
