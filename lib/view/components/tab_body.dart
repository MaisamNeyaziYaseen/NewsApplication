import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:news_application/controller/news_controller.dart';
import 'package:news_application/model/news.dart';
import 'package:news_application/view/components/news_holder.dart';

class TabBody extends ConsumerStatefulWidget {
  String category;

  TabBody({super.key, required this.category});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TabBodyState(category: category);
}

class _TabBodyState extends ConsumerState<TabBody> {
  String category;

  _TabBodyState({required this.category});

  //get data by category
  @override
  void initState() {
    super.initState();

    ref.read(newsProvider).getNewsByCategoryPaginated(
        category,
        (status) => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("error: $status"))),
        (e) => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("$e"))),
        //on complete
        (pc) {
      ref.read(newsProvider).setPaginController(pc);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, News>(
        itemExtent: 330,
        pagingController: ref.watch(newsProvider).getPagingController,
        builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: (context, newsItem, index) => Container(
                width: double.infinity,
                height: 50,
                child: NewsHolder(news: newsItem))));
  }
}
