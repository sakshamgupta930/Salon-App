import 'package:flutter/material.dart';
import "package:cloud_firestore/cloud_firestore.dart";

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final firebase = FirebaseFirestore.instance;
  List<dynamic> category = [];

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
      print(category);
    } catch (e) {
      print('Saksham ${e.toString()}');
    }
  }

  @override
  void initState() {
    super.initState();
    categoryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Category",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: category.length,
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
      ),
    );
  }
}

class CategoryCard extends StatefulWidget {
  final String name;
  final String image;

  const CategoryCard({
    super.key,
    required this.name,
    required this.image,
  });

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: MediaQuery.of(context).size.height * .09,
            width: MediaQuery.of(context).size.height * .09,
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.image),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          widget.name,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
