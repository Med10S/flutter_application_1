import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/dimention.dart';
import 'package:get/get.dart';

import '../../../../utilities/app_properties.dart';
import '../../../../utilities/models/cartProduct.dart';
import '../../../admin_interface/e-admin/ProductController.dart';
import 'components/check_passage.dart';
import 'components/shop_item_list.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key});

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  SwiperController swiperController = SwiperController();
  final productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    Widget checkOutButton = InkWell(
      onTap: () => CustomPopup.show(context),
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width / 1.5,
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
          child: Text("Check Out",
              style: TextStyle(
                  color: Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0)),
        ),
      ),
    );

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: const IconThemeData(color: darkGrey),
          actions: <Widget>[
            IconButton(
                icon: Image.asset('assets/icons/denied_wallet.png'),
                onPressed:
                    () {} /*Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => UnpaidPage())),*/
                )
          ],
          title: const Text(
            'Checkout',
            style: TextStyle(
                color: darkGrey, fontWeight: FontWeight.w500, fontSize: 18.0),
          ),
        ),
        body: FutureBuilder<List<CartProduct>>(
          future: productController.getCartProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<CartProduct> products = snapshot.data!;

              return LayoutBuilder(
                builder: (_, constraints) => SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          height: 48.0,
                          color: yellow,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text(
                                'Subtotal',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              Text(
                                products.length.toString() + ' items',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 300,
                          child: Scrollbar(
                            child: ListView.builder(
                              itemBuilder: (_, index) => ShopItemList(
                                products[index],
                                onRemove: () {
                                  setState(() {
                                    productController
                                        .removeProductFromSharedPreferences(
                                            products[index].productId);
                                  });
                                },
                              ),
                              itemCount: products.length,
                            ),
                          ),
                        ),
                        Container(
                          width: Dimenssion.screenWidth,
                          child: Text(
                            'Payment',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                color: darkGrey,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).padding.bottom ==
                                        0
                                    ? 20
                                    : MediaQuery.of(context).padding.bottom),
                            child: checkOutButton,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Une erreur s\'est produite : ${snapshot.error}');
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }
}

class Scroll extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    LinearGradient grT = const LinearGradient(
        colors: [Colors.transparent, Colors.black26],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter);
    LinearGradient grB = const LinearGradient(
        colors: [Colors.transparent, Colors.black26],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter);

    canvas.drawRect(
        Rect.fromLTRB(0, 0, size.width, 30),
        Paint()
          ..shader = grT.createShader(Rect.fromLTRB(0, 0, size.width, 30)));

    canvas.drawRect(Rect.fromLTRB(0, 30, size.width, size.height - 40),
        Paint()..color = const Color.fromRGBO(50, 50, 50, 0.4));

    canvas.drawRect(
        Rect.fromLTRB(0, size.height - 40, size.width, size.height),
        Paint()
          ..shader = grB.createShader(
              Rect.fromLTRB(0, size.height - 40, size.width, size.height)));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
