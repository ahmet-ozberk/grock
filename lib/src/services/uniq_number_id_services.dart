import 'dart:math';

enum GrockUniqIdType {
  numbers,
  string,
  stringAndNumbers,
  stringAndNumbersWithSpecialCharacters
}

class GrockUniqIdServices {
  static String generate(
      {int length = 11,
      GrockUniqIdType type = GrockUniqIdType.numbers}) {
    int unixTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final valueLength = unixTimestamp.toString().length;
    if (type == GrockUniqIdType.numbers) {
      if (length == valueLength) {
        return unixTimestamp.toString();
      } else if (length < valueLength) {
        return unixTimestamp.toString().padLeft(length, randomNumber(1));
      } else {
        return unixTimestamp.toString().substring(0, length);
      }
    } else {
      return switch (type) {
        GrockUniqIdType.string => randomString(length),
        GrockUniqIdType.stringAndNumbers =>
          randomStringAndNumbers(length),
        GrockUniqIdType.stringAndNumbersWithSpecialCharacters =>
          randomStringAndNumbersWithSpecialCharacters(length),
        _ => randomString(length)
      };
    }
  }

  /// Random Numbers
  static String randomNumber(int count) {
    final random = Random();
    const charactersModel = '1234567890';
    return String.fromCharCodes(Iterable.generate(
        count,
        (_) => charactersModel
            .codeUnitAt(random.nextInt(charactersModel.length))));
  }

  /// Random String
  static String randomString(int count) {
    final random = Random();
    const charactersModel =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    return String.fromCharCodes(Iterable.generate(
        count,
        (_) => charactersModel
            .codeUnitAt(random.nextInt(charactersModel.length))));
  }

  /// Random String and Numbers
  static String randomStringAndNumbers(int count) {
    final random = Random();
    const charactersModel =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
    return String.fromCharCodes(Iterable.generate(
        count,
        (_) => charactersModel
            .codeUnitAt(random.nextInt(charactersModel.length))));
  }

  /// Random String and Numbers
  static String randomStringAndNumbersWithSpecialCharacters(int count) {
    final random = Random();
    const charactersModel =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#\$%^&*()_+-=<>?/.,';
    return String.fromCharCodes(Iterable.generate(
        count,
        (_) => charactersModel
            .codeUnitAt(random.nextInt(charactersModel.length))));
  }
}
