import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_site/blocs/websiteBloc/website.dart';
import 'package:web_site/blocs/websiteBloc/website_events.dart';
import 'package:web_site/blocs/websiteBloc/website_states.dart';
import 'package:web_site/models/side_menu_item.dart';
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
            child: ListView.separated(
                padding: EdgeInsets.zero,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: sideMenuItems.length,
                itemBuilder: (BuildContext context, int position) {
                  return SideMenuItemRow(
                    sideMenuItem: sideMenuItems[position],
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class SideMenuItemRow extends StatelessWidget {
  const SideMenuItemRow({
    Key? key,
    required this.sideMenuItem,
  }) : super(key: key);

  final SideMenuItem sideMenuItem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          sideMenuItem.name,
          style: Theme.of(context).textTheme.subtitle1!,
          textAlign: TextAlign.center,
        ),
      ),
      onTap: () {
        BlocProvider.of<WebsiteBloc>(context).add(sideMenuItem.event);
        if (!Responsive.isLargeDesktop(context)) {
          Navigator.pop(context);
        }
      },
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
