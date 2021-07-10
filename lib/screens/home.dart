import 'package:buthings/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: kDefaultPadding / 2),
              Categories(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: AppBarTitle(),
      actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: kPrimaryColor,
            )),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.shopping_cart,
              color: kPrimaryColor,
            )),
        SizedBox(
          width: kDefaultPadding / 2,
        )
      ],
    );
  }
}

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Text(
        "Bu Things",
        style: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(fontWeight: FontWeight.bold, fontFamily: "Montserrat"),
      ),
    );
  }
}

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
    return SizedBox(
      height: 25,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: catergories.length,
          itemBuilder: (context, index) => buildCategory(index)),
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
