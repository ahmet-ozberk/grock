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
          body: Column(
            children: [
              GrockContainer(
                onTap: () {
                  Grock.snackBar(title: "title", description: "description", duration: Duration(seconds: 10));
                  Grock.toast(text: "Test Denemesi");
                },
                width: 100,
                height: 100,
                color: Colors.red,
                child: Text("GrockContainer"),
              ),
              15.height,
              GrockContainer(
                onTap: () {
                },
                width: 100,
                height: 100,
                color: Colors.red,
                child: Text("GrockContainer"),
              ),
              GrockHList(
                itemCount: 10,
                itemHeight: 55,
                itemWidth: 55,
                listHeight: 80,
                itemBuilder: (context, index) {
                  return Container();
                },
              ),
              GrockMenu(
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(borderRadius: 20.borderRadius, color: Colors.red),
                  ),
                  items: [GrockMenuItem(text: "test")])
            ],
          )),
    );
  }
}
