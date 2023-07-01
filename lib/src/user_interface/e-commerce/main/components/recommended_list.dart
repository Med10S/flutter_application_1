import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../../utilities/app_properties.dart';
import '../../../../../utilities/models/product.dart';
import '../../product/product_page.dart';

// ignore: must_be_immutable
class RecommendedList extends StatelessWidget {
  List<Product> products = [
    Product(
        id: "123",
        image: 'assets/bag_1.png',
        name: 'Bag',
        description: 'Beautiful bag',
        price: 2.33),
    Product(
        id: "123",
        image: 'assets/cap_5.png',
        name: 'Cap',
        description: 'Cap with beautiful design',
        price: 10),
    Product(
        id: "123",
        image: 'assets/jeans_1.png',
        name: 'Jeans',
        description: 'Jeans for you',
        price: 20),
    Product(
        id: "123",
        image: 'assets/womanshoe_3.png',
        name: 'Woman Shoes',
        description: 'Shoes with special discount',
        price: 30),
    /*Product('assets/bag_10.png', 'Bag Express', 'Bag for your shops', 40),
    Product('assets/jeans_3.png', 'Jeans', 'Beautiful Jeans', 102.33),
    Product('assets/ring_1.png', 'Silver Ring', 'Description', 52.33),
    Product('assets/shoeman_7.png', 'Shoes', 'Description', 62.33),
    Product('assets/headphone_9.png', 'Headphones', 'Description', 72.33),
  */
  ];

  RecommendedList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              IntrinsicHeight(
                child: Container(
                  margin: const EdgeInsets.only(left: 16.0, right: 8.0),
                  width: 4,
                  color: mediumYellow,
                ),
              ),
              const Center(
                  child: Text(
                'Recommended',
                style: TextStyle(
                    color: darkGrey,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              )),
            ],
          ),
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
            child: StaggeredGridView.countBuilder(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              crossAxisCount: 4,
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) => new ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => ProductPage(product: products[index]))),
                  child: Container(
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                            colors: [
                              Colors.grey.withOpacity(0.3),
                              Colors.grey.withOpacity(0.7),
                            ],
                            center: const Alignment(0, 0),
                            radius: 0.6,
                            focal: const Alignment(0, 0),
                            focalRadius: 0.1),
                      ),
                      child: Hero(
                          tag: products[index].image,
                          child: Image.asset(products[index].image))),
                ),
              ),
              staggeredTileBuilder: (int index) =>
                  StaggeredTile.count(2, index.isEven ? 3 : 2),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            ),
          ),
        ),
      ],
    );
  }
}
