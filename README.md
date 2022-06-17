## Grock

![alt text](https://wallpaperaccess.com/full/2764317.jpg)

This is an excellent Flutter package mate 💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯

[pub.dev link](https://pub.dev/packages/grock)

## Firstly 🤫
```dart
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    navigatorKey: Grock.navigationKey, // added line
    scaffoldMessengerKey: Grock.scaffoldMessengerKey, // added line
    title: 'Material App',
    home: Home(),
  );
```

## NO CONTEXT NAVİGATİONS 😱
### Grock.to || toRemove || back()
```dart
GrockContainer(
  onTap: (){
    // for Navigator.push(...)
    Grock.to(Nextpage());
    Grock.to(NextPage(), type: NavType.bottomToTop); // optional navigate animation

    // for Navigator.pushAndRemoveUntil(context, newRoute, (route) => false)
    Grock.toRemove(NextPage());

    // for Navigator.of(context).pop()
    Grock.back();
    Grock.back(result: "Return Object") // optional return object

  },
)
```

## Widgets 👊 🚀

### GrockContainer
```dart
GrockContainer(
  onTap: ()=>print("tapped"),
  child: Text("On Tap Container")
)
```

### GrockDropdownButton
```dart
GrockDropdownButton(
  items: [
    for (var item in items)
      GrockDropdownMenuItem(
        child: Text(item),
        onPressed: (String? newValue) {
          setState(() {
            currentValue = newValue;
          });
          Grock.back();
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
  hintText: "Lütfen bir item seçin",
),
```

### GrockFadeAnimation
```dart
GrockFadeAnimation(
  initialPosition: InitialPosition.bottom,
  duration: Duration(seconds: 2),
  curve: Curves.bounceOut,
  child: child(),
)
```

### GrockList
```dart
GrockList(
  isExpanded: true,
  itemSpace: const Divider(),
  itemCount: 10,
  itemBuilder: (context,index)=>Text("Custom ListView Builder"),
)
```

### GrockGlassmorphism
```dart
GrockGlassMorphism(
  blur: 20,
  opacity: 0.2,
  child: Image(".../images.png") or Container(child: Icon(Icons.search)),
  color: Colors.white,
),
```

### GrockKeyboardClose
```dart
return GrockKeyboardClose(
  child: Scaffold(
    // Scaffold on tap and close keyboard
    body: TextField(

    ),
  ),
);
```

### GrockScrollEffect
```dart
return GrockScrollEffect(
  child: Scaffold(
    // drag and scroll effect disable
    body: ListView.builder(
      ....
    ),
  ),
);
```

## Snackbar, Dialog and Toast (BUT NO CONTEXT 😁)

### Grock.snackBar
```dart
TextButton(
  child: const Text('No Context Snackbar'),
    Grock.snackBar(
      title: "Snackbar",
      description: "Snackbar content",
      blur: 20,
      opacity: 0.2,
      icon: Icons.error,
      curve: Curves.elasticInOut,
      durationMillisecond: 2000,
      borderRadius: 10,
      // ... vs parameters
    ),
),
```

### Grock.dialog
```dart
TextButton(
  child: const Text('No Context Dialog'),
  onPressed: () {
    Grock.dialog(builder: (_) {
      return const AlertDialog(
        title:  Text('Dialog'),
        content:  Text('Dialog content'),
      );
    });
  },
),
```

### Grock.toast
```dart
TextButton(
  child: const Text('Grock Toast'),
  onPressed: () {
    Grock.toast(text: "Grock Toast Message");
  },
),
```

## Widget Tools 🤩
### Widget Extensions
```dart
Container().visible(val),
Container().disable(disable),
Container().disableOpacity(disable and opacity: 0.2),
Container().expanded(),
Container().sized(width,height),
Container().margin(l,t,r,b),
Container().rotate(),
Container().alignment(alignment),
Container().tooltip(msg),
Container().onTap((){}),
Container().bgBlur(10),
Container().borderRadius(10),
Container().decoration(BoxDecoration),
Container().colored(Color),
```

### Int Extension
```dart
50.randomNum(), // 0-50 random number
index.randomImage(),
30.lorem(), // lorem ipsum text
20.height(), // SizedBox(height: 20)
20.width(), // SizedBox(width: 20)
20.heightWidth(), // SizedBox(height: 20,width: 20)
```


### context tools
```dart
context.bottom, // SafeArea Bottom
context.top,    // SafeArea Top
context.isKeyBoardOpen, // true or false
context.mediaQuery,
context.textTheme, // TextTheme extension
context.orientation,
context.isLandscape,
context.isPortrait,
context.platformBrightness,
context.isPhone, // device size < 600
context.isSmallTablet,
context.isLargeTablet,
context.platform,
context.openDrawer,
context.openEndDrawer,
context.hideCurrentSnackBar,
context.removeCurrentSnackBar,
context.showSnackBar,
context.isTablet,
context.showBottomSheet,
context.hasFocus,
context.isFirstFocus,
context.nextFocus,
context.unfocus,
context.consumeKeyboardToken,
context.validate,
context.reset,
context.save,
context.closeKeyboard,
```

### no CONTEXT tools
```dart
Grock.height,
Grock.width,
Grock.bottomCenter,
Grock.bottomLeft,
Grock.bottomRight,
Grock.center,
Grock.centerLeft,
Grock.centerRight,
Grock.topLeft,
Grock.topRight,
Grock.topCenter,
Grock.deviceWidth,
Grock.deviceHeight,
Grock.isIOS,
Grock.isAndroid,
Grock.isMacOS,
Grock.isWindows,
Grock.isLinux,
Grock.isFuchsia,
Grock.isDebugMode,
Grock.isReleaseMode,
Grock.isProfileMode,
```

### Padding or Margin and BorderRadius
```dart
  GrockContainer(
    margin: 10.verticalP,
    // margin: 10.horizontalP,
    // margin: 10.allP,
    padding: [20,40].horizontalAndVerticalP,
    // padding: [10,13,14,12].paddingLTRB
    width: Grock.width * 0.3,
    height: Grock.height * 0.1,
    decoration: BoxDecoration(
      borderRadius: 15.allBR,
  ),
),
```

### Random Online Image
```dart
GrockList(
  isExpanded: true,
  itemSpace: const Divider(),
  itemCount: 10,
  itemBuilder: (context,index)=>Image.network(
    index.randomImage(), // width and height optional
  ),
)
```
