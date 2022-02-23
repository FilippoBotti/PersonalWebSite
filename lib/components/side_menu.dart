import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_site/blocs/websiteBloc/website.dart';
import 'package:web_site/blocs/websiteBloc/website_events.dart';
import 'package:web_site/blocs/websiteBloc/website_states.dart';
import 'package:web_site/utility/constants.dart';
import 'package:web_site/utility/responsive.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const ProfileRow(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                    child: Text("Projects", style: Theme.of(context).textTheme.subtitle1!,),
                    onTap: (){
                      BlocProvider.of<WebsiteBloc>(context).add(ShowProjectsPage(user: "FilippoBotti"));
                      if(!Responsive.isLargeDesktop(context)) {
                        Navigator.pop(context);
                      }
                    },
                ),
                InkWell(
                  child: Expanded(child: Container(child: Text("Video", style: Theme.of(context).textTheme.subtitle1!,))),
                  onTap: (){
                    BlocProvider.of<WebsiteBloc>(context).add(ShowProjectsPage(user: "FilippoBotti"));
                    if(!Responsive.isLargeDesktop(context)) {
                      Navigator.pop(context);
                    }
                  },
                ),
                InkWell(
                  child: Text("Contatti", style: Theme.of(context).textTheme.subtitle1!,),
                  onTap: (){
                    BlocProvider.of<WebsiteBloc>(context).add(ShowContactPage());
                    if(!Responsive.isLargeDesktop(context)) {
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ProfileRow extends StatelessWidget {
  const ProfileRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: Container(
          color: const Color(0xFF242430),
          child: Column(
            children: const [
              Spacer(flex: 2),
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/LinkedinImg.jpeg'),
                radius: 50,
              ),
              Spacer(),
              Text(
                "Filippo Botti",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                "Ingegnere informatico & Sviluppatore mobile",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w200, height: 1.5),
              ),
              Spacer(flex: 2),
            ],
          )),
    );
  }
}
