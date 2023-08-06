class NewsCategory {
  String id = "";
  String webTitle = "";

  NewsCategory({required this.id, required this.webTitle});

  NewsCategory.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    webTitle = data['webTitle'];
  }
}
