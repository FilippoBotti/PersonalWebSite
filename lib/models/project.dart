class Project{
  final String? title;
  final String? desription;
  final String url;

  Project({required this.title, this.desription, required this.url});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      title: json['name'],
      desription: json['description'],
      url: json['html_url'],
    );
  }

  @override
  String toString() {
    return 'Project{title: $title, desription: $desription, url: $url}';
  }
}

Project demo_project = Project(
    title: "Lorem ipsum",
    desription: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
    url:"ghj"
);

List<Project> demo_projects = [
  demo_project,
  demo_project,
  demo_project,
  demo_project,
  demo_project,
  demo_project,
  demo_project,
  demo_project,
  demo_project
];