import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:news_application/model/news.dart';
import 'package:news_application/services/api/news_api.dart';

final ChangeNotifierProvider<NewsController> newsProvider =
    ChangeNotifierProvider<NewsController>((ref) => NewsController());

class NewsController extends ChangeNotifier {
  final NewsApiService _newsApiService = NewsApiService();
  final PagingController<int, News> _pagingController =
      PagingController(firstPageKey: 0);
  int _page = 1;
  final int _pageSize = 10;
  List<News> _newsList = [];

  Future<List<News>> getAllNews(Function(int status) onStatusCodeError,
      Function(Exception e) onException) async {
    List<dynamic> results = await _newsApiService.getAllNews(_page, _pageSize,
        (status) => onStatusCodeError(status), (e) => onException(e));
    List<News> newsList = [];

    for (var e in results) {
      newsList.add(News.fromJson(e));
    }

    // notifyListeners();

    return _newsList = newsList;
  }

  List<News> getAllNewsPaginated(Function(int status) onStatusCodeError,
      Function(Exception e) onException) {
    List<News> newsList = [];
    _pagingController.addPageRequestListener((pageKey) async {
      newsList = await getAllNews(
          (status) => onStatusCodeError(status), (e) => onException(e));
      if (newsList.length < _pageSize) {
        _pagingController.appendLastPage(newsList);
      } else {
        _page++;
        _pagingController.appendPage(newsList, _page);
      }
    });

    return newsList;
  }

  PagingController<int, News> get getPaginController => _pagingController;
  int get getPage => _page;
  int get getPageSize => _pageSize;
  List<News> get getNewsList => _newsList;
}
