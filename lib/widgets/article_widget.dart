import 'package:azure_article/screens/detail_screen.dart';
import 'package:flutter/material.dart';

class Article extends StatelessWidget {
  final String id, title, contents, thumb, category;

  const Article(
      {super.key,
      required this.id,
      required this.title,
      required this.contents,
      required this.thumb,
      required this.category});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double containerWidth = size.width * 0.8;
    final double containerHeight = size.height * 0.55;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              id: id,
              title: title,
              contents: contents,
              thumb: thumb,
              category: category,
            ),
          ),
        );
      },
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: ColorFiltered(
              colorFilter: const ColorFilter.mode(
                Colors.black38,
                BlendMode.darken,
              ),
              child: Image.network(
                thumb,
                headers: const {
                  "User-Agent":
                      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                },
                fit: BoxFit.cover,
                width: containerWidth,
                height: containerHeight,
              ),
            ),
          ),
          SizedBox(
            height: containerHeight,
            width: containerWidth,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 40,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      category,
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
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    softWrap: true,
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
    );
  }
}
