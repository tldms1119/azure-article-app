class ArticleModel {
  final String id, title, thumb, category;

  ArticleModel.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        title = json['title'],
        thumb = json['thumb'],
        category = json['category'];
}
