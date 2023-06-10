import 'dart:convert';
import 'package:azure_article/models/article_detail_model.dart';
import 'package:azure_article/models/article_form_model.dart';
import 'package:azure_article/models/article_model.dart';
import 'package:azure_article/models/response_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "서버 연동 URL";

  static const String articles = "articles";
  static const String article = "article";

  static Future<List<ArticleModel>> getArticles(String category) async {
    List<ArticleModel> articleInstances = [];
    final url = Uri.parse('$baseUrl/admin/$articles?category=$category');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      if (jsonResponse['resultList'].length > 0) {
        for (var article in jsonResponse['resultList']) {
          articleInstances.add(ArticleModel.fromJson(article));
        }
      }

      return articleInstances;
    }
    throw Error();
  }

  static Future<ArticleDetailModel> getArticleById(String id) async {
    final url = Uri.parse("$baseUrl/admin/$article?id=$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final article = jsonDecode(utf8.decode(response.bodyBytes));
      // if (article['result']) {
      // dartDev.log(article.toString(), name: "my log");
      return ArticleDetailModel.fromJson(article);
      // }
    }
    throw Error();
  }

  static Future<List<ArticleModel>> searchArticles(String searchWord) async {
    List<ArticleModel> articleInstances = [];
    final url =
        Uri.parse('$baseUrl/admin/$articles/search?searchWord=$searchWord');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      if (jsonResponse['result']) {
        for (var article in jsonResponse['resultList']) {
          articleInstances.add(ArticleModel.fromJson(article));
        }
        return articleInstances;
      }
    }
    throw Error();
  }

  static Future<ResponseModel> postArticle(ArticleFormModel body) async {
    final url = Uri.parse("$baseUrl/$article");
    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(body.toJson()));
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      return ResponseModel.fromJson(jsonResponse);
    }
    throw Error();
  }
}
