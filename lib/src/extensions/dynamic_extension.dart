extension DynamicExtension on dynamic {
  bool get isNull => this == null;
  bool get isNotNull => this != null;
  bool get isNotEmpty => this != null && this != '';
  bool get isEmpty => this == null || this == '';
  bool get isTrue => this == true;
  bool get isFalse => this == false;
  bool get isZero => this == 0;
  bool get isNotZero => this != 0;
  bool get isPositive => this > 0;
  bool get isNegative => this < 0;
  bool get isDateTime => this is DateTime;
  bool get isNotDateTime => this is! DateTime;
  bool get isDuration => this is Duration;
  bool get isNotDuration => this is! Duration;
  bool get isRegExp => this is RegExp;
  bool get isNotRegExp => this is! RegExp;
  bool get isType => this is Type;

  /// get type
  Type get hasValueType => this.runtimeType;

  /// json to object
  T? toObject<T>() => this is T ? this : null;

  /// is Map
  bool get isMap => this is Map;

  /// is List
  bool get isList => this is List;

  /// is String
  bool get isString => this is String;

  /// is Map or Null
  bool get isMapOrNull => this is Map || this == null;

  /// is List or Null
  bool get isListOrNull => this is List || this == null;

  bool isTypeOf<T>() => this is T;
}
