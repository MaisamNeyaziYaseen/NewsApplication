import 'dart:convert';

import 'package:http/http.dart' as http;

class SectionsEndPointService {
  final String _url = "https://content.guardianapis.com/";
  final String endpoint = "sections";
  final String _apikey = "34e419e6-a68c-4aaf-884f-4f7d382ede3c";

  Future<List<dynamic>> getCategories(Function(int status) onStatusCodeError,
      Function(Exception e) onException) async {
    Uri uri = Uri.parse("$_url$endpoint?api-key=$_apikey");

    Map<String, dynamic> data = {};
    List<dynamic> results = [];

    try {
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        data = json.decode(response.body);
        results = data['response']['results'];
      } else {
        onStatusCodeError(response.statusCode);
      }
    } on Exception catch (e) {
      onException(e);
    }

    return results;
  }
}
