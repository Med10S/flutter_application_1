import 'package:flutter/material.dart';
import '../../../../../utilities/models/category.dart';
import 'category_card.dart';
import 'recommended_list.dart';

// ignore: must_be_immutable
class TabView extends StatelessWidget {
  List<Category> categories = [
    Category(
      const Color.fromARGB(255, 165, 84, 241),
      const Color.fromARGB(255, 255, 189, 227),
      'Tableaux',
      'assets/tableau1.jpg',
    ),
    Category(
      const Color(0xffF749A2),
      const Color(0xffFF7375),
      'Plantes',
      'assets/jeans_5.png',
    ),
    Category(
      const Color(0xff00E9DA),
      const Color(0xff5189EA),
      'Fashion',
      'assets/jeans_5.png',
    ),
    Category(
      const Color(0xffAF2D68),
      const Color(0xff632376),
      'Home',
      'assets/jeans_5.png',
    ),
    Category(
      const Color(0xff36E892),
      const Color(0xff33B2B9),
      'Beauty',
      'assets/jeans_5.png',
    ),
    Category(
      const Color(0xffF123C4),
      const Color(0xff668CEA),
      'Appliances',
      'assets/jeans_5.png',
    ),
  ];

  final TabController tabController;

  TabView({
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height / 9);
    return TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                  margin: const EdgeInsets.all(8.0),
                  height: MediaQuery.of(context).size.height / 9,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (_, index) => CategoryCard(
                            category: categories[index],
                          ))),
              const SizedBox(
                height: 16.0,
              ),
              Flexible(child: RecommendedList()),
            ],
          ),
          Column(children: <Widget>[
            const SizedBox(
              height: 16.0,
            ),
            Flexible(child: RecommendedList())
          ]),
          Column(children: <Widget>[
            const SizedBox(
              height: 16.0,
            ),
            Flexible(child: RecommendedList())
          ]),
          Column(children: <Widget>[
            const SizedBox(
              height: 16.0,
            ),
            Flexible(child: RecommendedList())
          ]),
          Column(children: <Widget>[
            const SizedBox(
              height: 16.0,
            ),
            Flexible(child: RecommendedList())
          ]),
        ]);
  }
}
