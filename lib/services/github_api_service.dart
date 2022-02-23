import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:web_site/models/project.dart';



class GithubAPIService {
  var client = http.Client();
  String apiURL = 'api.github.com';


  Future<List<Project>> getUserRepositories(String user) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };

    var response = await client.get(
        Uri.https(apiURL, '/users/$user/repos'),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      return (jsonDecode(utf8.decode(response.bodyBytes)) as List)
          .map((model) => Project.fromJson(model))
          .toList();


    }
    throw Exception('Failed to load post');
  }


}
