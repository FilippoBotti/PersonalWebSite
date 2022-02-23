import 'package:bloc/bloc.dart';
import 'package:web_site/blocs/websiteBloc/website_events.dart';
import 'package:web_site/blocs/websiteBloc/website_states.dart';
import 'package:web_site/models/project.dart';
import 'package:web_site/repositories/github_repository.dart';

class WebsiteBloc extends Bloc<WebsiteEvent, WebsiteState> {
  final GithubRepository githubRepository;

  WebsiteBloc({required this.githubRepository}) : super(WebsiteInitial()) {
    on<ShowProjectsPage>((event, emit) => _showRepos(event, emit));
    on<ShowContactPage>((event, emit) => _showContacts(emit));
  }

  void _showRepos(ShowProjectsPage event, Emitter<WebsiteState> emit) async {
    emit(WebsiteLoading());
    await Future.delayed(const Duration(seconds: 1));
    try {
      List<Project> repos =
          await githubRepository.getUserRepositories(event.user);
      emit(WebsiteShowProjects(repos: repos));
    } catch (error) {
      emit(WebsiteFailure());
    }
  }

  void _showContacts(Emitter<WebsiteState> emit) async {
    emit(WebsiteLoading());
    emit(WebsiteShowContacts());
  }
}
