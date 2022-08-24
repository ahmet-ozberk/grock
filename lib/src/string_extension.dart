extension StringExtension on String {
  String get capitalize => this[0].toUpperCase() + this.substring(1);
  String get capitalizeEach =>
      this.split(" ").map((e) => e[0].toUpperCase() + e.substring(1)).join(" ");
  String get capitalizeEachFirst =>
      this.split(" ").map((e) => e[0].toUpperCase() + e.substring(1)).join(" ");
  String get capitalizeEachFirstLower => this
      .split(" ")
      .map((e) => e[0].toUpperCase() + e.substring(1))
      .join(" ")
      .toLowerCase();
  String get capitalizeEachLower =>
      this.split(" ").map((e) => e.toLowerCase()).join(" ");
  String get capitalizeEachLowerFirst =>
      this.split(" ").map((e) => e[0].toLowerCase() + e.substring(1)).join(" ");
  String get capitalizeEachLowerFirstUpper => this
      .split(" ")
      .map((e) => e[0].toUpperCase() + e.substring(1))
      .join(" ")
      .toLowerCase();
  String get capitalizeEachUpper =>
      this.split(" ").map((e) => e.toUpperCase()).join(" ");
  String get capitalizeEachUpperFirst =>
      this.split(" ").map((e) => e[0].toUpperCase() + e.substring(1)).join(" ");
  String get capitalizeEachUpperFirstLower => this
      .split(" ")
      .map((e) => e[0].toLowerCase() + e.substring(1))
      .join(" ")
      .toUpperCase();
  String get capitalizeEachUpperLower =>
      this.split(" ").map((e) => e.toLowerCase()).join(" ");
  String get capitalizeEachUpperLowerFirst => this
      .split(" ")
      .map((e) => e[0].toLowerCase() + e.substring(1))
      .join(" ")
      .toUpperCase();

  DateTime get toDate => DateTime.parse(this);

  String get filter => this.replaceAll(RegExp(r"[^a-zA-Z0-9]"), "");
  String get filterNumber => this.replaceAll(RegExp(r"[^0-9]"), "");
  String get filterNumberDecimal => this.replaceAll(RegExp(r"[^0-9.]"), "");
  String get filterNumberDecimalComma =>
      this.replaceAll(RegExp(r"[^0-9,]"), "");
  String get filterNumberDecimalCommaDot =>
      this.replaceAll(RegExp(r"[^0-9.,]"), "");
  String get filterNumberDecimalCommaDotSpace =>
      this.replaceAll(RegExp(r"[^0-9., ]"), "");
  String get filterNumberDecimalCommaDotSpaceSpace =>
      this.replaceAll(RegExp(r"[^0-9., ] "), "");
  String get filterNumberDecimalCommaDotSpaceSpaceSpace =>
      this.replaceAll(RegExp(r"[^0-9., ]  "), "");

  String get forEach =>
      this.split(" ").map((e) => e[0].toUpperCase() + e.substring(1)).join(" ");
  String get forEachFirst =>
      this.split(" ").map((e) => e[0].toUpperCase() + e.substring(1)).join(" ");
  String get forEachFirstLower => this
      .split(" ")
      .map((e) => e[0].toUpperCase() + e.substring(1))
      .join(" ")
      .toLowerCase();
  String get forEachLower =>
      this.split(" ").map((e) => e.toLowerCase()).join(" ");
  String get forEachLowerFirst =>
      this.split(" ").map((e) => e[0].toLowerCase() + e.substring(1)).join(" ");
  String get forEachLowerFirstUpper => this
      .split(" ")
      .map((e) => e[0].toUpperCase() + e.substring(1))
      .join(" ")
      .toLowerCase();
  String get forEachUpper =>
      this.split(" ").map((e) => e.toUpperCase()).join(" ");
  String get forEachUpperFirst =>
      this.split(" ").map((e) => e[0].toUpperCase() + e.substring(1)).join(" ");
  String get forEachUpperFirstLower => this
      .split(" ")
      .map((e) => e[0].toLowerCase() + e.substring(1))
      .join(" ")
      .toUpperCase();
  String get forEachUpperLower =>
      this.split(" ").map((e) => e.toLowerCase()).join(" ");
  String get forEachUpperLowerFirst => this
      .split(" ")
      .map((e) => e[0].toLowerCase() + e.substring(1))
      .join(" ")
      .toUpperCase();
  String get forEachUpperLowerFirstUpper => this
      .split(" ")
      .map((e) => e[0].toUpperCase() + e.substring(1))
      .join(" ")
      .toLowerCase();

  bool get isPhoneNumber => this.length == 11 && this.startsWith("0");
  bool get isPhoneNumberWithCountryCode =>
      this.length == 13 && this.startsWith("+");
  bool get isPhoneNumberWithCountryCodeAndSpace =>
      this.length == 14 && this.startsWith("+ ");

  String get lower => this.toLowerCase();
  String get lowerFirst => this[0].toLowerCase() + this.substring(1);
  String get lowerFirstUpper =>
      this[0].toUpperCase() + this.substring(1).toLowerCase();
  String get lowerFirstUpperLower =>
      this[0].toLowerCase() + this.substring(1).toLowerCase();
  String get lowerFirstUpperLowerFirst =>
      this[0].toLowerCase() +
      this.substring(1).toLowerCase() +
      this.substring(2);
  String get lowerFirstUpperLowerFirstUpper =>
      this[0].toUpperCase() +
      this.substring(1).toLowerCase() +
      this.substring(2).toLowerCase();
  String get lowerFirstUpperLowerFirstUpperLower =>
      this[0].toLowerCase() +
      this.substring(1).toLowerCase() +
      this.substring(2).toLowerCase();
  String get lowerFirstUpperLowerFirstUpperLowerFirst =>
      this[0].toLowerCase() +
      this.substring(1).toLowerCase() +
      this.substring(2).toLowerCase() +
      this.substring(3);

  bool get isTurkeyPhoneNumber => this.length == 10 && this.startsWith("5");
  bool get isTurkeyPhoneNumberWithCountryCode =>
      this.length == 13 && this.startsWith("+90");
  bool get isTurkeyPhoneNumberWithCountryCodeAndSpace =>
      this.length == 14 && this.startsWith("+90 ");

  bool get isEmail => this.contains("@") && this.contains(".");
  bool get isEmailWithSpace => this.contains(" @");
  bool get isEmailWithSpaceSpace => this.contains(" @ ");

  bool get isUrl =>
      this.contains(".com") ||
      this.contains(".net") ||
      this.contains(".org") ||
      this.contains(".io") ||
      this.contains(".me") ||
      this.contains(".info") ||
      this.contains(".biz") ||
      this.contains(".name") ||
      this.contains(".co") ||
      this.contains(".tv") ||
      this.contains(".us") ||
      this.contains(".uk") ||
      this.contains(".ca") ||
      this.contains(".de") ||
      this.contains(".fr") ||
      this.contains(".it") ||
      this.contains(".ru") ||
      this.contains(".es") ||
      this.contains(".nl") ||
      this.contains(".se") ||
      this.contains(".no") ||
      this.contains(".pl") ||
      this.contains(".ch") ||
      this.contains(".jp") ||
      this.contains(".cn") ||
      this.contains(".in") ||
      this.contains(".br") ||
      this.contains(".au") ||
      this.contains(".nz") ||
      this.contains(".tr") ||
      this.contains(".kr") ||
      this.contains(".tw") ||
      this.contains(".hk") ||
      this.contains(".my");

  bool get isUrlWithSpace =>
      this.contains(".com ") ||
      this.contains(".net ") ||
      this.contains(".org ") ||
      this.contains(".io ") ||
      this.contains(".me ") ||
      this.contains(".info ") ||
      this.contains(".biz ") ||
      this.contains(".name ") ||
      this.contains(".co ") ||
      this.contains(".tv ") ||
      this.contains(".us ") ||
      this.contains(".uk ") ||
      this.contains(".ca ") ||
      this.contains(".de ") ||
      this.contains(".fr ") ||
      this.contains(".it ") ||
      this.contains(".ru ") ||
      this.contains(".es ") ||
      this.contains(".nl ") ||
      this.contains(".se ") ||
      this.contains(".no ") ||
      this.contains(".pl ") ||
      this.contains(".ch ") ||
      this.contains(".tr ") ||
      this.contains(".jp ") ||
      this.contains(".cn ") ||
      this.contains(".in ") ||
      this.contains(".br ") ||
      this.contains(".au ") ||
      this.contains(".nz ") ||
      this.contains(".kr ") ||
      this.contains(".tw ") ||
      this.contains(".hk ") ||
      this.contains(".my ");

  bool get isEmpty => this.trim().isEmpty;

  DateTime? get dateTime => DateTime.tryParse(this);

  bool get isDateTime => this.dateTime != null;

  bool get isNotDateTime => this.dateTime == null;

  bool get isDateTimeFormat =>
      this.isDateTime && this.dateTime.toString().contains(" ");

  bool get isNotDateTimeFormat =>
      this.isDateTime && !this.dateTime.toString().contains(" ");

  String get dateTimeFormat =>
      this.isDateTime ? this.dateTime.toString().split(" ")[0] : "";
  String get dateTimeFormatWithSpace =>
      this.isDateTime ? this.dateTime.toString().split(" ")[0] + " " : "";
}
