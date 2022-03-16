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
              child: const Text('No Context Dialog'),
              onPressed: () {
                Grock.dialog(builder: (context) {
                  return const AlertDialog(
                    title:  Text('Dialog'),
                    content:  Text('Dialog content'),
                  );
                });
              },
            ),
            TextButton(
              //TODO   back page
              child: const Text('Show Snackbar'),
              onPressed: () => Grock.snackBar(
                title: "Snackbar",
                description: "Snackbar content",
                curve: Curves.elasticInOut,
                padding: 15,
                durationMillisecond: 2000,
                borderRadius: 10,
                blur: 20,
                opacity: 0.2,
                icon: Icons.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
