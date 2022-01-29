import 'dart:async';

extension DurationExtension on int {
  Future delay([FutureOr callback()?]) async => Future.delayed(
        Duration(milliseconds: (this).round()),
        callback,
      );
  Future<Duration> milliseconds() async =>
      await Duration(microseconds: (this * 1000).round());

  Future<Duration> seconds() async =>
      await Duration(milliseconds: (this * 1000).round());

  Future<Duration> minutes() async =>
      await Duration(seconds: (this * Duration.secondsPerMinute).round());

  Future<Duration> hours() async =>
      await Duration(minutes: (this * Duration.minutesPerHour).round());

  Future<Duration> days() async =>
      await Duration(hours: (this * Duration.hoursPerDay).round());
}
