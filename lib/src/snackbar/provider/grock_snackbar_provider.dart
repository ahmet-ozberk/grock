import 'dart:async';

import 'package:flutter/material.dart';

class GrockSnackbarProvider extends ChangeNotifier {
  double lineerProgress = 1.0;

  void setLineerProgress() {
    lineerProgress -= 0.000625;
    notifyListeners();
  }

  startAnimate(AnimationController controller) {
    controller.forward();
  }
}