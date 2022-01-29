## Features

A flutter package with "Context, Navigation, Snackbar, RandomImage, RandomNumber, RandomColor, SizeExtension, KeyboardClose and ScrollEffect disable"  features.

## main.dart file
```dart
import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

import 'next_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: Grock.navigationKey, /// add materialapp
      scaffoldMessengerKey: Grock.snackbarMessengerKey, /// add materialapp
      title: 'Material App',
      //theme: ThemeData.dark(),
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
    3000.delay(); /// 3000 millisecond
  }

  @override
  Widget build(BuildContext context) {
    return GrockKeyboardClose(
      //TODO  click page, close keyboard
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        //TODO keyboard open or close
        floatingActionButton: context.isKeyBoardOpen
            ? null
            : FloatingActionButton(
                onPressed: () {
                  Grock.to(NextPage());
                },
                child: const Icon(Icons.navigate_next),
              ),
        body: SingleChildScrollView(
          padding: 20.horizontalP,
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: 30.verticalP,
                  width: Grock.width * 0.3,
                  height: Grock.height * 0.1,
                  decoration: BoxDecoration(
                    borderRadius: 15.allBR,
                    gradient: LinearGradient(
                      colors: [
                        //TODO random color
                        context.randomColor,
                        context.randomColor,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      //TODO  random number
                      5.randomNum.toString(),
                      style: TextStyle(
                        fontSize: Grock.width * 0.1,
                        color: Colors.black,
                        shadows: const [
                          Shadow(
                            color: Colors.white,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //TODO  MediaQuery.of(context).padding.top parameter is used to
                SizedBox(height: context.top / 3),
                SizedBox(
                  height: Grock.height * 0.2,
                  width: Grock.width,
                  child: GrockScrollEffect(
                    //TODO glow effect disable
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          childAspectRatio: 1.0,
                          crossAxisSpacing: Grock.width * 0.01,
                          mainAxisSpacing: Grock.width * 0.01),
                      itemCount: 50,
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(
                          //TODO  random image
                          index.randomImage(),
                          width: Grock.width * 0.05,
                          height: Grock.width * 0.05,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: context.isKeyBoardOpen
                        ? 'Open Keyboard'
                        : 'Close Keyboard',
                  ),
                ),
                TextButton(
                  //TODO  next page
                  child: const Text('Next Page and Show Snackbar'),
                  onPressed: () =>
                      Grock.to(NextPage(), type: NavType.bottomToTop),
                ),
                TextButton(
                  //TODO   next remove until page
                  child: const Text('Next Remove Until Page'),
                  onPressed: () => Grock.toRemove(NextPage()),
                ),

                TextButton(
                  child: const Text('Show Snackbar'),
                  onPressed: () => Grock.snackBar(
                    "Merhaba nasılsın?",
                    type: SnackbarType.info,
                    border: Border.all(color: Colors.white, width: 0.5),
                    position: SnackbarPosition.bottom,
                    padding: 15,
                    borderRadius: 5,
                    opacity: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


```
