import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchEndpointService {
  final String _url = "https://content.guardianapis.com/";
  final String _endpoint = "search";
  final String _apiKey = "34e419e6-a68c-4aaf-884f-4f7d382ede3c";

  Future<List<dynamic>> getNewsByCategory(
      int page,
      int pageSize,
      String category,
      Function(int status) onStatusCodeError,
      Function(Exception e) onException) async {
    Uri uri;
    if (category.toLowerCase() == "home") {
      //get all categories
      uri = Uri.parse(
          "$_url$_endpoint?api-key=$_apiKey&show-fields=thumbnail,body-text&page=$page&page-size=$pageSize&from-date=${DateTime.parse("2014-02-01").toIso8601String()}");
    } else {
      uri = Uri.parse(
          "$_url$_endpoint?api-key=$_apiKey&show-fields=thumbnail,body-text&page=$page&page-size=$pageSize&section=${category.toLowerCase()}&from-date=${DateTime.parse("2014-02-01").toIso8601String()}");
    }

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
