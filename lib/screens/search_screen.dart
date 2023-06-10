import 'package:azure_article/models/article_model.dart';
import 'package:azure_article/services/api_service.dart';
import 'package:azure_article/widgets/article_widget.dart';
import 'package:azure_article/widgets/search_appbar_widget.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final String searchWord;
  const SearchScreen({
    super.key,
    required this.searchWord,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController textEditingController;
  late Future<List<ArticleModel>> articles;
  String inputValue = '';

  @override
  void initState() {
    super.initState();
    articles = inputValue == ''
        ? Future(() => List.empty())
        : ApiService.searchArticles(widget.searchWord);
    textEditingController = TextEditingController(text: widget.searchWord);
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SearchAppBar(
        textEditingController: textEditingController,
        onChanged: (value) {
          setState(() {
            inputValue = value;
          });
        },
        onSubmitted: () {
          setState(() {
            articles = ApiService.searchArticles(inputValue);
          });
        },
      ),
      body: FutureBuilder(
        future: articles,
        builder: (context, future) {
          if (future.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Expanded(child: makeList(future)),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<ArticleModel>> future) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      itemCount: future.data!.length,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      itemBuilder: (context, index) {
        var article = future.data![index];
        return Article(
          id: article.id,
          title: article.title,
          contents: 'TODO',
          thumb: article.thumb,
          category: article.category == 'tab1'
              ? '기도'
              : article.category == 'tab2'
                  ? '말씀'
                  : '추천',
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 40),
    );
  }
}
