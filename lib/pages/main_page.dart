import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_site/blocs/websiteBloc/website.dart';
import 'package:web_site/blocs/websiteBloc/website_bloc.dart';
import 'package:web_site/blocs/websiteBloc/website_states.dart';
import 'package:web_site/components/side_menu.dart';
import 'package:web_site/models/project.dart';
import 'package:web_site/repositories/github_repository.dart';
import 'package:web_site/utility/constants.dart';
import 'package:web_site/utility/responsive.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final bloc = WebsiteBloc(githubRepository: GithubRepository());

  @override
  void initState() {
    _getRepository("FilippoBotti");
    super.initState();
  }

  void _getRepository(String user) async {
    BlocProvider.of<WebsiteBloc>(context).add(ShowProjectsPage(user: user));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WebsiteBloc, WebsiteState>(
        listener: (context, state) {},
        child:
            BlocBuilder<WebsiteBloc, WebsiteState>(builder: (context, state) {
          return Scaffold(
              appBar: (Responsive.isLargeDesktop(context))
                  ? null
                  : AppBar(
                      backgroundColor: bgColor,
                      leading: Builder(
                        builder: (context) => IconButton(
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          icon: const Icon(Icons.menu),
                        ),
                      )),
              drawer: const SideMenu(),
              body: Center(
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    if (Responsive.isLargeDesktop(context))
                      const Expanded(
                        flex: 2,
                        child: SideMenu(),
                      ),
                    (state is WebsiteShowProjects)
                        ? ProjectsPage(
                            state: state,
                          )
                        : (state is WebsiteShowContacts)
                            ? ContactsPage()
                            : const LoadingContainer(),
                  ])));
        }));
  }
}

class ContactsPage extends StatelessWidget {
  const ContactsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      flex: 7,
      child: Center(
        child: Text("TODO")
      ),
    );
  }
}

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      flex: 7,
      child: Center(
        child: CircularProgressIndicator(
          color: primaryColor,
        ),
      ),
    );
  }
}

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({Key? key, required this.state}) : super(key: key);

  final WebsiteShowProjects state;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 7,
        child: Padding(
          padding: const EdgeInsets.only(bottom: defaultPadding),
          child: SingleChildScrollView(
              child: Column(children: [
            const HomeBanner(),
            Responsive(
              mobile: ProjectGridView(
                repos: state.repos,
                crossAxisCount: 1,
                childAspectRatio: 1.7,
              ),
              mobileLarge: ProjectGridView(
                repos: state.repos,
                crossAxisCount: 2,
                childAspectRatio: 1,
              ),
              desktop: ProjectGridView(
                repos: state.repos,
              ),
              tablet: ProjectGridView(
                repos: state.repos,
                crossAxisCount: 2,
                childAspectRatio: 1.5,
              ),
              largeDesktop: ProjectGridView(
                repos: state.repos,
                childAspectRatio: 1.5,
              ),
            )
          ])),
        ));
  }
}

class ProjectGridView extends StatelessWidget {
  const ProjectGridView({
    Key? key,
    this.crossAxisCount = 3,
    this.childAspectRatio = 1.5,
    required this.repos,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;
  final List<Project> repos;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding, vertical: defaultPadding),
        child:
            Text("My Projects", style: Theme.of(context).textTheme.headline6!),
      ),
      GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: repos.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: defaultPadding,
            mainAxisSpacing: defaultPadding,
            childAspectRatio: childAspectRatio,
          ),
          itemBuilder: (context, index) => ProjectCard(
                project: repos[index],
              ))
    ]);
  }
}

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    Key? key,
    required this.project,
  }) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(project.title!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline6!),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: Text(
                project.desription!,
                maxLines: !Responsive.isDesktop(context)
                    ? Responsive.isMobile(context)
                        ? 3
                        : 4
                    : 5,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.montserrat(
                  height: 1.5,
                ),
              ),
            ),
          ),
          Row(children: [
            const Spacer(),
            TextButton(
                onPressed: () async {
                  await launch(project.url);
                },
                child: const Text(
                  "Read more",
                  style: TextStyle(color: primaryColor),
                )),
          ])
        ],
      ),
      padding: const EdgeInsets.all(defaultPadding),
      color: secondaryColor,
    );
  }
}

class HomeBanner extends StatelessWidget {
  const HomeBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: Responsive.isMobile(context) ? 2.5 : 3,
        child: Stack(fit: StackFit.expand, children: [
          Image.network(
            "https://junyanz.github.io/CycleGAN/images/teaser_high_res.jpg",
            fit: BoxFit.cover,
          ),
          Container(color: darkColor.withOpacity(0.66)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Discover my thesis",
                      style: Responsive.isLargeDesktop(context)
                          ? Theme.of(context).textTheme.headline3!.copyWith(
                              fontWeight: FontWeight.bold, color: Colors.white)
                          : Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: defaultPadding / 2,
                  ),
                  const AnimatedTextTesi(),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  if (!Responsive.isMobileLarge(context))
                    ElevatedButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding * 2,
                              vertical: defaultPadding),
                          backgroundColor: primaryColor,
                        ),
                        child: const Text(
                          "Explore now",
                          style: TextStyle(color: darkColor),
                        ))
                ]),
          )
        ]));
  }
}

class AnimatedTextTesi extends StatelessWidget {
  const AnimatedTextTesi({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.subtitle1!,
      child: Row(children: [
        if (!Responsive.isMobileLarge(context)) const CodeText(),
        if (!Responsive.isMobileLarge(context))
          const SizedBox(
            width: defaultPadding / 2,
          ),
        AnimatedTextKit(repeatForever: true, animatedTexts: [
          TyperAnimatedText("Cyclegan"),
          TyperAnimatedText("Deep Learning"),
        ]),
        if (!Responsive.isMobileLarge(context))
          const SizedBox(
            width: defaultPadding / 2,
          ),
        if (!Responsive.isMobileLarge(context)) const CodeText(),
      ]),
    );
  }
}

class CodeText extends StatelessWidget {
  const CodeText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text.rich(TextSpan(text: "<", children: [
      TextSpan(text: "pytorch", style: TextStyle(color: primaryColor)),
      TextSpan(text: ">"),
    ]));
  }
}
