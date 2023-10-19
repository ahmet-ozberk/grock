
import 'dart:async';

/// provides scope functions as extensions on [T]
extension GenericScrewdriver<T extends Object> on T {
  /// Calls the specified function [block] with `this` value as its argument
  /// and returns `this` value.
  T apply(void Function(T obj) block) {
    block(this);
    return this;
  }

  /// Calls the specified function [block] with `this` value as its argument
  /// and returns `this` value.
  R run<R>(R Function(T obj) block) {
    return block(this);
  }

  /// Returns [this] if it satisfies the given [predicate] or null,
  /// if it doesn't.
  T? takeIf(bool Function(T obj) predicate) {
    if (predicate(this)) {
      return this;
    }
    return null;
  }

  /// Returns [this] if it doesn't satisfy the given [predicate] or null,
  /// if it doesn't.
  T? takeUnless(bool Function(T obj) predicate) {
    if (!predicate(this)) {
      return this;
    }
    return null;
  }

  /// A safe cast operation that returns null if the cast is not possible.
  /// Otherwise, returns the casted value.
  R? tryCast<R>() {
    try {
      return this as R?;
    } catch (e) {
      return null;
    }
  }
}

/// Always throws [UnimplementedError] stating that operation is
/// not implemented.
// ignore: non_constant_identifier_names
void TODO([String? reason]) =>
    throw UnimplementedError(reason ?? 'An operation is not implemented.');

/// Executes a provided action and handles potential errors.
///
/// The function returns T? which represents the result of the executed action
/// if the action is not asynchronous. If the action completes successfully,
/// the result is returned as is. If an exception occurs during the execution,
/// the [onError] function is called with the error and stack trace. If the
/// [onError] function is not provided or returns null, the error is swallowed
/// and the result is set to null.
///
/// The function returns a [Future] of type T? which represents the result of
/// the executed action if the action is asynchronous. If the action completes
/// successfully, the result is returned as is. If an exception occurs during
/// the execution, the [onError] function is called with the error and stack
/// trace. If the [onError] function is not provided or returns null, the error
/// is swallowed and the result is set to null.
///
/// If the [onError] function is synchronous, the result is returned as is. If
/// it throws an error, the error is swallowed and the result is set to null.
///
/// If the [onError] function is asynchronous, a [Future] of type T? is
/// returned. If the [onError] function completes successfully, the result is
/// returned as is. If it throws an error, the error is swallowed and the
/// result is set to null.
FutureOr<T?> runCaching<T>(
  FutureOr<T?> Function() action, {
  FutureOr<T?> Function(dynamic error, StackTrace stacktrace)? onError,
}) {
  FutureOr<T?> result;
  try {
    result = action.call();
  } catch (error, stacktrace) {
    try {
      // call onError if exception occurs.
      result = onError?.call(error, stacktrace);
    } catch (error) {
      // Swallow error if onError throws an error.
      result = null;
    }
  }

  if (result is Future) {
    return (result as Future<T?>)
        // return the value if future completes successfully.
        .then((value) => value)
        // call onError if future completes with error.
        .catchError(
            (error, StackTrace stacktrace) => onError?.call(error, stacktrace))
        // swallow error and return null if onError throws an error.
        .catchError((error) => null);
  }

  return result;
}