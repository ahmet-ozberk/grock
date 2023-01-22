extension DoubleExtension on double {
  String toLimitedString(int fractionDigits) {
    return this.toStringAsFixed(fractionDigits);
  }

  String toLimitedStringWithComma(int fractionDigits) {
    return this.toStringAsFixed(fractionDigits).replaceAll('.', ',');
  }

  double percent(double percent) {
    return this * percent / 100;
  }

  double percentAdd(double percent) {
    return this + this.percent(percent);
  }

  double percentSubtract(double percent) {
    return this - this.percent(percent);
  }

  double percentMultiply(double percent) {
    return this * this.percent(percent);
  }

  double percentDivide(double percent) {
    return this / this.percent(percent);
  }

  double get toRadian => this * (3.14 / 180);

  double get toDegree => this * (180 / 3.14);
}
