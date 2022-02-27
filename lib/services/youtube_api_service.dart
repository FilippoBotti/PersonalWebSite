import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:web_site/models/project.dart';
import 'package:web_site/models/video.dart';



class YoutubeAPIService {
  var client = http.Client();
  String apiURL = 'youtube.googleapis.com';


  Future<YoutubeChannel> getUserChannelInfo() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };

    Map<String, String> requestParameters = {
      'part': 'snippet,contentDetails,statistics',
      'id': 'UCerb4KBSmGLo27dCEuoZuJg',
      'key': 'AIzaSyDNILQW_Hn4-TGAhDDNFQAII3a3WTbjkeA'
    };

    var response = await client.get(
        Uri.https(apiURL, '/youtube/v3/channels', requestParameters),
        headers: requestHeaders,
        );

    print((response.body));
    if (response.statusCode == 200) {
      return YoutubeChannel.fromJson(jsonDecode(utf8.decode(response.bodyBytes))['items'][0]);
    }
    throw Exception('Failed to load post');
  }

  Future<List<YoutubeVideo>> getUserVideos() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };

    Map<String, String> requestParameters = {
      'part': 'snippet,contentDetails',
      'playlistId': 'UUerb4KBSmGLo27dCEuoZuJg',
      'key': 'AIzaSyDNILQW_Hn4-TGAhDDNFQAII3a3WTbjkeA'
    };

    var response = await client.get(
      Uri.https(apiURL, '/youtube/v3/playlistItems', requestParameters),
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return (jsonDecode(utf8.decode(response.bodyBytes))['items'] as List)
          .map((model) => YoutubeVideo.fromJson(model))
          .toList();


    }
    throw Exception('Failed to load post');
  }
}
