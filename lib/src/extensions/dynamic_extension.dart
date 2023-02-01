import 'dart:convert';

extension DynamicExtension on dynamic{
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
  bool get isNotPositive => this <= 0;
  bool get isNotNegative => this >= 0;
  bool get isEven => this % 2 == 0;
  bool get isOdd => this % 2 != 0;
  bool get isList => this is List;
  bool get isNotList => this is! List;
  bool get isMap => this is Map;
  bool get isNotMap => this is! Map;
  bool get isSet => this is Set;
  bool get isNotSet => this is! Set;
  bool get isString => this is String;
  bool get isNotString => this is! String;
  bool get isInt => this is int;
  bool get isNotInt => this is! int;
  bool get isDouble => this is double;
  bool get isNotDouble => this is! double;
  bool get isNum => this is num;
  bool get isNotNum => this is! num;
  bool get isBool => this is bool;
  bool get isNotBool => this is! bool;
  bool get isFunction => this is Function;
  bool get isNotFunction => this is! Function;
  bool get isIterable => this is Iterable;
  bool get isNotIterable => this is! Iterable;
  bool get isDateTime => this is DateTime;
  bool get isNotDateTime => this is! DateTime;
  bool get isDuration => this is Duration;
  bool get isNotDuration => this is! Duration;
  bool get isRegExp => this is RegExp;
  bool get isNotRegExp => this is! RegExp;
  bool get isUri => this is Uri;
  bool get isNotUri => this is! Uri;
  bool get isSymbol => this is Symbol;
  bool get isNotSymbol => this is! Symbol;
  bool get isType => this is Type;

  /// get type
  Type get hasValueType => this.runtimeType;

  /// json to object
  T? toObject<T>() => this is T ? this : null;

  toMap() => jsonDecode(this);
  toJson() => jsonEncode(this);
}