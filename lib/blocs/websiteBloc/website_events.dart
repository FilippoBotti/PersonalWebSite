import 'package:equatable/equatable.dart';

abstract class WebsiteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ShowProjectsPage extends WebsiteEvent {
  final String user;

  ShowProjectsPage({required this.user});

  @override
  List<Object?> get props => [user];
}

class ShowContactsPage extends WebsiteEvent {

  ShowContactsPage();

  @override
  List<Object?> get props => [];
}

class ShowVideosPage extends WebsiteEvent {

  ShowVideosPage();

  @override
  List<Object?> get props => [];
}

