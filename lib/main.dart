import 'package:bookly_app/screens/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(bookly());
}

class bookly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Cairo',
        textTheme: const TextTheme(
          bodyText2: TextStyle(
              color: Color(0xffb9bed1)
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home:  HomePage(),
    );
  }
}