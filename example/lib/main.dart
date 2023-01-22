import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Grock.navigationKey, // added this line
      scaffoldMessengerKey: Grock.scaffoldMessengerKey, // added this line
      title: 'GROCK',
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
