import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

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
            TextButton(
              //TODO   back page
              child: const Text('Back Page'),
              onPressed: () => Grock.back(),
            ),
            TextButton(
              //TODO   back page
              child: const Text('Show Snackbar'),
              onPressed: () => Grock.snackBar(
                "Merhaba nasılsın?",
                type: SnackbarType.info,
                border: Border.all(color: Colors.white, width: 0.5),
                position: SnackbarPosition.top,
                padding: 15,
                borderRadius: 5,
                opacity: 0.5,
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}
