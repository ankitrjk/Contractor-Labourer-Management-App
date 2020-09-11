import 'package:flutter/material.dart';
import 'package:flutter_fire/pages/home_page.dart';
import 'package:flutter_fire/pages/login_signup_page.dart';
import 'package:flutter_fire/services/authentication.dart';
import 'package:flutter_fire/pages/root_page.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter (Firebase)',
        debugShowCheckedModeBanner: false,
        routes: {
          '/homepage': (context) => HomePage(),
          '/loginpage': (context) => LoginSignupPage()
        },
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new RootPage(auth: new Auth()));
        
  }
}
