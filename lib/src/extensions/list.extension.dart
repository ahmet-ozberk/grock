import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

extension ExtendedIterable<E> on Iterable<E> {
  /// Like Iterable<T>.map but the callback has index as second argument
  /// and the index is not reset after each iteration.
  /// Grock MapIndexed<T, U>
  Iterable<T> mapIndexed<T>(T Function(E value, int index) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }

  /// Like Iterable<T>.map but the callback has index as second argument
  /// and the index is start from 0
  /// Grock ForLoop example:
  void forLoop(void Function(E value, int index) f) {
    var index = 0;
    for (int i = 0; i < length; i++) {
      f(elementAt(i), index);
      index++;
    }
  }

  /// Like Iterable<T>.map but the callback has index as second argument
  /// and the index is start from 0
  /// Grock ForLoop example:
  void forLoopReverse(void Function(E value, int index) f) {
    var index = length - 1;
    for (int i = length - 1; i >= 0; i--) {
      f(elementAt(i), index);
      index--;
    }
  }
}

extension ListWidgetExtension on List<Widget> {
  ///result builder for list
  List<Widget> seperatedWidget(
      Widget Function(BuildContext context, int index) builder) {
    final newList = <Widget>[];
    for (var i = 0; i < length; i++) {
      if (i == 0) {
        newList.add(this[i]);
      } else {
        newList.add(builder(Grock.context, i));
        newList.add(this[i]);
      }
    }
    return newList;
  }
}

extension ListExtension<E> on List<E> {
  List<E> containsWhere(bool Function(E e) f) {
    return where((element) => f(element)).toList();
  }

  List<E> containsWhereIndexed(bool Function(E e, int index) f) {
    var i = 0;
    return where((element) => f(element, i++)).toList();
  }

  List<T> mapIndexed<T>(T Function(E value, int index) f) {
    var i = 0;
    return map((e) => f(e, i++)).toList();
  }

  List<E> seperated(E separator) {
    final newList = <E>[];
    for (var i = 0; i < length; i++) {
      if (i == 0) {
        newList.add(this[i]);
      } else {
        newList.add(separator);
        newList.add(this[i]);
      }
    }
    return newList;
  }

  void whereAdd(bool Function(E e) f, E value) {
    if (f(value)) {
      add(value);
    }
  }

  List<E> seperatedIndexed(E Function(int index) separator) {
    final newList = <E>[];
    for (var i = 0; i < length; i++) {
      if (i == 0) {
        newList.add(this[i]);
      } else {
        newList.add(separator(i));
        newList.add(this[i]);
      }
    }
    return newList;
  }

  List<E> seperatedIndexedValue(E Function(int index, E value) separator) {
    final newList = <E>[];
    for (var i = 0; i < length; i++) {
      if (i == 0) {
        newList.add(this[i]);
      } else {
        newList.add(separator(i, this[i]));
        newList.add(this[i]);
      }
    }
    return newList;
  }

  /// groupBy extension for List
  /// Grock GroupBy
  Map<K, List<E>> groupBy<K>(K Function(E value) f) {
    final map = <K, List<E>>{};
    for (final element in this) {
      final key = f(element);
      map.putIfAbsent(key, () => <E>[]).add(element);
    }
    return map;
  }

  /// groupBy extension for List
  /// Grock GroupBy
  Map<K, List<E>> groupByIndexed<K>(K Function(E value, int index) f) {
    final map = <K, List<E>>{};
    var i = 0;
    for (final element in this) {
      final key = f(element, i++);
      map.putIfAbsent(key, () => <E>[]).add(element);
    }
    return map;
  }

  /// groupBy extension for List
  /// Grock GroupBy
  Map<K, List<E>> groupByIndexedAndWhere<K>(K Function(E value, int index) f) {
    final map = <K, List<E>>{};
    var i = 0;
    for (final element in this) {
      final key = f(element, i++);
      if (key != null) {
        map.putIfAbsent(key, () => <E>[]).add(element);
      }
    }
    return map;
  }

  /// groupBy extension for List
  /// Grock GroupBy
  Map<K, List<E>> groupByIndexedAndWhereNotNull<K>(
      K Function(E value, int index) f) {
    final map = <K, List<E>>{};
    var i = 0;
    for (final element in this) {
      final key = f(element, i++);
      if (key != null) {
        map.putIfAbsent(key, () => <E>[]).add(element);
      }
    }
    return map;
  }

  /// groupBy extension for List
  /// Grock GroupBy
  Map<K, List<E>> groupByIndexedAndWhereNotNullAndNotEmpty<K>(
      K Function(E value, int index) f) {
    final map = <K, List<E>>{};
    var i = 0;
    for (final element in this) {
      final key = f(element, i++);
      if (key != null && key.toString().isNotEmpty) {
        map.putIfAbsent(key, () => <E>[]).add(element);
      }
    }
    return map;
  }

  List<E> mapIndexedWhere<T>(T Function(E value, int index) f) {
    var i = 0;
    return map((e) => f(e, i++)).whereType<E>().toList();
  }

