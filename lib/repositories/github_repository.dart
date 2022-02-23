import 'package:web_site/models/project.dart';
import 'package:web_site/services/github_api_service.dart';

class GithubRepository {
  final GithubAPIService _githubApiServices = GithubAPIService();

  GithubRepository();

  Future<List<Project>> getUserRepositories(String user) async {
    final list = await _githubApiServices.getUserRepositories(user);
    return list;
  }
}