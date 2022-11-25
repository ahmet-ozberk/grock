# Grock

![alt text](https://wallpaperaccess.com/full/2764317.jpg)

This is an excellent Flutter package mate 💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯
## Grock UI Tools Demo

![grock_button](https://user-images.githubusercontent.com/83654764/204043399-b20c7c51-918e-4840-8314-df7faf0b80a0.png)
![grock_timer](https://user-images.githubusercontent.com/83654764/204043401-10018bfa-4e1c-4f74-90c0-54625411c6e1.png)
![grock_direct_selection_menu](https://user-images.githubusercontent.com/83654764/204043406-be754e40-80bd-4ab5-86e0-6590773dfd7c.png)
![grock_menu](https://user-images.githubusercontent.com/83654764/204043407-96e300ff-4565-4444-b0d8-d45fcc9da95d.png)
![grock_dropdown](https://user-images.githubusercontent.com/83654764/204043408-7e23c96b-2705-4603-af9e-091da6f4d4b1.png)
![grock_info_widget](https://user-images.githubusercontent.com/83654764/204043411-00194295-ffc1-42bf-bf98-03348367b975.png)
![grock_snackbar](https://user-images.githubusercontent.com/83654764/204043414-a33d2c78-0089-40dd-8cde-39b6de6c24e7.png)
![grock_toast](https://user-images.githubusercontent.com/83654764/204043415-9a21e719-cf1c-4408-be37-3709999a080a.png)

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
  isKeyboardDismiss: true // default true, optional keyboard dismiss
  isTapAnimation: true //default true, optional tap animation
  onTap: ()=>print("tapped"),
  child: Text("On Tap Container")
)
```

### GrockButton
![grock_button](https://user-images.githubusercontent.com/83654764/204043245-93287478-9562-4ab9-9cda-b4038bd58d1b.png)

```dart
GrockButton(
  child: const Text("GrockButton"),
  onTap: (){},
),
```

### GrockDirectSelectionMenu
![grock_direct_selection_menu](https://user-images.githubusercontent.com/83654764/204043262-3c8793e9-53c8-404d-98f1-9abd39b8e5e9.png)

```dart
GrockDirectSelectionMenu(
  width: double.infinity,
  margin: const EdgeInsets.all(20),
  hintText: "Selection Data",
  value: listActiveIndex,
  onChanged: (index) {
    setState(() {
      listActiveIndex = index;
    });
  },
  items: List.generate(
    list.length,
    (index) => Text(list[index]),
  ),
  /// [Customize your own widget]
  // child: Row(
  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //   children: [
  //   Text(listActiveIndex == null ? "Please selection data" : list[listActiveIndex!]),
  //   listActiveIndex == null ? const Icon(Icons.menu) : Text(list[listActiveIndex ?? 0])
  //   ],
  // ),
 ),
```

### GrockTimer
![grock_timer](https://user-images.githubusercontent.com/83654764/204043285-37f76f5f-c6f9-47ba-803c-a2d6e08c9784.png)

```dart
/// final timerController = GrockTimerController();
GrockTimer(
  controller: timerController,
  startTime: const Duration(seconds: 10),
  endTime: const Duration(seconds: 0),
),
```

### GrockMenu [IOS Style]
![grock_menu](https://user-images.githubusercontent.com/83654764/204043297-167482dd-eb77-4631-a20e-bc724faa1c70.png)

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
![grock_dropdown](https://user-images.githubusercontent.com/83654764/204043309-120eff0e-19e0-45d9-b890-aae3293d6b50.png)

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
  position: PositionF.bottom,
  duration: Duration(seconds: 2),
  curve: Curves.bounceOut,
  child: child(),
)
```

### GrockGlassmorphism [IOS Style]
```dart
GrockGlassMorphism(
  blur: 20,
  opacity: 0.2,
  borderRadius: BorderRadius.circular(12),
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
    //android drag and scroll effect disable
    body: ListView.builder(
      ....
    ),
  ),
);
```

### GrockHList
```dart
return GrockHList(
  itemCount: 10,
  itemHeight: 55,
  itemWidth: 55,
  listHeight: 80,
  itemBuilder: (context, index) {
    return Container();
  },
);
```

### GrockInfoWidget
![grock_info_widget](https://user-images.githubusercontent.com/83654764/204043326-8bf72044-7819-4f20-8fa6-870b0032fa33.png)

```dart
return GrockInfoWidget(
  msg: "Grock Info Popup Tooltip"
);
```

### GrockWidgetSize
```dart
return GrockWidgetSize(
  callback: (Size size, Offset offset){
    print("Size: $size");
    print("Offset: $offset");
  },
  child: Container(),
);
```

### GrockWidgetSize
```dart
return GrockWidgetSize(
  callback: (Size size, Offset offset){
    print("Size: $size");
    print("Offset: $offset");
  },
  child: Container(),
);
```

### GrockCustomLoadingWidget or Grock.loadingPopup()
```dart
Grock.loadingPopup(
  backgroundColor: Colors.black.withOpacity(0.5),
  color: Colors.white,
  borderRadius: BorderRadius.circular(12)
);
return GrockCustomLoadingWidget(
  backgroundColor: Colors.black.withOpacity(0.5),
  color: Colors.white,
  borderRadius: BorderRadius.circular(12)
);
```

### Grock Internet Check Function
```dart
  //Splash Screen initState
  @override
  void initState() {
    super.initState();
    Grock.checkInternet();
  }
```


## Snackbar and Dialog and Toast (BUT NO CONTEXT 😁)

### Grock.snackBar [IOS Style]
![grock_snackbar](https://user-images.githubusercontent.com/83654764/204043338-b4611e9a-781f-4e23-923a-d6ad1e87b183.png)

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
![grock_toast](https://user-images.githubusercontent.com/83654764/204043352-0870407f-899d-470f-9a29-1c0a8b2d6c01.png)

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

### List Extension
```dart
['data','data1'].mapIndexed((value, index){})
['data','data1'].forLoop((value, index){})
['data','data1'].mapIndexedWhere((value, index))
['data','data1'].mapFiltered((value){})
```

### String Extension
```dart
String.capitalize
String.capitalizeEach
String.capitalizeEachFirst
String.capitalizeEachFirstLower
String.capitalizeEachLower
String.capitalizeEachLowerFirst
String.toDate
String.filter
String.filterNumber
String.forEach
String.forEachFirst
String.forEachFirstLower
String.isPhoneNumber
String.isPhoneNumberWithCountryCode
String.isPhoneNumberWithCountryCodeAndSpace
String.isTurkeyPhoneNumber
String.isTurkeyPhoneNumberWithCountryCode
String.isTurkeyPhoneNumberWithCountryCodeAndSpace
String.isEmail
String.isUrl
String.isUrlWithSpace
String.isEmpty
String.dateTime
String.isDateTimeFormat
```

## Widget Tools 🤩
### Widget Extensions
```dart
Container().visible(val),
Container().disable(disable),
Container().disableOpacity(disable and opacity: 0.2),
Container().expanded(),
Container().size(width,height),
Container().margin(l,t,r,b),
Container().rotate(),
Container().alignment(alignment),
Container().tooltip(msg),
Container().onTap((){}),
Container().bgBlur(10),
Container().borderRadius(10),
Container().decoration(BoxDecoration),
Container().colored(Color),
Container().shadow(),  
Container().animatedRotation(),
Container().upRotation,
Container().rightRotation,
Container().leftRotation,
Container().bottomRotation,
```

### int Extension
```dart
50.randomNum(), // 0-50 random number
index.randomImage(),
index.randomImg()
30.lorem(), // lorem ipsum text
20.height(), // SizedBox(height: 20)
20.width(), // SizedBox(width: 20)
20.heightWidth(), // SizedBox(height: 20,width: 20)
20.borderRadius,
20.borderRadiusOnlyTopLeft,
20.borderRadiusOnlyTopRight,
20.borderRadiusOnlyBottomLeft,
20.borderRadiusOnlyBottomRight,
20.borderRadiusOnlyTop,
20.borderRadiusOnlyBottom,
20.padding,
20.paddingOnlyTop,
20.paddingOnlyBottomRight,
20.paddingOnlyLeftRight,
20.getRandomString(15), // 15 length random string
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
Grock.hideKeyboard,
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
    index.randomImg(), // width and height optional
  ),
)
```
