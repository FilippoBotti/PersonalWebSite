import 'package:flutter/material.dart';
import 'package:web_site/utility/constants.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: const [
          ProfileRow(),
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
    return AspectRatio(aspectRatio: 1.23,
      child: Container(
          color: const Color(0xFF242430),
          child:
          Column(
            children: const [
               Spacer(flex: 2),
               CircleAvatar(
                 backgroundImage: AssetImage('assets/images/LinkedinImg.jpeg'),
                 radius: 50,
              ),
               Spacer(),
               Text(
                "Filippo Botti",
                style: TextStyle(
                  color:Colors.white
                ),
              ),
               Text(
                "Ingegnere informatico & Sviluppatore mobile",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w200,
                    height: 1.5
                ),
              ),
               Spacer(flex: 2),
            ],
          )
      ),);
  }
}
