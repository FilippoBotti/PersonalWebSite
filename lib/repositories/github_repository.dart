import 'package:web_site/services/github_api_service.dart';

class GithubRepository {
  final GithubAPIService _githubApiServices = GithubAPIService();

  GithubRepository();

  Future<String> getUserRepositories(String user) async {
    final list = await _githubApiServices.getUserRepositories(user);
    return list;
  }
}