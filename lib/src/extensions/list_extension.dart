import 'package:flutter/material.dart';

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
    var i = 0;
    forEach((e) => f(e, i++));
  }
}

extension ListExtension<E> on List<E>{
  List<T> mapIndexed<T>(T Function(E value, int index) f) {
    var i = 0;
    return map((e) => f(e, i++)).toList();
  }

  List<E> mapIndexedWhere<T>(T Function(E value, int index) f) {
    var i = 0;
    return map((e) => f(e, i++)).whereType<E>().toList();
  }

  List<E> mapIndexedWhereNotNull<T>(T Function(E value, int index) f) {
    var i = 0;
    return map((e) => f(e, i++)).whereType<E>().where((element) => element != null).toList();
  }

  List<E> mapIndexedWhereNotNullAndNotEmpty<T>(T Function(E value, int index) f) {
    var i = 0;
    return map((e) => f(e, i++)).whereType<E>().where((element) => element != null && element.toString().isNotEmpty).toList();
  }

  List<E> mapIndexedWhereNotNullAndNotEmptyAndNotZero<T>(T Function(E value, int index) f) {
    var i = 0;
    return map((e) => f(e, i++)).whereType<E>().where((element) => element != null && element.toString().isNotEmpty && element != 0).toList();
  }

  List<E> mapIndexedWhereNotNullAndNotEmptyAndNotZeroAndNotFalse<T>(T Function(E value, int index) f) {
    var i = 0;
    return map((e) => f(e, i++)).whereType<E>().where((element) => element != null && element.toString().isNotEmpty && element != 0 && element != false).toList();
  }

  List<E> mapIndexedWhereNotNullAndNotEmptyAndNotZeroAndNotFalseAndNotTrue<T>(T Function(E value, int index) f) {
    var i = 0;
    return map((e) => f(e, i++)).whereType<E>().where((element) => element != null && element.toString().isNotEmpty && element != 0 && element != false && element != true).toList();
  }

  List<E> mapIndexedWhereNotNullAndNotEmptyAndNotZeroAndNotFalseAndNotTrueAndNotNegative<T>(T Function(E value, int index) f) {
    var i = 0;
    return map((e) => f(e, i++)).whereType<E>().where((element) => element != null && element.toString().isNotEmpty && element != 0 && element != false && element != true && element != -1).toList();
  }

  List<E> mapIndexedWhereNotNullAndNotEmptyAndNotZeroAndNotFalseAndNotTrueAndNotNegativeAndNotZeroString<T>(T Function(E value, int index) f) {
    var i = 0;
    return map((e) => f(e, i++)).whereType<E>().where((element) => element != null && element.toString().isNotEmpty && element != 0 && element != false && element != true && element != -1 && element != "0").toList();
  }

  List<E> mapIndexedWhereNotNullAndNotEmptyAndNotZeroAndNotFalseAndNotTrueAndNotNegativeAndNotZeroStringAndNotZeroDouble<T>(T Function(E value, int index) f) {
    var i = 0;
    return map((e) => f(e, i++)).whereType<E>().where((element) => element != null && element.toString().isNotEmpty && element != 0 && element != false && element != true && element != -1 && element != "0" && element != 0.0).toList();
  }

  List<E> mapIndexedWhereNotNullAndNotEmptyAndNotZeroAndNotFalseAndNotTrueAndNotNegativeAndNotZeroStringAndNotZeroDoubleAndNotZeroInt<T>(T Function(E value, int index) f) {
    var i = 0;
    return map((e) => f(e, i++)).whereType<E>().where((element) => element != null && element.toString().isNotEmpty && element != 0 && element != false && element != true && element != -1 && element != "0" && element != 0.0 && element != 0).toList();
  }

  List<E> mapIndexedWhereNotNullAndNotEmptyAndNotZeroAndNotFalseAndNotTrueAndNotNegativeAndNotZeroStringAndNotZeroDoubleAndNotZeroIntAndNotZeroBool<T>(T Function(E value, int index) f) {
    var i = 0;
    return map((e) => f(e, i++)).whereType<E>().where((element) => element != null && element.toString().isNotEmpty && element != 0 && element != false && element != true && element != -1 && element != "0" && element != 0.0 && element != 0 && element != false).toList();
  }

