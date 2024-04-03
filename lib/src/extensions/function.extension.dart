import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

extension FunctionExtension on Function() {
  get widgetBinding =>
      WidgetsBinding.instance.addPostFrameCallback((_) => this());
  get schedularBinding =>
      SchedulerBinding.instance.addPostFrameCallback((_) => this());
  void widgetBindingWithDelay(Duration duration) => WidgetsBinding.instance
      .addPostFrameCallback((_) => Future.delayed(duration, this));

  get endOfFrame => WidgetsBinding.instance.endOfFrame.then((_) => this());

  void catchAll(Function(Object error) onError) {
    try {
      this();
    } catch (e) {
      onError(e);
    }
  }
}
