import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

getArticles() async {
  String url =
      "https://newsapi.org/v2/everything?q=bitcoin&apiKey=a041c0eae95c4f24b37f3474c02205b9&pageSize=20";
  var articles = await http.get(url);
  return json.decode(articles.body);
}

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url, forceWebView: true);
  } else {
    throw 'Could not launch $url';
  }
}
