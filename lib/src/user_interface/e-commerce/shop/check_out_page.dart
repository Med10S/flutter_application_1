import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/dimention.dart';
import 'package:get/get.dart';

import '../../../../utilities/app_properties.dart';
import '../../../../utilities/models/cartProduct.dart';
import '../../../../utilities/status_bar_controller.dart';
import '../../../admin_interface/e-admin/ProductController.dart';
import '../../../authentification/controllers/profil_controller.dart';
import '../../../authentification/models/user_model.dart';
import '../payment/payment_controller.dart';
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
  final payementController = Get.put(PaymentController());
  final PaymentController paymentController2 = Get.put(PaymentController());
  String? location;
  List<CartProduct>? cartproducts;
  UserModel? _userModel;
  final statusController = Get.put(Statusbarcontroller());
  Brightness platformBrightness = Brightness.light;

  Future<void> userInformation() async {
    final userModel = await ProfileController().getUserData();
    setState(() {
      _userModel = userModel;
    });
  }

  @override
  void initState() {
    super.initState();
    userInformation();
    statusController.getPlatformBrightness().then((brightness) {
      setState(() {
        platformBrightness = brightness;
        statusController.setStatusBarColor(
            platformBrightness,
            const Color.fromARGB(255, 236, 236, 236),
            const Color.fromRGBO(14, 77, 89, 1));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool soldeVerficarion = false;

    Widget checkOutButton = InkWell(
      onTap: () async {
        soldeVerficarion = false;
        location = await CustomPopup.show(context);
        if (location != null && cartproducts!.isNotEmpty) {
          soldeVerficarion =
              payementController.checkSolde(_userModel!.points!, cartproducts);
          debugPrint('solde verification :$soldeVerficarion');
          if (soldeVerficarion) {
            Get.snackbar("solde verification", "opperation reusite",
                borderRadius: 20,
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: const Color.fromARGB(255, 112, 243, 121),
                colorText: Colors.black);
            payementController
                .enregisterCommande(_userModel!, cartproducts)
                .then((value) {
              if (value) {
                payementController
                    .deductionSolde(cartproducts, _userModel!)
                    .then((value) {
                  debugPrint('deduction verification :$value');
                  setState(() {
                    payementController
                        .saveTransaction(location!, _userModel!, cartproducts,
                            soldeVerficarion)
                        .then((value) {
                      debugPrint('transaction verfication save :$value');
                      if (value) {
                        Get.snackbar(
                            "Success", "votre commande est enregistrer",
                            icon: const Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.green.withOpacity(0.1),
                            colorText: Colors.green);
                      } else {
                        Get.snackbar("Erreur", "Erreur de transaction",
                            snackPosition: SnackPosition.BOTTOM,
                            icon: const Icon(
                              Icons.warning,
                              color: Colors.red,
                            ),
                            backgroundColor:
                                const Color.fromARGB(255, 175, 76, 76)
                                    .withOpacity(0.1),
                            colorText: const Color.fromARGB(255, 0, 0, 0));
                      }
                    });
                  });
                });
              }
            });
          } else {
            Get.snackbar("solde verification", "solde de points insuffisant ",
                icon: const Icon(
                  Icons.warning,
                  color: Colors.red,
                ),
                borderRadius: 20,
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: const Color.fromARGB(255, 255, 59, 59),
                colorText: Colors.black);
          }
        } else {
          Get.snackbar("Erreur", "aucun produits",
              icon: const Icon(
                Icons.warning,
                color: Colors.red,
              ),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor:
                  const Color.fromARGB(255, 255, 0, 0).withOpacity(0.1),
              colorText: const Color.fromARGB(255, 0, 0, 0));
        }
      },
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

    Widget subTot = Obx(() => Text(
          cartproducts!.isNotEmpty
              ? '${paymentController2.totalPrice.value.toStringAsFixed(2)} points'
              : '0 points',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ));

    return GetX<ProductController>(
      init: ProductController(),
      builder: (cartController) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: const IconThemeData(color: darkGrey),
          actions: <Widget>[
            IconButton(
              icon: Image.asset('assets/icons/denied_wallet.png'),
              onPressed: () {
                // Faites quelque chose lorsque l'icône est cliquée
              },
            )
          ],
          title: const Text(
            'Checkout',
            style: TextStyle(
              color: darkGrey,
              fontWeight: FontWeight.w500,
              fontSize: 18.0,
            ),
          ),
        ),
        body: FutureBuilder<List<CartProduct>>(
          future: productController.getCartProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              cartproducts = snapshot.data!;

              return LayoutBuilder(
                builder: (_, constraints) => SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          height: 57,
                          color: yellow,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  const Text(
                                    'subtotal',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    '${cartproducts!.length} items',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  const Text(
                                    'Total :',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  subTot
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  const Text(
                                    'votre solde :',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    '${_userModel?.points!.toStringAsFixed(2) ?? "Loading..."} points',
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 300,
                          child: Scrollbar(
                            child: ListView.builder(
                              itemBuilder: (_, index) => ShopItemList(
                                cartproducts![index],
                                onRemove: () {
                                  setState(() {
                                    productController
                                        .removeProductFromSharedPreferences(
                                            cartproducts![index].productId);
                                  });
                                },
                                cartproducts,
                              ),
                              itemCount: cartproducts!.length,
                            ),
                          ),
                        ),
                        Container(
                          width: Dimenssion.screenWidth,
                          child: const Text(
                            'Payment',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: darkGrey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).padding.bottom == 0
                                  ? 20
                                  : MediaQuery.of(context).padding.bottom,
                            ),
                            child: checkOutButton,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Une erreur s\'est produite : ${snapshot.error}');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
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
