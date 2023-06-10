import 'package:azure_article/models/article_model.dart';
import 'package:azure_article/screens/search_screen.dart';
import 'package:azure_article/services/api_service.dart';
import 'package:azure_article/widgets/article_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // final Future<List<ArticleModel>> articles = ApiService.getArticles('tab1');

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          toolbarHeight: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Row(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Positioned(
                        left: 5,
                        top: 1,
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SearchScreen(
                                  searchWord: '',
                                ),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.search,
                            size: 30,
                          ),
                        ),
                      ),
                      const TabBar(
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: Colors.black,
                        isScrollable: true,
                        labelPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        tabs: [
                          Tab(text: '기도'),
                          Tab(text: '말씀'),
                          Tab(text: '추천'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            FutureBuilder(
              future: ApiService.getArticles('tab1'),
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
            FutureBuilder(
              future: ApiService.getArticles('tab2'),
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
            FutureBuilder(
              future: ApiService.getArticles('tab3'),
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
          ],
        ),
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
          contents: '',
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
