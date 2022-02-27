import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_site/blocs/websiteBloc/website.dart';
import 'package:web_site/blocs/websiteBloc/website_bloc.dart';
import 'package:web_site/pages/main_page.dart';
import 'package:web_site/repositories/repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return WebsiteBloc(repository: Repository());
      },
      child: const MainPage(),
    );
  }
}
