import 'package:flutter/material.dart';

import '../../../../utilities/app_properties.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: kToolbarHeight),
            child: Column(
              children: <Widget>[
                const CircleAvatar(
                  maxRadius: 48,
                  backgroundImage: AssetImage('assets/background.jpg'),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Rose Helbert',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16.0),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: transparentYellow,
                            blurRadius: 4,
                            spreadRadius: 1,
                            offset: Offset(0, 1))
                      ]),
                  height: 150,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                                icon: Image.asset('assets/icons/wallet.png'),
                                onPressed:
                                    () {} /*Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => WalletPage())),*/
                                ),
                            const Text(
                              'Wallet',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                                icon: Image.asset('assets/icons/truck.png'),
                                onPressed:
                                    () {} /*Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => TrackingPage())),*/
                                ),
                            const Text(
                              'Shipped',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                                icon: Image.asset('assets/icons/card.png'),
                                onPressed:
                                    () {} /*=> Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => PaymentPage())),*/
                                ),
                            const Text(
                              'Payment',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Image.asset('assets/icons/contact_us.png'),
                              onPressed: () {},
                            ),
                            const Text(
                              'Support',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                    title: const Text('Settings'),
                    subtitle: const Text('Privacy and logout'),
                    leading: Image.asset(
                      'assets/icons/settings_icon.png',
                      fit: BoxFit.scaleDown,
                      width: 30,
                      height: 30,
                    ),
                    trailing: const Icon(Icons.chevron_right, color: yellow),
                    onTap:
                        () {} /*=> Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => SettingsPage())),*/
                    ),
                const Divider(),
                ListTile(
                  title: const Text('Help & Support'),
                  subtitle: const Text('Help center and legal support'),
                  leading: Image.asset('assets/icons/support.png'),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: yellow,
                  ),
                ),
                const Divider(),
                ListTile(
                    title: const Text('FAQ'),
                    subtitle: const Text('Questions and Answer'),
                    leading: Image.asset('assets/icons/faq.png'),
                    trailing: const Icon(Icons.chevron_right, color: yellow),
                    onTap:
                        () {} /*=> Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => FaqPage())),*/
                    ),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
