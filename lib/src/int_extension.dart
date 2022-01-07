import 'dart:async';
import 'dart:math';

extension IntExtension on int {
  int get randomNum => Random().nextInt(this);
}

extension RandomImageExtension on int {
  String randomImage({int width = 200, int height = 200}) =>
      "https://picsum.photos/$width/$height?random=$this";
}
