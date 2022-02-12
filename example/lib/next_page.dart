import 'package:example/try_snackbar/try_snackbar.dart';
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
                "Merhaba nasılsın?",
                type: SnackbarType.info,
                border: Border.all(color: Colors.white, width: 0.5),
                position: SnackbarPosition.top,
                padding: 15,
                borderRadius: 5,
                opacity: 0.5,
              ),
            ),
            TextButton(
              //TODO   back page
              child: const Text('Deneme'),
              onPressed: () =>
                  ScaffoldMessengerModel.showSnackbar("Merhaba nasılsın?",
                      // description: "Fonksiyon başarılı bir seiklde çalıştı.",
                      type: SnackbarType.success,
                      border: Border.all(color: Colors.white, width: 0.5),
                      backgroundColor: Colors.purple,
                      borderRadius: 30,
                      padding: 10,
                      textPosition: TextAlign.center),
            ),
            GestureDetector(
              onTap: () {
                print(getVersion());
              },
              child: Container(
                color: Colors.grey,
                height: Grock.width * 0.4,
                width: Grock.width,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getVersion() {
    String version = "";
    appVersion().then((value) {
      version = value.toString();
    });
    return version;
  }

  static Future<String> appVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }
}
