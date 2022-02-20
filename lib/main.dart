import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_site/pages/home.dart';
import 'package:web_site/pages/main_page.dart';
import 'package:web_site/utility/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Filippo Botti personal website',
      home: const HomePage(),
      theme: ThemeData.dark().copyWith(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        canvasColor: bgColor,
        textTheme:  GoogleFonts.montserratTextTheme(
            Theme.of(context).textTheme).apply(
          bodyColor: Colors.white
        ).copyWith(
            bodyText1: TextStyle( color: bodyTextColor),
            bodyText2: TextStyle( color: bodyTextColor),
          ).apply(),
      ),

    );
  }
}

