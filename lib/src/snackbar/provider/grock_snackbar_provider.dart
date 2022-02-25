import 'dart:async';

import 'package:flutter/material.dart';

class GrockSnackbarProvider extends ChangeNotifier {
  double lineerProgress = 1.0;

  void setLineerProgress() {
    lineerProgress -= 0.00125;
    notifyListeners();
  }

  void initTimer(Timer time,AnimationController controller) {
    time = Timer.periodic(const Duration(milliseconds: 5), (timer) {
      setLineerProgress();
      if (lineerProgress <= 0) {
        timer.cancel();
        time.cancel();
        controller.reverse();
      }
    });
  }

  startAnimate(AnimationController controller) {
    controller.forward();
  }
}
