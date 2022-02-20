import 'dart:async';

import 'package:flutter/material.dart';

class GrockSnackbarProvider extends ChangeNotifier {
  double lineerProgress = 1.0;

  void setLineerProgress() {
    lineerProgress -= 0.01;
    notifyListeners();
  }

  void initTimer() {
    Timer.periodic(const Duration(milliseconds: 40), (timer) {
      setLineerProgress();
      if (lineerProgress <= 0) {
        timer.cancel();
      }
    });
  }

  startAnimate(AnimationController controller) {
    controller.forward();
  }
}