  List<E> mapIndexedWhereNotNullAndNotEmptyAndNotZeroAndNotFalseAndNotTrueAndNotNegativeAndNotZeroStringAndNotZeroDoubleAndNotZeroIntAndNotZeroBoolAndNotZeroList<T>(T Function(E value, int index) f) {
    var i = 0;
    return map((e) => f(e, i++)).whereType<E>().where((element) => element != null && element.toString().isNotEmpty && element != 0 && element != false && element != true && element != -1 && element != "0" && element != 0.0 && element != 0 && element != false && element != []).toList();
  }

  List<E> mapIndexedWhereNotNullAndNotEmptyAndNotZeroAndNotFalseAndNotTrueAndNotNegativeAndNotZeroStringAndNotZeroDoubleAndNotZeroIntAndNotZeroBoolAndNotZeroListAndNotZeroMap<T>(T Function(E value, int index) f) {
    var i = 0;
    return map((e) => f(e, i++)).whereType<E>().where((element) => element != null && element.toString().isNotEmpty && element != 0 && element != false && element != true && element != -1 && element != "0" && element != 0.0 && element != 0 && element != false && element != [] && element != {}).toList();
  }

  List<E> mapIndexedWhereNotNullAndNotEmptyAndNotZeroAndNotFalseAndNotTrueAndNotNegativeAndNotZeroStringAndNotZeroDoubleAndNotZeroIntAndNotZeroBoolAndNotZeroListAndNotZeroMapAndNotZeroSet<T>(T Function(E value, int index) f) {
    var i = 0;
    return map((e) => f(e, i++)).whereType<E>().where((element) => element != null && element.toString().isNotEmpty && element != 0 && element != false && element != true && element != -1 && element != "0" && element != 0.0 && element != 0 && element != false && element != [] && element != {} && element != {}).toList();
  }

  List<E> mapIndexedWhereNotNullAndNotEmptyAndNotZeroAndNotFalseAndNotTrueAndNotNegativeAndNotZeroStringAndNotZeroDoubleAndNotZeroIntAndNotZeroBoolAndNotZeroListAndNotZeroMapAndNotZeroSetAndNotZeroDateTime<T>(T Function(E value, int index) f) {
    var i = 0;
    return map((e) => f(e, i++)).whereType<E>().where((element) => element != null && element.toString().isNotEmpty && element != 0 && element != false && element != true && element != -1 && element != "0" && element != 0.0 && element != 0 && element != false && element != [] && element != {} && element != {} && element != DateTime(0)).toList();
  }

  List<E> mapFiltered<T>(T Function(E value) f) {
    return map((e) => f(e)).whereType<E>().toList();
  }

  List<E> mapFilteredWhereNotNull<T>(T Function(E value) f) {
    return map((e) => f(e)).whereType<E>().where((element) => element != null).toList();
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

  Widget listToBuilderWithPadding<T>(Widget Function(E value) f, {EdgeInsetsGeometry padding = const EdgeInsets.all(8)}) {
    return ListView(
      padding: padding,
      children: map((e) => f(e)).whereType<Widget>().toList(),
    );
  }

  Widget listToBuilderWithPaddingAndScrollDirection<T>(Widget Function(E value) f, {EdgeInsetsGeometry padding = const EdgeInsets.all(8), Axis scrollDirection = Axis.vertical}) {
    return ListView(
      padding: padding,
      scrollDirection: scrollDirection,
      children: map((e) => f(e)).whereType<Widget>().toList(),
    );
  }

  Widget listToBuilderWithPaddingAndScrollDirectionAndShrinkWrap<T>(Widget Function(E value) f, {EdgeInsetsGeometry padding = const EdgeInsets.all(8), Axis scrollDirection = Axis.vertical, bool shrinkWrap = true}) {
    return ListView(
      padding: padding,
      scrollDirection: scrollDirection,
      shrinkWrap: shrinkWrap,
      children: map((e) => f(e)).whereType<Widget>().toList(),
    );
  }
}