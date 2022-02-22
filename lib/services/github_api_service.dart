import 'dart:convert';

import 'package:http/http.dart' as http;



class GithubAPIService {
  var client = http.Client();
  String apiURL = 'api.github.com';


  Future<String> getUserRepositories(String user) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };

    var response = await client.get(
        Uri.https(apiURL, '/users/$user/repos'),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      print((utf8.decode(response.bodyBytes)).toString());
        return ((utf8.decode(response.bodyBytes)).toString());
    }
    throw Exception('Failed to load post');
  }


}
