import 'package:flutter/material.dart';
import 'package:web_site/components/side_menu.dart';
import 'package:web_site/utility/constants.dart';
import 'package:web_site/utility/responsive.dart';

class MainPage extends StatelessWidget{
  const MainPage({Key? key, required this.children}) : super(key:key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (Responsive.isDesktop(context)) ? null : AppBar(
        backgroundColor: bgColor,
        leading: Builder(builder: (context) => IconButton(
          onPressed: (){
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),)
      ),
      drawer: const SideMenu(),
      body: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(Responsive.isDesktop(context))
            const Expanded(
              flex: 2,
              child: SideMenu(),
            ),
            Expanded(
              flex: 7,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...children
                  ],
                )
              )
            )
          ]
        ),
      ),
    );
  }
}
