import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_application/controller/news_controller.dart';
import 'package:news_application/view/components/drawer_header.dart';
import 'package:news_application/view/components/tab_body.dart';
import 'package:news_application/view/main_screens/settings_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    ref.read(newsProvider).getCategories(() {
      ref.read(newsProvider).setIsCategoriesLoading(false);
      _tabController = TabController(
          length: ref.read(newsProvider).getCategoriesList.length, vsync: this);
    });
  }

  @override
  

  Widget buildBody(bool isLoading) {
    if (isLoading) {
      return SafeArea(child: Scaffold());
    } else {
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
              actions: [
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (c) => SimpleDialog(
                              title: Text("Options"),
                              children: [
                                SimpleDialogOption(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (c) => SettingsScreen()));
                                  },
                                  child: Text("Settings"),
                                )
                              ],
                            ));
                  },
                  icon: Icon(
                    Icons.more_vert,
                    color: Color(0xff2C79A5),
                  ),
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
                  const MyDrawerHeader(),
                  Expanded(
                    child: ListView.builder(
                        itemCount:
                            ref.watch(newsProvider).getCategoriesList.length,
                        itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                _tabController.animateTo(index);
                              },
                              child: ListTile(
                                leading: Icon(Icons.abc),
                                title: Text(ref
                                    .watch(newsProvider)
                                    .getCategoriesList[index]
                                    .webTitle
                                    .toUpperCase()),
                              ),
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

  @override
  Widget build(BuildContext context) {
    return buildBody(ref.watch(newsProvider).getisCategoriesLoading);
  }
}
