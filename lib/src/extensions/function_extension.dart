import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

extension FunctionExtension on Function() {
  void widgetBinding() => WidgetsBinding.instance.addPostFrameCallback((_) => this());
  void schedularBinding() => SchedulerBinding.instance.addPostFrameCallback((_) => this());
  void widgetBindingWithDelay(Duration duration) =>
      WidgetsBinding.instance.addPostFrameCallback((_) => Future.delayed(duration, this));
}