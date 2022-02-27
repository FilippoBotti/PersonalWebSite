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
import 'package:web_site/pages/projects_page.dart';
import 'package:web_site/pages/videos_page.dart';
import 'package:web_site/repositories/repository.dart';
import 'package:web_site/utility/constants.dart';
import 'package:web_site/utility/responsive.dart';

import 'contacts_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final bloc = WebsiteBloc(repository: Repository());

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
                            : (state is WebsiteShowVideos)
                                ? VideosPage(state: state)
                                : const LoadingContainer(),
                  ])));
        }));
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
