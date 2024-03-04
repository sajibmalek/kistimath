import 'dart:async';
import 'package:Kistimath/webview_activity_new.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      darkTheme: ThemeData(primarySwatch: Colors.orange),
      home: const HomeActivity(),
    );
  }

}

class HomeActivity extends StatefulWidget{
  const HomeActivity({super.key});

  @override
  _HomeActivityState createState() => _HomeActivityState();

}

class _HomeActivityState extends State<HomeActivity> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1, milliseconds: 500), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NewWebviewActivity())
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 250,
          child: Image.asset('images/kistimat_splash.png'),
        ),
      ),
    );
  }
}

