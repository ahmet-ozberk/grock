import 'package:example/next_page.dart';
import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
  Future delayed() async {
    // TODO Future.delayed alternative ( millisecond )
    await 3000.delay();
  }

  @override
  void initState() {
    super.initState();
    delayed();
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
                  context.next(page: NextPage());
                },
                child: const Icon(Icons.navigate_next),
              ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
              top: context.top, left: context.w * 0.1, right: context.w * 0.1),
          child: Center(
            child: Column(
              children: [
                Container(
                  width: context.w * 0.3,
                  height: context.h * 0.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [
                        //TODO random color
                        context.randomColor,
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
                        fontSize: context.w * 0.1,
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
                  height: context.h * 0.2,
                  width: context.w,
                  child: GrockScrollEffect(
                    //TODO glow effect disable
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          childAspectRatio: 1.0,
                          crossAxisSpacing: context.w * 0.01,
                          mainAxisSpacing: context.w * 0.01),
                      itemCount: 50,
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(
                          //TODO  random image
                          index.randomImage(),
                          width: context.w * 0.05,
                          height: context.w * 0.05,
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
                  //TODO   back page
                  child: const Text('Back Page'),
                  onPressed: () => context.back(),
                ),
                TextButton(
                  //TODO  next page
                  child: const Text('Next Page and Show Snackbar'),
                  onPressed: () => context.next(page: const NextPage()),
                ),
                TextButton(
                  //TODO   next remove until page
                  child: const Text('Next Remove Until Page'),
                  onPressed: () => context.nextRemove(page: const NextPage()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
