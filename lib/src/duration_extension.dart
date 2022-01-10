import 'dart:async';

extension DurationExtension on int {
  Future delay([FutureOr callback()?]) async => Future.delayed(
        Duration(milliseconds: (this).round()),
        callback,
      );
  Duration get milliseconds => Duration(microseconds: (this * 1000).round());

  Duration get seconds => Duration(milliseconds: (this * 1000).round());

  Duration get minutes =>
      Duration(seconds: (this * Duration.secondsPerMinute).round());

  Duration get hours =>
      Duration(minutes: (this * Duration.minutesPerHour).round());

  Duration get days => Duration(hours: (this * Duration.hoursPerDay).round());
}
