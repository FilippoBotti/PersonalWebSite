import 'package:bloc/bloc.dart';
import 'package:web_site/blocs/websiteBloc/website_events.dart';
import 'package:web_site/blocs/websiteBloc/website_states.dart';
import 'package:web_site/models/project.dart';
import 'package:web_site/models/video.dart';
import 'package:web_site/repositories/repository.dart';

class WebsiteBloc extends Bloc<WebsiteEvent, WebsiteState> {
  final Repository repository;


  WebsiteBloc({required this.repository}) : super(WebsiteInitial()) {
    on<ShowProjectsPage>((event, emit) => _showRepos(event, emit));
    on<ShowContactsPage>((event, emit) => _showContacts(emit));
    on<ShowVideosPage>((event, emit) => _showVideos(emit));
  }

  void _showRepos(ShowProjectsPage event, Emitter<WebsiteState> emit) async {
    emit(WebsiteLoading());
    await Future.delayed(const Duration(seconds: 1));
    try {
      List<Project> repos =
          await repository.getUserRepositories(event.user);
      emit(WebsiteShowProjects(repos: repos));
    } catch (error) {
      emit(WebsiteFailure());
    }
  }

  void _showVideos( Emitter<WebsiteState> emit) async {
    emit(WebsiteLoading());
    try {
      List<YoutubeVideo> videos =
      await repository.getUserVideos();
      YoutubeChannel youtubeChannel = await repository.getUserChannelInfo();
      print(youtubeChannel);
      emit(WebsiteShowVideos(videos: videos, channel: youtubeChannel));
    } catch (error) {
      print(error);
      emit(WebsiteFailure());
    }
  }

  void _showContacts(Emitter<WebsiteState> emit) async {
    emit(WebsiteLoading());
    emit(WebsiteShowContacts());
  }
}
