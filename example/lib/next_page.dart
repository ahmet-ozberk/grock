import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

class NextPage extends StatefulWidget {
  const NextPage({Key? key}) : super(key: key);

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Next Page'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                // start code
                GrockSnackbar(
                  grockSnackbarType: GrockSnackbarType.success,
                  message: 'İşlem başarılı.',
                ).show(context);
              },
              child: Text('Success'),
            ),
            TextButton(
              onPressed: () {
                // start code
                GrockSnackbar(
                  grockSnackbarType: GrockSnackbarType.error,
                  message: 'İşlem başarısız.',
                  grockSnackbarShape: GrockSnackbarShape.normal,
                  grockSnackbarPosition: GrockSnackbarPosition.top,
                  onTap: () {
                    print('tapped');
                  },
                ).show(context);
              },
              child: Text('Error'),
            ),
            TextButton(
              onPressed: () {
                // start code
                GrockSnackbar(
                  grockSnackbarType: GrockSnackbarType.warning,
                  message: 'İşlem devam ederken sorun oluştu.',
                ).show(context);
              },
              child: Text('Warning'),
            ),
            TextButton(
              onPressed: () {
                // start code
                GrockSnackbar(
                  grockSnackbarType: GrockSnackbarType.info,
                  message: 'İşlem başladı..',
                ).show(context);
              },
              child: Text('Info'),
            ),
            const Divider(),
            SizedBox(
              height: context.h * 0.01,
            ),
            TextButton(
              onPressed: ()=>context.back(),
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
