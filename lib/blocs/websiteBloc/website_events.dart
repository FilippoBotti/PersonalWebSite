import 'package:equatable/equatable.dart';

abstract class WebsiteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnFetchProjects extends WebsiteEvent {
  final String user;

  OnFetchProjects({required this.user});

  @override
  List<Object?> get props => [user];
}
