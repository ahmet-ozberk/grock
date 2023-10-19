import 'package:flutter/material.dart';

extension PaddingExtension on num {
  EdgeInsetsGeometry get allP => EdgeInsets.all(this.toDouble());
  EdgeInsetsGeometry get onlyLeftP => EdgeInsets.only(left: this.toDouble());
  EdgeInsetsGeometry get onlyRightP => EdgeInsets.only(right: this.toDouble());
  EdgeInsetsGeometry get onlyTopP => EdgeInsets.only(top: this.toDouble());
  EdgeInsetsGeometry get onlyBottomP =>
      EdgeInsets.only(bottom: this.toDouble());
  EdgeInsetsGeometry get horizontalP =>
      EdgeInsets.symmetric(horizontal: this.toDouble());
  EdgeInsetsGeometry get verticalP =>
      EdgeInsets.symmetric(vertical: this.toDouble());
}

extension PaddingExtensio on List {
  EdgeInsetsGeometry get horizontalAndVerticalP => EdgeInsets.symmetric(
      horizontal: this[0].toDouble(), vertical: this[1].toDouble());
  EdgeInsetsGeometry get paddingLTRB => EdgeInsets.fromLTRB(this[0].toDouble(),
      this[1].toDouble(), this[2].toDouble(), this[3].toDouble());
}
