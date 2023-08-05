import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsApiService {
  final String _url = "https://content.guardianapis.com/";
  final String _endpoint = "search";
  final String _apiKey = "34e419e6-a68c-4aaf-884f-4f7d382ede3c";

  Future<List<dynamic>> getAllNews(
      int page,
      int pageSize,
      Function(int status) onStatusCodeError,
      Function(Exception e) onException) async {
    Uri uri = Uri.parse(
        "$_url$_endpoint?page=$page&page-size=$pageSize&show-fields=thumbnail&api-key=$_apiKey");
    Map<String, dynamic> data = {};
    List<dynamic> results = [];

    try {
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        data = json.decode(response.body);
        results = data['response']['results'];
      } else {
        print("status error code: ${response.statusCode}");
        onStatusCodeError(response.statusCode);
      }
    } on Exception catch (e) {
      onException(e);
    }

    return results;
  }
}
