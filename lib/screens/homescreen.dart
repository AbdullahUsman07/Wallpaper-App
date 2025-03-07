import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List images = [];
  int page = 1;

  @override
  void initState() {
    super.initState();
    fetchimages();
  }

  fetchimages() async {
    await http
        .get(
          Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
          headers: {
            'Authorization':
                'OexyxXuTN6BwrCVATr681z6xvs48aigU32GXhYCBMd0Hp2xLQ4HN0QQ9',
          },
        )
        .then((value) {
          Map result = jsonDecode(value.body);
          setState(() {
            images = result['photos'];
          });
          print(images.length);
        });
  }

  loadImages() async {

    setState(() {
      page = page +1;
    });
    String url =
        'https://api.pexels.com/v1/curated?per_page=80&page=' + page.toString();

    await http.get(
      Uri.parse(url),
      headers: {
        'Authorization':
            'OexyxXuTN6BwrCVATr681z6xvs48aigU32GXhYCBMd0Hp2xLQ4HN0QQ9',
      },
    ).then((value){
      Map result = jsonDecode(value.body);
      setState(() {
        images.addAll(result['photos']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: GridView.builder(
                itemCount: images.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  childAspectRatio: 2 / 3,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.white,
                    child: Image.network(
                      images[index]['src']['tiny'],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
          ),
          InkWell(
            onTap: (){
              loadImages();
            },
            child: Container(
              height: 60,
              width: double.infinity,
              child: Center(
                child: const Text(
                  'Load More',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
