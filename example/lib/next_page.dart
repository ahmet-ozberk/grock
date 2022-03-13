import 'package:flutter/material.dart';
import 'package:grock/grock.dart';
import 'package:package_info_plus/package_info_plus.dart';

class NextPage extends StatelessWidget {
  const NextPage({Key? key}) : super(key: key);

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
              //TODO   back page
              child: const Text('Back Page'),
              onPressed: () => Grock.back(),
            ),
            TextButton(
              //TODO   back page
              child: const Text('Show Snackbar'),
              onPressed: () => Grock.snackBar(
                  title: "Snackbar",
                  description: "Snackbar content",
                  padding: 15,
                  borderRadius: 10),
            ),
          ],
        ),
      ),
    );
  }
}
