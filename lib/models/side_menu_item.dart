import 'package:web_site/blocs/websiteBloc/website.dart';

class SideMenuItem {
  final String name;
  final WebsiteEvent event;

  SideMenuItem({required this.name, required this.event});
}

List<SideMenuItem> sideMenuItems = [
  SideMenuItem(name: "Projects", event: ShowProjectsPage(user: "FilippoBotti")),
  SideMenuItem(name: "Video", event: ShowVideosPage()),
  SideMenuItem(name: "Contacts", event: ShowContactsPage()),

];