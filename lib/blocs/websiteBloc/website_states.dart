import 'package:equatable/equatable.dart';

abstract class WebsiteState extends Equatable{
  @override
  List<Object> get props => [];
}

class WebsiteInitial extends WebsiteState {}

class WebsiteLoading extends WebsiteState {}

class WebsiteFailure extends WebsiteState {}


class WebsiteShowProjects extends WebsiteState{
  final String repos;

  WebsiteShowProjects({required this.repos});

  @override
  List<Object> get props => [repos];
}


