// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';

class GrockTimer extends StatefulWidget {
  final Duration? startTime;
  final bool isInitialStart;
  final Widget Function(Duration time)? builder;
  Duration? endTime;
  Duration? interval;
  Function()? onTimerEnd;
  Function()? onTimerStart;
  Function(Duration time, GrockTimerState state)? onTimerTick;
  GrockTimerController? controller;
  bool isSecondsWidget;
  bool isMinuteWidget;
  bool isHourWidget;
  bool isDayWidget;
  TextStyle? textStyle;

  GrockTimer(
      {super.key,

      /// The time to start the timer from.
      this.startTime = const Duration(seconds: 10),

      /// The time to end the timer at.
      this.endTime = const Duration(seconds: 0),

      /// The interval at which the timer ticks.
      this.interval = const Duration(seconds: 1),

      /// The controller for the timer.
      this.controller,

      /// The builder for the timer.
      this.builder,

      /// The callback for when the timer ends.
      this.onTimerEnd,

      /// The callback for when the timer starts.
      this.onTimerStart,

      /// The callback for when the timer ticks.
      this.onTimerTick,

      /// The initial state of the timer.
      this.isInitialStart = false,

      /// The widget to display the seconds.
      this.isSecondsWidget = true,

      /// The widget to display the minutes.
      this.isMinuteWidget = true,

      /// The widget to display the hours.
      this.isHourWidget = true,

      /// The widget to display the days.
      this.isDayWidget = false,

      /// The text style for the timer.
      this.textStyle});

  @override
  _GrockTimerState createState() => _GrockTimerState();
}

class _GrockTimerState extends State<GrockTimer> {
  late Duration _time;
  late Timer _timer;

  void _startTimer() {
    widget.onTimerStart?.call();
    _timer = Timer.periodic(widget.interval!, (timer) {
      if (_time.inSeconds == widget.endTime!.inSeconds) {
        if (widget.onTimerTick != null) {
          widget.onTimerTick!(_time, GrockTimerState.completed);
        }
        _timer.cancel();
        widget.onTimerEnd?.call();
      } else {
        setState(() {
          widget.startTime!.inSeconds > widget.endTime!.inSeconds
              ? _time = _time - widget.interval!
              : _time = _time + widget.interval!;
        });
        if (widget.onTimerTick != null) {
          widget.onTimerTick!(_time, GrockTimerState.running);
        }
      }
    });
  }

  void reset() {
    setState(() {
      if (widget.onTimerTick != null) {
        widget.onTimerTick!.call(_time, GrockTimerState.reset);
      }
      _timer.cancel();
      _time = widget.startTime!;
      if (widget.builder != null) {
        widget.builder!(_time);
      }
    });
  }

  void stop() {
    setState(() {
      _timer.cancel();
      if (widget.onTimerTick != null) {
        widget.onTimerTick!(_time, GrockTimerState.stopped);
      }
    });
  }

  void start() {
    setState(() {
      _startTimer();
      if (widget.onTimerStart != null) {
        widget.onTimerTick!(_time, GrockTimerState.running);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    widget.controller?._init(this);
    _time = widget.startTime!;
    if (widget.isInitialStart) {
      _startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder != null
        ? widget.builder!(_time)
        : _GrockTimerBodyWidget(
            time: _time,
            textStyle: widget.textStyle,
            isSecondsWidget: widget.isSecondsWidget,
            isMinuteWidget: widget.isMinuteWidget,
            isHourWidget: widget.isHourWidget,
            isDayWidget: widget.isDayWidget);
  }
}

class _GrockTimerBodyWidget extends StatelessWidget {
  final Duration time;
  final TextStyle? textStyle;
  final bool isSecondsWidget;
  final bool isMinuteWidget;
  final bool isHourWidget;
  final bool isDayWidget;
  const _GrockTimerBodyWidget(
      {required this.time,
      required this.isSecondsWidget,
      required this.isMinuteWidget,
      required this.isHourWidget,
      required this.isDayWidget,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: textStyle ?? Theme.of(context).textTheme.headlineSmall!,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _container(
            Text(
              time.inDays.toString().padLeft(2, '0'),
              key: ValueKey(time.inDays),
            ),
          ).visible(isDayWidget),
          const Text(':').visible(isDayWidget),
          _container(
            Text(
              time.inHours.toString().padLeft(2, '0'),
              key: ValueKey(time.inHours),
            ),
          ).visible(isHourWidget),
          const Text(':').visible(isHourWidget),
          _container(
            Text(
              (time.inMinutes % 60).toString().padLeft(2, '0'),
              key: ValueKey(time.inMinutes),
            ),
          ).visible(isMinuteWidget),
          const Text(':').visible(isMinuteWidget),
          _container(
            Text(
              (time.inSeconds % 60).toString().padLeft(2, '0'),
              key: ValueKey(time.inSeconds),
            ),
          ).visible(isSecondsWidget),
        ],
      ),
    );
  }

  Container _container(Widget child) {
    return Container(
      constraints: const BoxConstraints(
        minWidth: 42,
        minHeight: 32,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(5),
      ),
      alignment: Alignment.center,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: _transitionBuilder,
        child: child,
      ),
    );
  }

  Widget _transitionBuilder(Widget child, Animation<double> animation) {
    return ScaleTransition(scale: animation, child: child);
  }
}

enum GrockTimerState { stopped, running, completed, reset }

extension _GrockTimerVisibleExtension on Widget {
  Widget visible(bool t) => Visibility(visible: t, child: this);
}

class GrockTimerController {
  late _GrockTimerState _state = _GrockTimerState();
  bool isInitialized = false;

  void _init(_GrockTimerState state) {
    _state = state;
  }

  /// Start the timer
  void start() {
    _state.start();
  }

  /// Stop the timer
  void stop() {
    _state.stop();
  }

  /// Reset the timer
  void reset() {
    _state.reset();
  }

  /// Set the start time
  void setStartTime(Duration time) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _state._time = time);
  }

  /// Set the end time
  void setEndTime(Duration time) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _state.widget.endTime = time);
  }

  /// Set the interval time
  void setInterval(Duration time) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _state.widget.interval = time);
  }

  /// Get the current state of the timer
  GrockTimerState get state {
    if (_state._timer.isActive) {
      return GrockTimerState.running;
    } else if (_state._time.inSeconds == _state.widget.endTime!.inSeconds) {
      return GrockTimerState.completed;
    } else {
      return GrockTimerState.stopped;
    }
  }

  /// Add a listener to the timer
  void addListener(
      void Function(Duration time, GrockTimerState state) listener) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _state.widget.onTimerTick = listener;
    });
  }

  /// Remove a listener from the timer
  Duration get time => _state._time;

  bool get isRunning => _state._timer.isActive;

  bool get isStopped => !_state._timer.isActive;

  bool get isReset => _state._time == _state.widget.startTime;

  bool get isFinished => _state._time == _state.widget.endTime;

  bool get isNotFinished => _state._time != _state.widget.endTime;

  bool get isNotReset => _state._time != _state.widget.startTime;

  bool get isNotStopped => _state._timer.isActive;

  bool get isNotRunning => !_state._timer.isActive;

  bool get isFinishedOrStopped => isFinished || isStopped;

  bool get isNotFinishedAndNotStopped => isNotFinished && isNotStopped;

  bool get isNotResetAndNotStopped => isNotReset && isNotStopped;

  bool get isResetOrStopped => isReset || isStopped;

  bool get isNotResetAndNotRunning => isNotReset && isNotRunning;

  bool get isNotFinishedAndNotRunning => isNotFinished && isNotRunning;
}
