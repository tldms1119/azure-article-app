class ArticleDetailModel {
  final String id, title, contents, category, thumb;

  ArticleDetailModel.fromJson(Map<String, dynamic> json)
      : id = "$json['id']",
        title = json['title'],
        contents = json['contents'],
        category = json['category'],
        thumb = json['thumb'];
}
