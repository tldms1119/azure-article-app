import 'package:azure_article/models/article_detail_model.dart';
import 'package:azure_article/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailScreen extends StatefulWidget {
  final String id, title, contents, thumb, category;

  const DetailScreen({
    super.key,
    required this.id,
    required this.title,
    required this.contents,
    required this.thumb,
    required this.category,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late final Future<ArticleDetailModel> article;
  late SharedPreferences prefs;
  bool isLiked = false;

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final likedList = prefs.getStringList('liked');
    if (likedList != null) {
      if (likedList.contains(widget.id) == true) {
        setState(() {
          isLiked = true;
        });
      }
    } else {
      // 처음 앱 실행 시, liked 리스트 없을테니 빈 리스트로 세팅
      await prefs.setStringList('liked', []);
    }
  }

  @override
  void initState() {
    super.initState();
    article = ApiService.getArticleById(widget.id);
    initPrefs();
  }

  onHeartTap() async {
    final likedList = prefs.getStringList('liked');
    if (likedList != null) {
      if (isLiked) {
        likedList.remove(widget.id);
      } else {
        likedList.add(widget.id);
      }
      await prefs.setStringList('liked', likedList);
      setState(() {
        isLiked = !isLiked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Colors.black45,
          backgroundColor: Colors.white,
          actions: const [
            // IconButton(
            //   onPressed: onHeartTap,
            //   icon: Icon(isLiked ? Icons.favorite : Icons.favorite_outline),
            //   color: Colors.green,
            // )
          ],
          toolbarHeight: 50,
          // title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  ClipRRect(
                    child: ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        Colors.black38,
                        BlendMode.darken,
                      ),
                      child: Image.network(
                        widget.thumb,
                        headers: const {
                          "User-Agent":
                              "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                        },
                        fit: BoxFit.cover,
                        width: size.width,
                        height: size.height / 2,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width,
                    height: size.height / 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              widget.category,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // const Text(
                          //   'Sub Text 가 들어갈 자리입니다',
                          //   style: TextStyle(
                          //     color: Colors.white,
                          //     fontSize: 20,
                          //     fontWeight: FontWeight.w800,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              FutureBuilder(
                future: article,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Html(data: snapshot.data!.contents)
                          // Text(
                          //   snapshot.data!.contents,
                          //   style: const TextStyle(fontSize: 18),
                          // ),
                        ],
                      ),
                    );
                  }
                  return const Text('...');
                },
              ),
            ],
          ),
        ));
  }
}
