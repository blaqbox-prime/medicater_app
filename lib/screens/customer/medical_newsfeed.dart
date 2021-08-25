import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medicater_app/models/article.dart';
import 'package:http/http.dart' as http;

class NewsFeedScreen extends StatefulWidget {
  NewsFeedScreen({Key? key}) : super(key: key);

  @override
  _NewsFeedScreenState createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  final apiKey = "0fc54a62abe94c2fbd3d7fb9beb270c7";
  List<Article>? articleList;
  @override
  void initState() {
    //articleList = getArticles(apiKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        shrinkWrap: true,
        children: [
          RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: 'Medical',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.black87,
                      fontSize: 38)),
              TextSpan(
                  text: '\nNews Feed',
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.blueGrey,
                      fontSize: 34)),
            ]),
            softWrap: true,
            textAlign: TextAlign.start,
          ),
          //---
          SizedBox(height: 25),
          //--
          FutureBuilder(
              future: getArticles(apiKey),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var articles = snapshot.data as List<Article>;
                  return ListView.builder(
                      physics: ScrollPhysics(),
                      itemCount: articles.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return _buildArticleCard(articles[index]);
                      });
                }
                if (snapshot.hasError) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      SvgPicture.asset("assets/images/undraw_medical_care.svg",
                          height: 150),
                      SizedBox(
                        height: 25,
                      ),
                      Text("News Feed currently unavailable"),
                    ],
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              })
        ],
      )),
    );
  }

  Future<List<Article>> getArticles(String apiKey) async {
    List<Article> articles = [];
    var response = await http.get(
        Uri(
            path:
                "https://newsapi.org/v2/top-headlines?country=us&category=health&apiKey=$apiKey"),
        headers: {"x-api-key": apiKey});
    var data = jsonDecode(response.body);
    data["articles"].forEach((article) {
      Article newArticle = Article.fromMap(article);
      if (newArticle.urlToImage != null &&
          newArticle.description != null &&
          newArticle.author != null) {
        articles.add(newArticle);
      }
    });
    return articles;
  }

  _buildArticleCard(Article article) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                article.urlToImage!,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              article.title!,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 5),
            Text(
              article.description!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 5),
            Text(
              article.author!,
              style: TextStyle(fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
