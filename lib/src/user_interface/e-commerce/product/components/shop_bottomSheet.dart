import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/admin_interface/e-admin/ProductController.dart';
import 'package:get/get.dart';

import '../../../../../utilities/app_properties.dart';
import '../../../../../utilities/models/cartProduct.dart';
import '../../../../../utilities/models/product.dart';
import 'shop_product.dart';

class ShopBottomSheet extends StatefulWidget {
  const ShopBottomSheet({super.key});

  @override
  _ShopBottomSheetState createState() => _ShopBottomSheetState();
}

class _ShopBottomSheetState extends State<ShopBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductController());

    Widget confirmButton = InkWell(
      onTap: () async {
        Navigator.of(context).pop();
        /*Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => CheckOutPage()));*/
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom == 0
                ? 20
                : MediaQuery.of(context).padding.bottom),
        decoration: BoxDecoration(
            gradient: mainButton,
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.16),
                offset: Offset(0, 5),
                blurRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.circular(9.0)),
        child: const Center(
            child: Text("Confirm",
                style: TextStyle(
                    color: Color(0xfffefefe),
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    fontSize: 20.0))),
      ),
    );

    return Container(
        decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.9),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(24), topLeft: Radius.circular(24))),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Image.asset(
                  'assets/box.png',
                  height: 24,
                  width: 24.0,
                  fit: BoxFit.cover,
                ),
                onPressed: () {},
                iconSize: 48,
              ),
            ),
            FutureBuilder<List<CartProduct>>(
              future: productController.getCartProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Lorsque le Future est en cours de chargement
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  // Lorsqu'une erreur s'est produite lors de la récupération des données
                  return Text('Une erreur s\'est produite : ${snapshot.error}');
                } else {
                  // Lorsque les données ont été récupérées avec succès
                  List<CartProduct> products = snapshot.data!;

                  return SizedBox(
                    height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: products.length,
                      itemBuilder: (_, index) {
                        return Row(
                          children: <Widget>[
                            ShopProduct(
                              products[index],
                              onRemove: () {
                                setState(() {
                                  //products.remove(products[index]);
                                  /*productController.clearCartProducts();*/
                                  productController
                                      .removeProductFromSharedPreferences(
                                          products[index].productId);
                                  print(
                                      'product removed left : ${products.length}');
                                });
                              },
                            ),
                            index == 4
                                ? const SizedBox()
                                : Container(
                                    width: 2,
                                    height: 200,
                                    color: const Color.fromRGBO(
                                        100, 100, 100, 0.1),
                                  ),
                          ],
                        );
                      },
                    ),
                  );
                }
              },
            ),
            confirmButton
          ],
        ));
  }
}
