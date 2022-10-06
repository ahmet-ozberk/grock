import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: Grock.navigationKey,
      scaffoldMessengerKey: Grock.scaffoldMessengerKey,
      title: 'Material App',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GrockKeyboardClose(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: 40.padding,
          child: GrockMenu(
            child: Icon(
              Icons.menu,
              size: 40,
            ),
            items: List.generate(50, (index) => index)
                .map((e) => GrockMenuItem(
                      text: e.toString(),
                      onTap: () {
                        Grock.toast(text: e.toString());
                      },
                    ))
                .toList(),
          ),
        ).colored(color: Colors.red),
      ),
    );
  }
}
