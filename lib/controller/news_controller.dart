import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:news_application/model/news.dart';
import 'package:news_application/model/news_category.dart';
import 'package:news_application/services/api/news_api/search_endpoint.dart';
import 'package:news_application/services/api/news_api/sections_endpoint.dart';

final ChangeNotifierProvider<NewsController> newsProvider =
    ChangeNotifierProvider<NewsController>((ref) => NewsController());

class NewsController extends ChangeNotifier {
  final SearchEndpointService _searchEndpointService = SearchEndpointService();
  final SectionsEndPointService _sectionsEndPointService =
      SectionsEndPointService();
  int _page = 1;
  final int _pageSize = 10;
  String _fromDate = DateTime.now().toString();
  String _toDate = DateTime.now().toString();
  bool _isCategoriesLoading = true;
  List<News> _newsList = [];
  List<NewsCategory> _categoriesList = [];
  PagingController<int, News> _pagingController =
      PagingController(firstPageKey: 1);

  void getCategories(Function() onComplete) async {
    List<dynamic> results = await _sectionsEndPointService.getCategories(
        (status) => null, (e) => null);
    List<NewsCategory> categories = [
      NewsCategory(id: "home", webTitle: "home")
    ];

    for (var e in results) {
      categories.add(NewsCategory.fromJson(e));
    }

    _categoriesList.addAll(categories);
    notifyListeners();

    onComplete();
  }

  void getNewsByCategoryPaginated(
      String category,
      Function(int status) onStatusCodeError,
      Function(Exception e) onException,
      Function(PagingController<int, News> pc) onComplete) async {
    _page = 1;

    PagingController<int, News> pagingController =
        PagingController(firstPageKey: 1);
    pagingController.addPageRequestListener((pageKey) async {
      List<dynamic> results = await _searchEndpointService.getNewsByCategory(
          _page,
          _pageSize,
          category,
          (status) => onStatusCodeError(status),
          (e) => onException(e));

      List<News> newsList = [];

      for (var e in results) {
        newsList.add(News.fromJson(e));
      }
      // _newsList = newsList;
      if (newsList.length < _pageSize) {
        pagingController.appendLastPage(newsList);
      } else {
        _page++;
        pagingController.appendPage(newsList, _page);
      }
    });

    onComplete(pagingController);
  }

  int get getPage => _page;
  int get getPageSize => _pageSize;
  bool get getisCategoriesLoading => _isCategoriesLoading;
  List<News> get getNewsList => _newsList;
  List<NewsCategory> get getCategoriesList => _categoriesList;
  PagingController<int, News> get getPagingController => _pagingController;

  setIsCategoriesLoading(bool v) => _isCategoriesLoading = v;
  setPaginController(PagingController<int, News> v) => _pagingController = v;
}
