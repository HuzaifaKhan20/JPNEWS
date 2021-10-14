import 'dart:convert';

import 'package:jpnews/model/article_model.dart';
import 'package:http/http.dart';

//Topstories

class TopstoriesApi {
  final topUrl =
      "https://newsapi.org/v2/everything?q=bitcoin&apiKey=d75af5401c2b4da19cb581d3bdf6fc5c";

  Future<List<Article>> getArticle() async {
    Response res = await get(Uri.parse(topUrl));

    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);

      List<dynamic> body = json['articles'];

      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();
      return articles;
    } else {
      throw ("Not Found");
    }
  }
}

// stocksApi
class StockApi {
  final stockUrl =
      "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=d75af5401c2b4da19cb581d3bdf6fc5c";

  Future<List<Article>> getArticle() async {
    Response res = await get(Uri.parse(stockUrl));

    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);

      List<dynamic> body = json['articles'];

      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();

      return articles;
    } else {
      throw ("Not Found");
    }
  }
}

// PopularApi
class PopularApi {
  final popularUrl =
      "https://newsapi.org/v2/top-stocks?country=us&category=science&apiKey=d75af5401c2b4da19cb581d3bdf6fc5c";

  Future<List<Article>> getArticle() async {
    Response res = await get(Uri.parse(popularUrl));

    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);

      List<dynamic> body = json['articles'];

      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();

      return articles;
    } else {
      throw ("Not Found");
    }
  }
}

// SportsApi
class SportsApi {
  final sportUrl =
      "https://newsapi.org/v2/top-stocks?country=us&category=sports&apiKey=d75af5401c2b4da19cb581d3bdf6fc5c";

  Future<List<Article>> getArticle() async {
    Response res = await get(Uri.parse(sportUrl));

    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);

      List<dynamic> body = json['articles'];

      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();

      return articles;
    } else {
      throw ("Not Found");
    }
  }
}

// apple
class AppleApi {
  final appleUrl =
      "https://newsapi.org/v2/everything?q=apple&from=2021-10-07&to=2021-10-07&sortBy=popularity&apiKey=d75af5401c2b4da19cb581d3bdf6fc5c";

  Future<List<Article>> getArticle() async {
    Response res = await get(Uri.parse(appleUrl));

    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);

      List<dynamic> body = json['articles'];

      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();

      return articles;
    } else {
      throw ("Not Found");
    }
  }
}

// TechnologyApi
class TechnologyApi {
  final techUrl =
      "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=d75af5401c2b4da19cb581d3bdf6fc5c";

  Future<List<Article>> getArticle() async {
    Response res = await get(Uri.parse(techUrl));

    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);

      List<dynamic> body = json['articles'];

      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();

      return articles;
    } else {
      throw ("Not Found");
    }
  }
}

// Entertainment
class EntertainmentApi {
  final enterUrl =
      "https://newsapi.org/v2/top-stocks?country=us&category=entertainment&apiKey=d75af5401c2b4da19cb581d3bdf6fc5c";

  Future<List<Article>> getArticle() async {
    Response res = await get(Uri.parse(enterUrl));

    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);

      List<dynamic> body = json['articles'];

      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();

      return articles;
    } else {
      throw ("Not Found");
    }
  }
}

// Health
class HealthApi {
  final healthUrl =
      "https://newsapi.org/v2/top-stocks?country=us&category=health&apiKey=d75af5401c2b4da19cb581d3bdf6fc5c";

  Future<List<Article>> getArticle() async {
    Response res = await get(Uri.parse(healthUrl));

    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);

      List<dynamic> body = json['articles'];

      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();

      return articles;
    } else {
      throw ("Not Found");
    }
  }
}

// tesla
class TeslaApi {
  final teslaUrl =
      "https://newsapi.org/v2/everything?q=tesla&from=2021-09-08&sortBy=publishedAt&apiKey=d75af5401c2b4da19cb581d3bdf6fc5c";

  Future<List<Article>> getArticle() async {
    Response res = await get(Uri.parse(teslaUrl));

    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);

      List<dynamic> body = json['articles'];

      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();

      return articles;
    } else {
      throw ("Not Found");
    }
  }
}
