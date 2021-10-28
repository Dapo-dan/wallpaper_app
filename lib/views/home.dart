import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaper_app/data/data.dart';
import 'package:wallpaper_app/model/categories_model.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/widgets/widget.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CategoriesModel> categories = [];
  List <WallpaperModel> wallpapers = [];

  getTrendingWallpapers () async{
    var response = await http.get(Uri.parse("https://api.pexels.com/v1/curated?per_page=1"),
    headers: {
      "Authorization" : apiKey
    });
    print(response.body.toString());

    Map <String,dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      //print(element);
      WallpaperModel wallpaper_Model = WallpaperModel(photographer_url: '', photographer: '', src: null, photographer_id: null);
      wallpaper_Model = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaper_Model);
      //print(photosModel.toString()+ "  "+ photosModel.src.portrait);
    });

    setState(() {});
  }

  @override
  void initState(){
    getTrendingWallpapers ();
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: brandName(),
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: const LinearGradient(
                colors: [Color(0xffddd6f3),Color(0xfffaaca8)]),
              ),
              padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 20.0),
              margin: const EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 0.0),
              child: Row(
                children: const <Widget>[
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'search',
                          border: InputBorder.none),
                    ),
                  ),
                  Icon(Icons.search),
                ],
              ),
            ),
            const SizedBox(height: 16,),
            Container(
              height: 88,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 24),
              shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index){
                  return CategoriesTile(
                    title: categories[index].categoriesName,
                    imgUrl: categories[index].imgUrl ,);
                }),
            ),
            const SizedBox(height: 16,),
            wallpapersList(wallpapers: wallpapers, context: context)
          ],
        ),
      ),
    );
  }
}

class CategoriesTile extends StatelessWidget {
  final String imgUrl, title;
  CategoriesTile({required this.title, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 4),
      child: Stack(children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(imgUrl, height: 50, width: 100, fit: BoxFit.fill,),
        ),
        Container(
            height: 50, width: 100,
          color: Colors.black26,
          alignment: Alignment.center,
          child: Text (title, style: TextStyle(color: Colors.white, fontSize: 16),)
        )
      ],),
    );
  }
}


