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