import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../../../utilities/app_properties.dart';
import '../../../../../utilities/models/cartProduct.dart';
import '../../../../admin_interface/e-admin/ProductController.dart';
import '../../product/components/color_list.dart';
import '../../product/components/shop_product.dart';

class ShopItemList extends StatefulWidget {
  final CartProduct product;
  final VoidCallback onRemove;

  const ShopItemList(this.product, {super.key, required this.onRemove});

  @override
  _ShopItemListState createState() => _ShopItemListState();
}

class _ShopItemListState extends State<ShopItemList> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      height: 130,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: const Alignment(0, 0.8),
            child: Container(
                height: 100,
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: shadow,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(top: 12.0, right: 12.0),
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                width: 110,
                                padding: const EdgeInsets.only(left: 32.0),
                                child: Text(
                                  widget.product.productName,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: darkGrey,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                width: 160,
                                padding: const EdgeInsets.only(
                                    left: 32.0, top: 8.0, bottom: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    const ColorOption(Colors.red),
                                    Text(
                                      '\$${widget.product.productPrice}',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: darkGrey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Theme(
                          data: ThemeData(
                              hintColor: Colors.black,
                              textTheme: TextTheme(
                                titleLarge: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                bodyLarge: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 12,
                                  color: Colors.grey[400],
                                ),
                              )),
                          child: NumberPicker(
                            value: widget.product.quantity,
                            minValue: 1,
                            maxValue: widget.product.stock,
                            onChanged: (value) {
                              setState(() {
                                widget.product.quantity = value;
                                quantity = value;
                                updateQuantite(
                                    widget.product.productId, quantity);
                              });
                            },
                          ))
                    ])),
          ),
          Positioned(
              top: 5,
              child: ShopProductDisplay(
                widget.product,
                onPressed: widget.onRemove,
              )),
        ],
      ),
    );
  }

  Future<void> updateQuantite(String productId, int quantite) async {
    final productController = Get.put(ProductController());
    await productController.updateProductFromSharedPreferences(
        productId, quantite);
  }
}
