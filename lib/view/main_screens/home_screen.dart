import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_application/controller/news_controller.dart';
import 'package:news_application/view/components/drawer.dart';
import 'package:news_application/view/components/tab_body.dart';

class HomeScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();

    ref.read(newsProvider).getCategories();
    _tabController = TabController(
        length: ref.read(newsProvider).getCategoriesList.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu),
                color: Color(0xff2C79A5),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
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
                controller: _tabController,
                labelColor: Color(0xff2C79A5),
                indicatorColor: Color(0xff2C79A5),
                unselectedLabelColor: Color(0xff2C79A5).withOpacity(0.5),
                isScrollable: true,
                tabs: [
                  for (var category
                      in ref.watch(newsProvider).getCategoriesList)
                    Tab(
                      child: Text(category.webTitle.toUpperCase()),
                    ),
                ]),
          ),
          drawer: Drawer(
            child: Column(
              children: [
                MyDrawer(),
                Expanded(
                  child: ListView.builder(
                      itemCount:
                          ref.watch(newsProvider).getCategoriesList.length,
                      itemBuilder: (context, index) => ListTile(
                            leading: Icon(Icons.abc),
                            title: Text(ref
                                .watch(newsProvider)
                                .getCategoriesList[index]
                                .webTitle),
                          )),
                )
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              for (var category in ref.watch(newsProvider).getCategoriesList)
                TabBody(category: category.id)
            ],
          )),
    );
  }
}
