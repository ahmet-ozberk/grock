import 'package:flutter_test/flutter_test.dart';

import 'package:grock/grock.dart';

void main() {
  var x = 15.randomNum;
  expect(
    x,
    x < 16,
  );
}
