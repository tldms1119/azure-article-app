class ArticleFormModel {
  String? title;
  String? contents;
  String? thumb;
  String? password;
  String? category;

  ArticleFormModel(
    this.title,
    this.contents,
    this.thumb,
    this.password,
    this.category,
  );

  Map<String, dynamic> toJson() => {
        'title': title,
        'contents': contents,
        'thumb': thumb,
        'password': password,
        'category': category
      };
}
