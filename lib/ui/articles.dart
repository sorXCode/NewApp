import 'package:flutter/material.dart';
import 'package:news_app/network/network.dart';

class Articles extends StatefulWidget {
  Articles({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ArticlesState createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {
  var articles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: articlesList(),
    );
  }

  articlesList() {
    return Container(
      child: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 1));
          setState(() {
            
          });
        },
        child: FutureBuilder(
            future: getArticles(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                articles = snapshot.data['articles'];
                return ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, int) {
                    return _articleEntry(articles[int]);
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }

  _articleEntry(Map article) {
    return GestureDetector(
      onTap: () {
        launchURL(article['url']);
      },
      child: ListTile(
        leading: Image.network(
          article['urlToImage'],
          width: 100,
        ),
        title: Text(article['title']),
        subtitle: Text(
          article['description'],
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        isThreeLine: true,
      ),
    );
  }
}
