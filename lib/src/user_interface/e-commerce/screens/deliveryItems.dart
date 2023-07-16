import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/authentification/controllers/profil_controller.dart';
import 'package:get/get.dart';

import '../../../../utilities/app_properties.dart';
import '../../../../utilities/models/cartProduct.dart';
import '../../../../utilities/status_bar_controller.dart';
import '../../../authentification/models/user_model.dart';
import '../main/main_page_store.dart';
import '../payment/payment_controller.dart';
import '../shop/components/shop_item_list.dart';

class DeliveryItems extends StatefulWidget {
  const DeliveryItems({super.key});

  @override
  State<DeliveryItems> createState() => _DeliveryItemsState();
}

class _DeliveryItemsState extends State<DeliveryItems> {
  final profileController = Get.put(ProfileController());
  final paymentController = Get.put(PaymentController());
  final statusController = Get.put(Statusbarcontroller());
  Brightness platformBrightness = Brightness.light;
  UserModel? _userModel;

  Future<void> userInformation() async {
    final userModel = await profileController.getUserData();
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: const IconThemeData(color: darkGrey),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Retour à l'écran précédent
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (_) => const EcommerceMainPage(), //LoginScreen(),
                  ));
            },
          ),
          title: const Text(
            'Nouvelles commandes.',
            style: TextStyle(
              color: darkGrey,
              fontWeight: FontWeight.w500,
              fontSize: 18.0,
            ),
          ),
        ),
        body: SizedBox(
          height: 300,
          child: FutureBuilder<List<CartProduct>>(
            future: paymentController.getCommandsByStatus(
                'lDXAomyaHiPiGVx4lHEa',
                'attente'), // Replace 'userId' and 'status' with your actual values
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                final deliveryItems = snapshot.data!;
                print('delivery items are : ${deliveryItems.length}');
                return Scrollbar(
                  child: ListView.builder(
                    itemBuilder: (_, index) => ShopItemList(
                      deliveryItems[index],
                      fromcart: false,
                      onRemove: () {
                        setState(() {
                          // Perform removal logic
                        });
                      },
                      deliveryItems,
                    ),
                    itemCount: deliveryItems.length,
                  ),
                );
              } else {
                return const Text('No delivery items found.');
              }
            },
          ),
        ),
      ),
    );
  }
}
