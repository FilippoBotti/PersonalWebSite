import 'package:web_site/models/project.dart';
import 'package:web_site/models/video.dart';
import 'package:web_site/services/github_api_service.dart';
import 'package:web_site/services/youtube_api_service.dart';

class Repository {
  final GithubAPIService _githubApiServices = GithubAPIService();
  final YoutubeAPIService _youtubeApiServices = YoutubeAPIService();

  Repository();

  Future<List<Project>> getUserRepositories(String user) async {
    final list = await _githubApiServices.getUserRepositories(user);
    return list;
  }

  Future<List<YoutubeVideo>> getUserVideos() async {
    final list = await _youtubeApiServices.getUserVideos();
    return list;
  }

  Future<YoutubeChannel> getUserChannelInfo() async {
    final channel = await _youtubeApiServices.getUserChannelInfo();
    return channel;
  }
}