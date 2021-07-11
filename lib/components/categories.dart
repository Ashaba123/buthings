import 'package:flutter/material.dart';

import '../constants.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<String> catergories = [
    "ButterFlies",
    "Books",
    "Stars",
    " KidsDresses",
    "Potted Plants",
    "African Print"
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: SizedBox(
        height: 25,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: catergories.length,
            itemBuilder: (context, index) => buildCategory(index)),
      ),
    );
  }

  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              catergories[index],
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: selectedIndex == index ? kPrimaryColor : Colors.grey),
            ),
            Container(
              margin: EdgeInsets.only(top: kDefaultPadding / 4),
              height: 2,
              width: 30,
              color: selectedIndex == index ? Colors.black : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}
