import 'dart:async';

import 'package:provider/provider.dart';
import 'package:antoh/provider/ProportiesProvider.dart';
import 'package:antoh/provider/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:antoh/Models/appConstants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Screens/homepage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

    // name: "SecondaryApp",//**Add this line**
    // options: FirebaseOptions(
        // apiKey: "foo",//"apiKey",
        // appId: "foo",//"appId",
        // messagingSenderId: "foo",//"messagingSenderId",
        // projectId: "foo"),

  runApp(MyApp());
}



DatabaseReference EstateList = FirebaseDatabase.instance.ref().child("Estates");

DatabaseReference clients = FirebaseDatabase.instance.ref().child("Clients");
DatabaseReference Doctor = FirebaseDatabase.instance.ref().child("Doctors");
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final ThemeData genetalTheme = ThemeData(
    primaryColor: Color(0xff2686a1),
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProportiesProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Real Estate',
        theme: genetalTheme,
        home: HomePage(),
      ),
    );
  }
}