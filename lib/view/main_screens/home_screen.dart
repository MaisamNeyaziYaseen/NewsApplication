import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:news_application/controller/news_controller.dart';
import 'package:news_application/model/news.dart';

class HomeScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(newsProvider).getAllNewsPaginated(
        //on status code error
        (status) => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("error: $status"))),
        //on exception
        (e) => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("$e"))));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: const Icon(
              Icons.menu,
              color: Color(0xff2C79A5),
            ),
            title: const Text(
              "NewsFeed",
              style: TextStyle(color: Color(0xff2C79A5)),
            ),
            actions: const [
              Icon(
                Icons.more_vert,
                color: Color(0xff2C79A5),
              ),
              SizedBox(
                width: 10,
              ),
            ],
            bottom: TabBar(
                labelColor: Color(0xff2C79A5),
                indicatorColor: Color(0xff2C79A5),
                unselectedLabelColor: Color(0xff2C79A5).withOpacity(0.5),
                tabs: [
                  Tab(
                    child: Text("Teab1"),
                  ),
                  Tab(
                    child: Text(
                      "Tab2",
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Teb3",
                    ),
                  )
                ]),
          ),
          body: TabBarView(
            children: [
              Center(
                child: PagedListView<int, News>(
                  pagingController: ref.watch(newsProvider).getPaginController,
                  builderDelegate: PagedChildBuilderDelegate(
                      itemBuilder: (context, newsItem, index) => Container(
                            width: double.infinity,
                            height: 50,
                            child: Text(newsItem.title ?? ""),
                          )),
                ),
              ),
              Center(
                child: Text("tab2"),
              ),
              Center(
                child: Text("tab3"),
              ),
            ],
          )),
    );
  }
}
