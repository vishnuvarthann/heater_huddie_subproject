import 'dart:async';

import 'package:flutter/material.dart';
import 'package:parker_mobile_framework/login/Aboutfragment.dart';
import 'package:parker_mobile_framework/login/Authentication.dart';
import 'package:parker_mobile_framework/login/Login.dart';
import 'package:parker_mobile_framework/login/SignOut.dart';



void main() => runApp(MyApp());
  
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new SplashScreen(),
      //  initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      routes: {
         '/Authentication': (context) => Authentication(),
         '/login': (context) => Login(),
         '/signOut':(context) =>SignOut(),
        //  '/Aboutfragment':(context) =>Aboutfragment(),
        // '/Wifiscan':(context)=> Wifiscan(),
        
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/Authentication');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.yellow,
      body: new Center(
        child: new Image.asset('assets/images/parker.jpg'),
      ),
    );
  }
}