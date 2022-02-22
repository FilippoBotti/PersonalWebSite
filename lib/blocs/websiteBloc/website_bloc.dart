import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:web_site/blocs/websiteBloc/website_events.dart';
import 'package:web_site/blocs/websiteBloc/website_states.dart';
import 'package:web_site/repositories/github_repository.dart';

class WebsiteBloc extends Bloc<WebsiteEvent, WebsiteState> {
  final GithubRepository githubRepository;

  WebsiteBloc({required this.githubRepository})
      :  super(WebsiteInitial()){
    on<OnFetchProjects>((event,emit) => _showRepos(event, emit));
  }

  void _showRepos(OnFetchProjects event, Emitter<WebsiteState> emit) async{
    emit(WebsiteLoading());
    await Future.delayed(Duration(seconds: 1));
    try {
      String repos = await githubRepository.getUserRepositories(event.user);
      emit(WebsiteShowProjects(repos: repos));
    } catch (error) {
      print(error);
      emit(WebsiteFailure());
    }
  }


}

