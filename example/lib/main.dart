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
      //TODO  click page, close keyboard
      child: SafeArea(
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
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GrockButton(
                  onTap: () {
                    Grock.toast(
                        text: "Text Toast Message",
                        alignment: Alignment.center,
                        curve: Curves.fastLinearToSlowEaseIn);
                  },
                ),
                GrockInfoWidget(
                  child: const Icon(Icons.info),
                  message: "This is a message",
                  margin: EdgeInsets.all(2),
                ),
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NextPage extends StatefulWidget {
  const NextPage({Key? key}) : super(key: key);

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  List<String> items = [];
  String? currentValue;

  @override
  void initState() {
    for (var i = 0; i < 10; i++) {
      setState(() {
        items.add(
          "İtem $i",
        );
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Next page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: context.randomColor,
              height: Grock.width * 0.5,
              width: Grock.width * 0.5,
            ),
            TextButton(
              child: const Text('No Context Dialog'),
              onPressed: () {
                Grock.dialog(builder: (context) {
                  return const AlertDialog(
                    title: Text('Dialog'),
                    content: Text('Dialog content'),
                  );
                });
              },
            ),
            TextButton(
                //TODO   back page
                child: const Text('Show Snackbar'),
                onPressed: () {
                  Grock.snackBar(
                    title: "Title",
                    description: "Description",
                    position: SnackbarPosition.bottom,
                    color: Colors.black,
                  );
                }),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GrockDropdownButton(
                items: [
                  for (var item in items)
                    GrockDropdownMenuItem(
                      child: Text(item),
                      onPressed: (String? newValue) {
                        setState(() {
                          currentValue = newValue;
                        });
                        Navigator.pop(context);
                      },
                      decoration: BoxDecoration(
                        color: currentValue == item
                            ? Colors.grey.shade200
                            : Colors.white,
                      ),
                      trailingWidget: currentValue == item
                          ? const Icon(Icons.check, color: Colors.green)
                          : null,
                    ),
                ],
                value: currentValue,
                hintText: "Please selection item.",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
