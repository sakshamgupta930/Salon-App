import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/screens/home/categoryScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final firebase = FirebaseFirestore.instance;
  List<dynamic> category = [];
  List<dynamic> banner = [];
  List<dynamic> services = [];

  Future<void> categoryData() async {
    List<dynamic> categoryData = [];

    try {
      QuerySnapshot snapshot = await firebase.collection('categories').get();
      if (snapshot.docs.isNotEmpty) {
        categoryData = snapshot.docs.map((e) => e.data()).toList();
      }
      setState(() {
        category = categoryData;
      });
    } catch (e) {
      print('error ${e.toString()}');
    }
  }

  Future<void> bannerData() async {
    List<dynamic> bannerData = [];
    try {
      QuerySnapshot snapshot = await firebase.collection('banner').get();
      if (snapshot.docs.isNotEmpty) {
        bannerData = snapshot.docs.map((e) => e.data()).toList();
        setState(() {
          banner = bannerData;
        });
      }
    } catch (e) {
      print('error ${e.toString()}');
    }
  }

  Future<void> servicesData() async {
    List<dynamic> servicesData = [];
    try {
      QuerySnapshot snapshot = await firebase.collection('services').get();
      servicesData = snapshot.docs.map((e) => e.data()).toList();
      setState(() {
        services = servicesData;
      });
    } catch (e) {
      print('error ${e.toString()}');
    }
  }

  @override
  void initState() {
    super.initState();
    categoryData();
    bannerData();
    servicesData();
  }

  final auth = FirebaseAuth.instance;
  int initial_index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 20),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  'assets/images/avatar.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Good Morning",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8), fontSize: 13),
                ),
                const Text(
                  "Saksham Gupta",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ],
            ),
            actions: const [
              Icon(
                Icons.notification_important_outlined,
                color: Colors.black,
              ),
              SizedBox(width: 20),
              Icon(
                Icons.rate_review,
                color: Colors.black,
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: MediaQuery.of(context).size.height * .05,
                width: MediaQuery.of(context).size.width * .9,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.search),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Search"),
                      ],
                    ),
                    Icon(Icons.abc)
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
                height: MediaQuery.of(context).size.height * .23,
                width: double.infinity,
                child: PageView.builder(
                    itemCount: banner.length,
                    onPageChanged: (value) {
                      setState(() {
                        initial_index = value;
                      });
                    },
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                banner[index]['image'],
                                fit: BoxFit.fill,
                                width: double.infinity,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Positioned(
                              left: 20,
                              top: 40,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    height: MediaQuery.of(context).size.height *
                                        .03,
                                    width:
                                        MediaQuery.of(context).size.width * .25,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.grey.withOpacity(0.7)),
                                    child: Center(
                                      child: Text(
                                        "${banner[index]['discount']}% OFF",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    banner[index]['title'],
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    banner[index]['description'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    banner[index]['valid'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    })),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Featured Services",
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: MediaQuery.of(context).size.height * .20,
              width: double.infinity,
              child: ListView.builder(
                  itemCount: services.length,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Material(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Container(
                          width: MediaQuery.of(context).size.width * .35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey.shade100),
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .13,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                  child: Image(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      services[index]['image'],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    Text(
                                      services[index]['name'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Text(
                                          "Rs ${services[index]['offerPrice']}",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          "Rs ${services[index]['mrpPrice']}",
                                          style: const TextStyle(
                                            fontSize: 10,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Categories",
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const CategoryScreen(),
                        ),
                      );
                    },
                    child: const Text("View all"),
                  ),
                ],
              ),
            ),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: category.length <= 6 ? category.length : 6,
              itemBuilder: (BuildContext context, int index) {
                return CategoryCard(
                  name: category[index]['name'],
                  image: category[index]['image'],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
