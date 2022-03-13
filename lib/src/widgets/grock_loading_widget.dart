import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

import 'grock_glassmorphism.dart';

class GrockLoadingWidget<T> extends StatefulWidget {
  bool? isLoading;
  Widget loadedChild;
  Widget? loadingChild;
  Widget? errorChild;
  bool? showDialog;
  Widget? loadingDialogWidget;
  GrockLoadingWidget({
    required this.isLoading,
    required this.loadedChild,
    this.loadingChild,
    this.errorChild,
    this.showDialog,
    this.loadingDialogWidget,
  });

  @override
  State<GrockLoadingWidget> createState() => _GrockLoadingWidgetState();
}

class _GrockLoadingWidgetState extends State<GrockLoadingWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.isLoading == true) {
      if (widget.showDialog == true) {
        Grock.back();
      }
      return widget.loadedChild;
    } else if (widget.isLoading == false) {
      if (widget.showDialog == true) {
        Grock.back();
      }
      return widget.errorChild ??
          const Center(
            child: Text('Error'),
          );
    } else if (widget.isLoading == null) {
      if (widget.showDialog == true) {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          _LoadingPopup();
        });
        return Center(child: Container());
      } else {
        return widget.loadingChild ??
            const Center(
              child: CircularProgressIndicator.adaptive(),
            );
      }
    } else {
      return Container();
    }
  }

  void _LoadingPopup() {
    showDialog(
      context: Grock.navigationKey.currentContext,
      barrierDismissible: false,
      builder: (_) =>
          widget.loadingDialogWidget ??
          Material(
            type: MaterialType.transparency,
            child: Center(
              child: GrockGlassMorphism(
                blur: 20,
                opacity: 0.1,
                borderRadius: 10,
                color: Colors.white,
                child: Container(
                  padding: [40, 40].horizontalAndVerticalP,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const CircularProgressIndicator.adaptive(),
                ),
              ),
            ),
          ),
    );
  }
}