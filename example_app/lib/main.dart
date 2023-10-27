import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: Grock.navigationKey,
      scaffoldMessengerKey: Grock.scaffoldMessengerKey,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: CircleAvatar(),
                  ),
                  SizedBox(
                    height: 200,
                    child: CircleAvatar(),
                  ),
                  SizedBox(
                    height: 200,
                    child: CircleAvatar(),
                  ),
                  SizedBox(
                    height: 200,
                    child: CircleAvatar(),
                  ),
                  GrockMenu(
                    minWidth: context.width * 0.7,
                    backgroundColor: Colors.white,
                    backgroundBlur: 0,
                    spaceBlur: 4,
                    spaceColor: Colors.black12,
                    divider: (context, index) =>
                        const Divider(color: Colors.blueGrey, height: 0.1),
                    borderRadius: 8.borderRadius,
                    onTapClose: false,
                    isLeftSpace: true,
                    leftSpace: 20,
                    useBottomSafeArea: true,
                    slideTween: Tween<Offset>(
                        begin: const Offset(0, -0.24), end: Offset.zero),
                    items: List.generate(
                        5,
                        (index) => GrockMenuItem(
                            leading: Icon(Icons.r_mobiledata, size: 18),
                            text: "Item $index",
                            textStyle: TextStyle(
                              fontSize: 16,
                            ))),
                    child: const Icon(Icons.safety_divider),
                  ),
                  SizedBox(
                    height: 200,
                    child: CircleAvatar(),
                  ),
                  SizedBox(
                    height: 200,
                    child: CircleAvatar(),
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
