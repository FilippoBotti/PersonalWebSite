import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_site/blocs/websiteBloc/website.dart';
import 'package:web_site/blocs/websiteBloc/website_bloc.dart';
import 'package:web_site/blocs/websiteBloc/website_states.dart';
import 'package:web_site/components/side_menu.dart';
import 'package:web_site/repositories/github_repository.dart';
import 'package:web_site/utility/constants.dart';
import 'package:web_site/utility/responsive.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.children}) : super(key: key);

  final List<Widget> children;

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
    BlocProvider.of<WebsiteBloc>(context).add(OnFetchProjects(user: user));
  }



  @override
  Widget build(BuildContext context) {
    return BlocListener<WebsiteBloc, WebsiteState>(
        listener: (context, state) {},
        child: BlocBuilder<WebsiteBloc, WebsiteState>(builder: (context, state) {
          return Scaffold(
            appBar: (Responsive.isDesktop(context))
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
            body: (state is WebsiteShowProjects) ? Center(
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                if (Responsive.isDesktop(context))
                  const Expanded(
                    flex: 2,
                    child: SideMenu(),
                  ),
                Expanded(
                    flex: 7,
                    child: SingleChildScrollView(
                        child: Column(
                      children: [...widget.children],
                    )))
              ]),
            ) : const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            ),
          );
        }));
  }
}
