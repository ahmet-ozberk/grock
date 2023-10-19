import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

/// Time format [04:28:53]
String grockHMSTimeFormat(Duration time) {
  late String result;
  if (time.inHours > 0) {
    result =
        "${time.inHours.toString().padLeft(2, '0')}:${time.inMinutes.remainder(60).toString().padLeft(2, '0')}:${time.inSeconds.remainder(60).toString().padLeft(2, '0')}";
  } else {
    result =
        "${time.inMinutes.remainder(60).toString().padLeft(2, '0')}:${time.inSeconds.remainder(60).toString().padLeft(2, '0')}";
  }
  return result;
}

/// Time format [04:28]
String grockHMTimeFormat(Duration time) {
  late String result;
  if (time.inHours > 0) {
    result =
        "${time.inHours.toString().padLeft(2, '0')}:${time.inMinutes.remainder(60).toString().padLeft(2, '0')}";
  } else {
    result =
        "${time.inMinutes.remainder(60).toString().padLeft(2, '0')}:${time.inSeconds.remainder(60).toString().padLeft(2, '0')}";
  }
  return result;
}

void grockTimer({
  required Duration duration,
  required Function(Duration time) onTick,
  Function()? onDone,
}) {
  Timer.periodic(
    Duration(seconds: 1),
    (timer) {
      if (duration.inSeconds == 0) {
        timer.cancel();
        onDone?.call();
      } else {
        duration = duration - Duration(seconds: 1);
        onTick.call(duration);
      }
    },
  );
}

File grockFileFromPath(String path) {
  return File(path);
}

String grockFileNameFromPath(String path) {
  return grockFileFromPath(path).path.split('/').last;
}

String grockRandomFileName() {
  return DateTime.now().millisecondsSinceEpoch.toString();
}

/// clipboard text
Future<String?> grockClipboardText() async {
  return await Clipboard.getData('text/plain').then((value) => value?.text);
}

/// clipboard image
Future<String?> grockClipboardImage() async {
  return await Clipboard.getData('image/png').then((value) => value?.text);
}

/// clipboard file
Future<String?> grockClipboardFile() async {
  return await Clipboard.getData('text/uri-list').then((value) => value?.text);
}

/// clipboard clear
Future<void> grockClipboardClear() async {
  return await Clipboard.setData(ClipboardData(text: ''));
}

/// clipboard set text
Future<bool> grockCopyText(String text) async {
  return await Clipboard.setData(ClipboardData(text: text)).then((value) => true).catchError((e) => false);
}

/// clipboard set image
Future<bool> grockCopyImage(String path) async {
  return await Clipboard.setData(ClipboardData(text: path)).then((value) => true).catchError((e) => false);
}