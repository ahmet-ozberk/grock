import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

void main() => runApp(const GrockApp());

class GrockApp extends StatelessWidget {
  const GrockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Grock.navigationKey, // added this line
      scaffoldMessengerKey: Grock.scaffoldMessengerKey, // added this line
      title: 'GROCK',
      home: const GrockHome(),
    );
  }
}

class GrockHome extends StatefulWidget {
  const GrockHome({super.key});

  @override
  State<GrockHome> createState() => _GrockHomeState();
}

class _GrockHomeState extends State<GrockHome> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
