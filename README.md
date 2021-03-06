# Grock

![alt text](https://wallpaperaccess.com/full/2764317.jpg)

This is an excellent Flutter package mate π―π―π―π―π―π―π―π―π―π―π―π―π―π―π―
## Grock UI Tools Demo
![grock_ui_tools_demo](https://user-images.githubusercontent.com/83654764/174483340-22b539a0-9d9b-442b-8011-3829f029d8bd.gif)

[pub.dev link](https://pub.dev/packages/grock)

## Firstly π€«
```dart
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    navigatorKey: Grock.navigationKey, // added line
    scaffoldMessengerKey: Grock.scaffoldMessengerKey, // added line
    title: 'Material App',
    home: Home(),
  );
```

## NO CONTEXT NAVΔ°GATΔ°ONS π±
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

## Widgets π π

### GrockContainer
```dart
GrockContainer(
  onTap: ()=>print("tapped"),
  child: Text("On Tap Container")
)
```

### GrockButton
```dart
GrockButton(
  child: const Text("GrockButton"),
  onTap: (){},
),
```

### GrockMenu [IOS Style]
```dart
GrockMenu(
  items: [
    GrockMenuItem(
      text: 'Copy',
      trailing: const Icon(Icons.copy,size: 20,),
      onTap: (){
        // Item Tap
        GrockMenu.close(); // close menu
      }
    ),
    GrockMenuItem(
      text: 'Share',
      trailing: const Icon(Icons.ios_share_rounded,size: 20,),
    ),
  ],
  child: const Icon(CupertinoIcons.ellipsis_circle_fill,color: Colors.blue,),
  onTapClose: true, // Close menu when tapping GrockMenuItem, [true by default]
  onTap: (value){
   switch (value) {
    case 0:
      print("Tap Copy");
      break;
    case 1:
      print("Tap Share");
      break;
    default:
      print("Tap Default");
      break;
   }
  },
  dividerBuilder: (context,index)=>index == 1 ? 
  const Divider(height: 0,color: Colors.red,thickness: 2,) : 
  const Divider(color: CupertinoColors.separator,thickness: 1,height: 0,),
)
```

### GrockDropdownButton [IOS Style]
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
  hintText: "Selection",
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

### GrockGlassmorphism [IOS Style]
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

## Snackbar and Dialog and Toast (BUT NO CONTEXT π)

### Grock.snackBar [IOS Style]
```dart
TextButton(
  child: const Text('No Context Snackbar'),
    Grock.snackBar(
      title: "Snackbar",
      description: "Snackbar content",
      blur: 20,
      opacity: 0.2,
      leading: Icon(Icons.error),
      curve: Curves.elasticInOut,
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
GrockButton(
  color: Colors.white,
  child: const Text(
     "Show Toast",
  ),
  onTap: () => Grock.toast(
  text: "This is a toast",
  ),
),
```

## Widget Tools π€©
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

### int Extension
```dart
50.randomNum(), // 0-50 random number
index.randomImage(),
30.lorem(), // lorem ipsum text
20.height(), // SizedBox(height: 20)
20.width(), // SizedBox(width: 20)
20.heightWidth(), // SizedBox(height: 20,width: 20)
```


### BuildContext extension
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

### Grock extension [No BuildContext]
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
