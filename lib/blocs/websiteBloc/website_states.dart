import 'package:equatable/equatable.dart';
import 'package:web_site/models/project.dart';
import 'package:web_site/models/video.dart';

abstract class WebsiteState extends Equatable{
  @override
  List<Object> get props => [];
}

class WebsiteInitial extends WebsiteState {}

class WebsiteLoading extends WebsiteState {}

class WebsiteFailure extends WebsiteState {}

class WebsiteShowContacts extends WebsiteState {

  WebsiteShowContacts();

  @override
  List<Object> get props => [];

}


class WebsiteShowProjects extends WebsiteState{
  final List<Project> repos;

  WebsiteShowProjects({required this.repos});

  @override
  List<Object> get props => [repos];
}


class WebsiteShowVideos extends WebsiteState{
  final List<YoutubeVideo> videos;
  final YoutubeChannel channel;

  WebsiteShowVideos({required this.videos, required this.channel});

  @override
  List<Object> get props => [videos, channel];
}