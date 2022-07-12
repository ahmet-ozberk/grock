extension StringExtension on String{
  String get capitalize => this[0].toUpperCase() + this.substring(1);
  String get capitalizeEach => this.split(" ").map((e) => e[0].toUpperCase() + e.substring(1)).join(" ");
  String get capitalizeEachFirst => this.split(" ").map((e) => e[0].toUpperCase() + e.substring(1)).join(" ");
  String get capitalizeEachFirstLower => this.split(" ").map((e) => e[0].toUpperCase() + e.substring(1)).join(" ").toLowerCase();
  String get capitalizeEachLower => this.split(" ").map((e) => e.toLowerCase()).join(" ");
  String get capitalizeEachLowerFirst => this.split(" ").map((e) => e[0].toLowerCase() + e.substring(1)).join(" ");
  String get capitalizeEachLowerFirstUpper => this.split(" ").map((e) => e[0].toUpperCase() + e.substring(1)).join(" ").toLowerCase();
  String get capitalizeEachUpper => this.split(" ").map((e) => e.toUpperCase()).join(" ");
  String get capitalizeEachUpperFirst => this.split(" ").map((e) => e[0].toUpperCase() + e.substring(1)).join(" ");
  String get capitalizeEachUpperFirstLower => this.split(" ").map((e) => e[0].toLowerCase() + e.substring(1)).join(" ").toUpperCase();
  String get capitalizeEachUpperLower => this.split(" ").map((e) => e.toLowerCase()).join(" ");
  String get capitalizeEachUpperLowerFirst => this.split(" ").map((e) => e[0].toLowerCase() + e.substring(1)).join(" ").toUpperCase();

  DateTime get toDate => DateTime.parse(this);
}