  List<E> mapIndexedWhereNotNull<T>(T Function(E value, int index) f) {
    var i = 0;
    return map((e) => f(e, i++))
        .whereType<E>()
        .where((element) => element != null)
        .toList();
  }

  List<E> mapIndexedWhereNotNullAndNotEmpty<T>(
      T Function(E value, int index) f) {
    var i = 0;
    return map((e) => f(e, i++))
        .whereType<E>()
        .where((element) => element != null && element.toString().isNotEmpty)
        .toList();
  }

  List<E> mapIndexedWhereNotNullAndNotEmptyAndNotZero<T>(
      T Function(E value, int index) f) {
    var i = 0;
    return map((e) => f(e, i++))
        .whereType<E>()
        .where((element) =>
            element != null && element.toString().isNotEmpty && element != 0)
        .toList();
  }

  List<E> mapIndexedWhereNotNullAndNotEmptyAndNotZeroAndNotFalse<T>(
      T Function(E value, int index) f) {
    var i = 0;
    return map((e) => f(e, i++))
        .whereType<E>()
        .where((element) =>
            element != null &&
            element.toString().isNotEmpty &&
            element != 0 &&
            element != false)
        .toList();
  }

  List<E> mapIndexedWhereNotNullAndNotEmptyAndNotZeroAndNotFalseAndNotTrue<T>(
      T Function(E value, int index) f) {
    var i = 0;
    return map((e) => f(e, i++))
        .whereType<E>()
        .where((element) =>
            element != null &&
            element.toString().isNotEmpty &&
            element != 0 &&
            element != false &&
            element != true)
        .toList();
  }

  List<E>
      mapIndexedWhereNotNullAndNotEmptyAndNotZeroAndNotFalseAndNotTrueAndNotNegative<
          T>(T Function(E value, int index) f) {
    var i = 0;
    return map((e) => f(e, i++))
        .whereType<E>()
        .where((element) =>
            element != null &&
            element.toString().isNotEmpty &&
            element != 0 &&
            element != false &&
            element != true &&
            element != -1)
        .toList();
  }

  List<E>
      mapIndexedWhereNotNullAndNotEmptyAndNotZeroAndNotFalseAndNotTrueAndNotNegativeAndNotZeroString<
          T>(T Function(E value, int index) f) {
    var i = 0;
    return map((e) => f(e, i++))
        .whereType<E>()
        .where((element) =>
            element != null &&
            element.toString().isNotEmpty &&
            element != 0 &&
            element != false &&
            element != true &&
            element != -1 &&
            element != "0")
        .toList();
  }

  List<E>
      mapIndexedWhereNotNullAndNotEmptyAndNotZeroAndNotFalseAndNotTrueAndNotNegativeAndNotZeroStringAndNotZeroDouble<
          T>(T Function(E value, int index) f) {
    var i = 0;
    return map((e) => f(e, i++))
        .whereType<E>()
        .where((element) =>
            element != null &&
            element.toString().isNotEmpty &&
            element != 0 &&
            element != false &&
            element != true &&
            element != -1 &&
            element != "0" &&
            element != 0.0)
        .toList();
  }

  List<E>
      mapIndexedWhereNotNullAndNotEmptyAndNotZeroAndNotFalseAndNotTrueAndNotNegativeAndNotZeroStringAndNotZeroDoubleAndNotZeroInt<
          T>(T Function(E value, int index) f) {
    var i = 0;
    return map((e) => f(e, i++))
        .whereType<E>()
        .where((element) =>
            element != null &&
            element.toString().isNotEmpty &&
            element != 0 &&
            element != false &&
            element != true &&
            element != -1 &&
            element != "0" &&
            element != 0.0 &&
            element != 0)
        .toList();
  }

  List<E>
      mapIndexedWhereNotNullAndNotEmptyAndNotZeroAndNotFalseAndNotTrueAndNotNegativeAndNotZeroStringAndNotZeroDoubleAndNotZeroIntAndNotZeroBool<
          T>(T Function(E value, int index) f) {
    var i = 0;
    return map((e) => f(e, i++))
        .whereType<E>()
        .where((element) =>
            element != null &&
            element.toString().isNotEmpty &&
            element != 0 &&
            element != false &&
            element != true &&
            element != -1 &&
            element != "0" &&
            element != 0.0 &&
            element != 0 &&
            element != false)
        .toList();
  }

  List<E>
      mapIndexedWhereNotNullAndNotEmptyAndNotZeroAndNotFalseAndNotTrueAndNotNegativeAndNotZeroStringAndNotZeroDoubleAndNotZeroIntAndNotZeroBoolAndNotZeroList<
          T>(T Function(E value, int index) f) {
    var i = 0;
    return map((e) => f(e, i++))
        .whereType<E>()
        .where((element) =>
            element != null &&
            element.toString().isNotEmpty &&
            element != 0 &&
            element != false &&
            element != true &&
            element != -1 &&
            element != "0" &&
            element != 0.0 &&
            element != 0 &&
            element != false &&
            element != [])
        .toList();
  }

