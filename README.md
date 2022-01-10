## Features

A flutter package with "Context, Navigation, Snackbar, RandomImage, RandomNumber, RandomColor, SizeExtension, KeyboardClose and ScrollEffect disable"  features.

```dart
  import 'package:grock/grock.dart';
  ///////////////////////////////////////////////////////////////////////
  Future delayed() async {
    // TODO Future.delayed alternative ( millisecond )
    await 3000.delay();
  }
  ///////////////////////////////////////////////////////////////////////
  GrockKeyboardClose(
      //TODO  click page, close keyboard
      child: Scaffold(),
  )
  ///////////////////////////////////////////////////////////////////////
  //TODO keyboard open or close
  floatingActionButton: context.isKeyBoardOpen
            ? null
            : FloatingActionButton(
                onPressed: () {
                  context.next(page: NextPage());
                },
                child: const Icon(Icons.navigate_next),
              ),
    ///////////////////////////////////////////////////////////////////////
    width: context.w * 0.3,
    height: context.h * 0.1,
    ///////////////////////////////////////////////////////////////////////
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
    ///////////////////////////////////////////////////////////////////////
       Text(
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
    ///////////////////////////////////////////////////////////////////////
    //TODO  MediaQuery.of(context).padding.top parameter is used to
    SizedBox(height: context.top / 3),
    ///////////////////////////////////////////////////////////////////////
    GrockScrollEffect(
    //TODO glow effect disable
      child: ListView(),
    )
    ///////////////////////////////////////////////////////////////////////
    Image.network(
    //TODO  random image
    index.randomImage(),
    width: context.w * 0.05,
    height: context.w * 0.05,
    );
    ///////////////////////////////////////////////////////////////////////
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
     ///////////////////////////////////////////////////////////////////////
     GrockSnackbar(
       grockSnackbarType: GrockSnackbarType.success,
       message: 'İşlem başarılı.',
     ).show(context);
```
