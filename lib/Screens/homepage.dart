// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:antoh/Screens/admin.dart';
import 'package:provider/provider.dart';
import 'package:antoh/provider/UserProvider.dart';
import 'package:antoh/screens/categories.dart';
import 'package:antoh/screens/login_screen.dart';
import 'package:antoh/screens/saved.dart';
import 'package:antoh/screens/search.dart';
import 'package:flutter/material.dart';

import '../data/data_home.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'real_estate';
  static const themeColor = Colors.black;
  //Color(0xFFA95AEA);
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<UserProvider>(context, listen: false).initFirebase();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      bottomNavigationBar: BottomBarWidget(),
      body: Padding(
        padding: EdgeInsets.only(top: 10, left: 20),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Antoh",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 25),
                      ),
                      ActionChip(
                          backgroundColor: Colors.white10,
                          label: Row(children: [
                            Icon(
                              Icons.logout_outlined,
                              color: HomePage.themeColor,
                              size: 30,
                            ),
                            Text(
                              "log Out",
                              style: TextStyle(color: HomePage.themeColor),
                            )
                          ]),
                          onPressed: () {
                            userProvider.signOut;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                            );
                          })
                    ],
                  )),
              SizedBox(
                height: 20,
              ),
              Padding(padding: EdgeInsets.only(right: 20), child: searchBar),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {

                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) =>
                              admin()));
                },
                child: Text(
                  "RENT",
                  style: TextStyle(color: Colors.grey[500]),
                ),
                // color: Colors.yellow[300],
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(18.0),
                // ),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Categories",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 15),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Categories(),
                              ),
                            );
                          },
                          child: Text(
                            "See All \u203A",
                            style: TextStyle(color: HomePage.themeColor),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      itemBuilder: (context, position) {
                        return CategoryWidget(categoryList[position]);
                      },
                      itemCount: categoryList.length,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Nearby",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 15),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Search(),
                              ),
                            );
                          },
                          child: Text(
                            "See All \u203A",
                            style: TextStyle(color: HomePage.themeColor),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      itemBuilder: (context, position) {
                        return NearbyWidget(nearbyList[position]);
                      },
                      itemCount: nearbyList.length,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Explore",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 15),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Search(),
                              ),
                            );
                          },
                          child: Text(
                            "See All \u203A",
                            style: TextStyle(color: HomePage.themeColor),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      itemBuilder: (context, position) {
                        return NearbyWidget(exploreList[position]);
                      },
                      itemCount: exploreList.length,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomBarWidget extends StatefulWidget {
  const BottomBarWidget({Key? key}) : super(key: key);

  @override
  _BottomBarWidgetState createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  int _selectedIndex = 0;
  Color selectedColor = HomePage.themeColor;
  Color unSelectedColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 10),
        height: 60.0,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              ),
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0)),
            color: Colors.white),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          InkWell(
            onTap: () => _onTap(0),
            child: Column(
              children: [
                Icon(Icons.home,
                    color:
                        _selectedIndex == 0 ? selectedColor : unSelectedColor),
                Text("Home",
                    style: TextStyle(
                        color: _selectedIndex == 0
                            ? selectedColor
                            : unSelectedColor))
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Search(),
                ),
              );
            },
            child: Column(
              children: [
                Icon(Icons.search,
                    color:
                        _selectedIndex == 1 ? selectedColor : unSelectedColor),
                Text("Search",
                    style: TextStyle(
                        color: _selectedIndex == 1
                            ? selectedColor
                            : unSelectedColor))
              ],
            ),
          ),
          InkWell(
            onTap: () {
              _showBottomSheet();
            },
            child: Column(
              children: [
                Icon(Icons.favorite_border,
                    color:
                        _selectedIndex == 2 ? selectedColor : unSelectedColor),
                Text("Saved",
                    style: TextStyle(
                        color: _selectedIndex == 2
                            ? selectedColor
                            : unSelectedColor))
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Categories(),
                ),
              );
            },
            child: Column(
              children: [
                Icon(Icons.category_outlined,
                    color:
                        _selectedIndex == 3 ? selectedColor : unSelectedColor),
                Text("Categories",
                    style: TextStyle(
                        color: _selectedIndex == 3
                            ? selectedColor
                            : unSelectedColor))
              ],
            ),
          ),
        ]));
  }

  void _onTap(int tapIndex) {
    setState(() {
      _selectedIndex = tapIndex;
    });
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        builder: (BuildContext context) {
          return Wrap(
            children: [
              Saved(),
            ],
          );
        });
  }
}

var searchBar = Container(
    height: 45,
    child: TextField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        hintText: 'Search',
        hintStyle: TextStyle(fontSize: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        contentPadding: EdgeInsets.all(16),
        fillColor: Color(0xffdddddd),
      ),
    ));

// var buyAndRent = Row(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: [
//     ElevatedButton(
//       onPressed: () {},
//       child: Text(
//         "BUY",
//         style: TextStyle(color: Colors.grey[500]),
//       ),
//       // color: Colors.green[300],
//       // shape: RoundedRectangleBorder(
//       //   borderRadius: BorderRadius.circular(18.0),
//       // ),
//     ),
//     SizedBox(width: 10),
//
//   ],
// );

class CategoryWidget extends StatelessWidget {
  final Category category;

  CategoryWidget(this.category);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: Container(
              width: 100.0,
              height: 120.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage(category.image)),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )),
        ),

        ElevatedButton(
          onPressed: () {

            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) =>
                        admin()));
          },
          child: Text(
            "RENT",
            style: TextStyle(color: Colors.grey[500]),
          ),
          // color: Colors.yellow[300],
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(18.0),
          // ),
        ),
        Positioned(
          left: 10,
          bottom: 10,
          child: Text(
            category.name,
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 12, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class NearbyWidget extends StatelessWidget {
  final String image;

  NearbyWidget(this.image);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Hero(
        tag: image,
        child: Padding(
          padding: EdgeInsets.only(right: 10),
          child: Container(
              width: 210.0,
              height: 120.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage(image)),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )),
        ),
      ),
    );
  }
}

class ExploreWidget extends StatelessWidget {
  final String image;

  ExploreWidget(this.image);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Hero(
        tag: image,
        child: Padding(
          padding: EdgeInsets.only(right: 10),
          child: Container(
              width: 210.0,
              height: 120.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage(image)),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )),
        ),
      ),
    );
  }
}