  List<E>
      mapIndexedWhereNotNullAndNotEmptyAndNotZeroAndNotFalseAndNotTrueAndNotNegativeAndNotZeroStringAndNotZeroDoubleAndNotZeroIntAndNotZeroBoolAndNotZeroListAndNotZeroMap<
          T>(T Function(E value, int index) f) {
    var i = 0;
    return map((e) => f(e, i++))
        .whereType<E>()
        .where((element) =>
            element != null &&
            element.toString().isNotEmpty &&
            element != 0 &&
            element != false &&
            element != true &&
            element != -1 &&
            element != "0" &&
            element != 0.0 &&
            element != 0 &&
            element != false &&
            element != [] &&
            element != {})
        .toList();
  }

  List<E>
      mapIndexedWhereNotNullAndNotEmptyAndNotZeroAndNotFalseAndNotTrueAndNotNegativeAndNotZeroStringAndNotZeroDoubleAndNotZeroIntAndNotZeroBoolAndNotZeroListAndNotZeroMapAndNotZeroSet<
          T>(T Function(E value, int index) f) {
    var i = 0;
    return map((e) => f(e, i++))
        .whereType<E>()
        .where((element) =>
            element != null &&
            element.toString().isNotEmpty &&
            element != 0 &&
            element != false &&
            element != true &&
            element != -1 &&
            element != "0" &&
            element != 0.0 &&
            element != 0 &&
            element != false &&
            element != [] &&
            element != {} &&
            element != {})
        .toList();
  }

  List<E>
      mapIndexedWhereNotNullAndNotEmptyAndNotZeroAndNotFalseAndNotTrueAndNotNegativeAndNotZeroStringAndNotZeroDoubleAndNotZeroIntAndNotZeroBoolAndNotZeroListAndNotZeroMapAndNotZeroSetAndNotZeroDateTime<
          T>(T Function(E value, int index) f) {
    var i = 0;
    return map((e) => f(e, i++))
        .whereType<E>()
        .where((element) =>
            element != null &&
            element.toString().isNotEmpty &&
            element != 0 &&
            element != false &&
            element != true &&
            element != -1 &&
            element != "0" &&
            element != 0.0 &&
            element != 0 &&
            element != false &&
            element != [] &&
            element != {} &&
            element != {} &&
            element != DateTime(0))
        .toList();
  }

  List<E> mapFiltered<T>(T Function(E value) f) {
    return map((e) => f(e)).whereType<E>().toList();
  }

  List<E> mapFilteredWhereNotNull<T>(T Function(E value) f) {
    return map((e) => f(e))
        .whereType<E>()
        .where((element) => element != null)
        .toList();
  }

  Widget toBuilder<T>(Widget Function(E value) f) {
    return Column(
      children: map((e) => f(e)).whereType<Widget>().toList(),
    );
  }

  Widget listToBuilder<T>(Widget Function(E value) f) {
    return ListView(
      children: map((e) => f(e)).whereType<Widget>().toList(),
    );
  }

  Widget listToBuilderWithPadding<T>(Widget Function(E value) f,
      {EdgeInsetsGeometry padding = const EdgeInsets.all(8)}) {
    return ListView(
      padding: padding,
      children: map((e) => f(e)).whereType<Widget>().toList(),
    );
  }

  Widget listToBuilderWithPaddingAndScrollDirection<T>(
      Widget Function(E value) f,
      {EdgeInsetsGeometry padding = const EdgeInsets.all(8),
      Axis scrollDirection = Axis.vertical}) {
    return ListView(
      padding: padding,
      scrollDirection: scrollDirection,
      children: map((e) => f(e)).whereType<Widget>().toList(),
    );
  }

  Widget listToBuilderWithPaddingAndScrollDirectionAndShrinkWrap<T>(
      Widget Function(E value) f,
      {EdgeInsetsGeometry padding = const EdgeInsets.all(8),
      Axis scrollDirection = Axis.vertical,
      bool shrinkWrap = true}) {
    return ListView(
      padding: padding,
      scrollDirection: scrollDirection,
      shrinkWrap: shrinkWrap,
      children: map((e) => f(e)).whereType<Widget>().toList(),
    );
  }

  /// reverse list
  List<E> reverseList() {
    return reversed.toList();
  }
}

extension MapExtension<K, V> on Map<K, V> {
  Map<K, V> addIf(bool Function(K key, V value) f, K key, V value) {
    if (f(key, value)) {
      addEntries([MapEntry(key, value)]);
    }
    return this;
  }

  Map<K, V> addIndexIf(
      bool Function(K key, V value, int index) f, K key, V value, int index) {
    if (f(key, value, index)) {
      addEntries([MapEntry(key, value)]);
    }
    return this;
  }

  Map<K, V> addIndexIfNotNull(
      bool Function(K key, V value, int index) f, K key, V value, int index) {
    if (f(key, value, index) && value != null) {
      addEntries([MapEntry(key, value)]);
    }
    return this;
  }

  /// get where
  Map<K, V> getWhere(bool Function(K key, V value) f) {
    final map = <K, V>{};
    for (final element in entries) {
      final key = element.key;
      final value = element.value;
      if (f(key, value)) {
        map.putIfAbsent(key, () => value);
      }
    }
    return map;
  }
}
