import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_application/model/news.dart';
import 'package:news_application/utils/data_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsHolder extends ConsumerWidget {
  News news;

  NewsHolder({super.key, required this.news});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      child: InkWell(
        onTap: () async {
          try {
            launchUrl(Uri.parse(news.webUrl ?? ""));
          } on Exception catch (e) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("$e")));
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 2,
                spreadRadius: 2),
          ]),
          child: Column(
            children: [
              Container(
                height: 60,
                padding: EdgeInsets.all(10),
                child: Text(
                  news.title ?? "",
                  // textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: 180,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(news.category ?? ""),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              news.content,
                              maxLines: 8,
                              // textAlign: TextAlign.justify,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    ),
                    Image.network(
                      news.imageUrl ?? "",
                      errorBuilder: (context, object, _) {
                        return Image(
                          image: const AssetImage("assets/images/no image.jpg"),
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: 180,
                          fit: BoxFit.fill,
                        );
                      },
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 180,
                      fit: BoxFit.fill,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DataHelper.formatTimeAgo(
                            news.publicationDate.toString().substring(0, 10)),
                        style: TextStyle(color: Colors.blue),
                      ),
                      Icon(
                        Icons.share,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
