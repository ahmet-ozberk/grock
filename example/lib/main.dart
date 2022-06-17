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
          body: SingleChildScrollView(
            padding: 20.horizontalP,
            child: Center(
              child: Column(
                children: [
                  Container(
                    margin: 10.verticalP,
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
                  GrockContainer(
                    onTap: () => print("onTapped"),
                    margin: 10.allP,
                    width: 30,
                    height: 30,
                    onLongPress: () => print("onLongPressed"),
                    decoration: BoxDecoration(
                      color: context.randomColor,
                      borderRadius: 5.allBR,
                    ),
                  ),
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
                    onPressed: () {
                      Grock.snackBar(
                          title: "Title Desc",
                          description: "DESCRİPTİON DESC",
                          position: SnackbarPosition.top);
                      Grock.to(NextPage(), type: NavType.bottomToTop);
                    },
                  ),
                  TextButton(
                    //TODO   next remove until page
                    child: const Text('Next Remove Until Page'),
                    onPressed: () => Grock.toRemove(NextPage()),
                  ),
                ],
              ),
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
