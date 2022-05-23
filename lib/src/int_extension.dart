import 'dart:math';

import 'package:flutter/material.dart';
import 'package:grock/src/components/lorem_ipsum.dart';

extension IntExtension on int {
  int get randomNum => Random().nextInt(this);
}

extension RandomImageExtension on int {
  String randomImage({int width = 200, int height = 200}) =>
      "https://picsum.photos/$width/$height?random=$this";
  String rndImg({int? w, int? h, String? keywords}) =>
      "https://source.unsplash.com/random/${w ?? 500}×${h ?? 500}/?${keywords ?? ""}?fruit";
  String lorem({int paragraphs = 3})=> loremIpsum(paragraphs: paragraphs, words: this);
}

extension SizeBoxExtension on int{
  Widget get height => SizedBox(height: this.toDouble());
  Widget get width => SizedBox(width: this.toDouble());
  Widget get heightWidth => SizedBox(height: this.toDouble(), width: this.toDouble());
}
