class News {
  String id = "";
  String? type;
  String? category;
  String? title;
  String content = "";
  String? imageUrl;
  String? webUrl;
  DateTime? publicationDate;

  News(
      {required this.id,
      required this.type,
      required this.category,
      required this.title,
      required this.webUrl,
      required this.publicationDate});

  News.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    type = data['type'];
    category = data['sectionName'];
    title = data['webTitle'];
    content = data['fields']['bodyText'];
    imageUrl = data['fields']['thumbnail'];
    webUrl = data['webUrl'];
    if (data['webPublicationDate'] != null) {
      publicationDate = DateTime.parse(data['webPublicationDate']);
    }
  }
}
