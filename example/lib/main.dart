import 'package:example/next_page.dart';
import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GrockKeyboardClose(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: ListView(
            children: [
              Text(5.randomNum.toString()),
              SizedBox(height: context.height * 0.1),
              Container(width: 100, height: 100, color: context.randomColor),
              SizedBox(height: context.top),
              Image.network(100.randomImage()),
              TextButton(
                child: Text('Back Page'),
                onPressed: () => context.back(),
              ),
              TextButton(
                child: Text('Next Page'),
                onPressed: () => context.next(page: NextPage()),
              ),
              TextButton(
                child: Text('Next Remove Until Page'),
                onPressed: () => context.nextRemove(page: NextPage()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
