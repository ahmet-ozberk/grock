// ignore_for_file: unused_field

import 'dart:math';

import 'package:flutter/services.dart';

enum GrockMaskAutoCompletionType {
  lazy,
  eager,
}

/// Usage:
/// ```dart
/// final maskFormatter = GrockInputFormatter(
///   mask: '+# (###) ###-##-##',
///   filter: { "#": RegExp(r'[0-9]') },
///   type: GrockMaskAutoCompletionType.lazy
/// );
/// ```

class GrockInputFormatter implements TextInputFormatter {
  final GrockMaskAutoCompletionType type;

  String? _mask;
  List<String> _maskChars = [];
  Map<String, RegExp>? _maskFilter;

  int _maskLength = 0;
  final _TextMatcher _resultTextArray = _TextMatcher();
  String _resultTextMasked = "";
  GrockInputFormatter({
    String? mask,
    Map<String, RegExp>? filter,
    String? initialText,
    this.type = GrockMaskAutoCompletionType.lazy,
  }) {
    updateMask(
        mask: mask,
        filter: filter ?? {"#": RegExp('[0-9]'), "A": RegExp('[^0-9]')});
    if (initialText != null) {
      formatEditUpdate(
          TextEditingValue.empty, TextEditingValue(text: initialText));
    }
  }

  TextEditingValue updateMask({String? mask, Map<String, RegExp>? filter}) {
    _mask = mask;
    if (filter != null) {
      _updateFilter(filter);
    }
    _calcMaskLength();
    final unmaskedText = getUnmaskedText();
    clear();
    return formatEditUpdate(
        TextEditingValue.empty,
        TextEditingValue(
            text: unmaskedText,
            selection: TextSelection.collapsed(offset: unmaskedText.length)));
  }

  String? getMask() {
    return _mask;
  }

  String getMaskedText() {
    return _resultTextMasked;
  }

  String getUnmaskedText() {
    return _resultTextArray.toString();
  }

  bool isFill() {
    return _resultTextArray.length == _maskLength;
  }

  void clear() {
    _resultTextMasked = "";
    _resultTextArray.clear();
  }

  String maskText(String text) {
    return GrockInputFormatter(
            mask: _mask, filter: _maskFilter, initialText: text)
        .getMaskedText();
  }

  String unmaskText(String text) {
    return GrockInputFormatter(
            mask: _mask, filter: _maskFilter, initialText: text)
        .getUnmaskedText();
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final mask = _mask;

    if (mask == null || mask.isEmpty == true) {
      _resultTextMasked = newValue.text;
      _resultTextArray.set(newValue.text);
      return newValue;
    }

    if (oldValue.text.isEmpty) {
      _resultTextArray.clear();
    }

    final beforeText = oldValue.text;
    final afterText = newValue.text;

    final beforeSelection = oldValue.selection;
    final afterSelection = newValue.selection;

    var beforeSelectionStart = afterSelection.isValid
        ? beforeSelection.isValid
            ? beforeSelection.start
            : 0
        : 0;

    for (var i = 0;
        i < beforeSelectionStart &&
            i < beforeText.length &&
            i < afterText.length;
        i++) {
      if (beforeText[i] != afterText[i]) {
        beforeSelectionStart = i;
        break;
      }
    }

    final beforeSelectionLength = afterSelection.isValid
        ? beforeSelection.isValid
            ? beforeSelection.end - beforeSelectionStart
            : 0
        : oldValue.text.length;

    final lengthDifference =
        afterText.length - (beforeText.length - beforeSelectionLength);
    final lengthRemoved = lengthDifference < 0 ? lengthDifference.abs() : 0;
    final lengthAdded = lengthDifference > 0 ? lengthDifference : 0;

    final afterChangeStart = max(0, beforeSelectionStart - lengthRemoved);
    final afterChangeEnd = max(0, afterChangeStart + lengthAdded);

    final beforeReplaceStart = max(0, beforeSelectionStart - lengthRemoved);
    final beforeReplaceLength = beforeSelectionLength + lengthRemoved;

    final beforeResultTextLength = _resultTextArray.length;

    var currentResultTextLength = _resultTextArray.length;
    var currentResultSelectionStart = 0;
    var currentResultSelectionLength = 0;

    for (var i = 0;
        i < min(beforeReplaceStart + beforeReplaceLength, mask.length);
        i++) {
      if (_maskChars.contains(mask[i]) && currentResultTextLength > 0) {
        currentResultTextLength -= 1;
        if (i < beforeReplaceStart) {
          currentResultSelectionStart += 1;
        }
        if (i >= beforeReplaceStart) {
          currentResultSelectionLength += 1;
        }
      }
    }

    final replacementText =
        afterText.substring(afterChangeStart, afterChangeEnd);
    var targetCursorPosition = currentResultSelectionStart;
    if (replacementText.isEmpty) {
      _resultTextArray.removeRange(currentResultSelectionStart,
          currentResultSelectionStart + currentResultSelectionLength);
    } else {
      if (currentResultSelectionLength > 0) {
        _resultTextArray.removeRange(currentResultSelectionStart,
            currentResultSelectionStart + currentResultSelectionLength);
        currentResultSelectionLength = 0;
      }
      _resultTextArray.insert(currentResultSelectionStart, replacementText);
      targetCursorPosition += replacementText.length;
    }

    if (beforeResultTextLength == 0 && _resultTextArray.length > 1) {
      for (var i = 0; i < mask.length; i++) {
        if (_maskChars.contains(mask[i])) {
          final resultPrefix = _resultTextArray._symbolArray.take(i).toList();
          for (var j = 0; j < resultPrefix.length; j++) {
            if (_resultTextArray.length <= j ||
                (mask[j] != resultPrefix[j] ||
                    (mask[j] == resultPrefix[j] &&
                        j == resultPrefix.length - 1))) {
              _resultTextArray.removeRange(0, j);
              break;
            }
          }
          break;
        }
      }
    }

    var curTextPos = 0;
    var maskPos = 0;
    _resultTextMasked = "";
    var cursorPos = -1;
    var nonMaskedCount = 0;

    while (maskPos < mask.length) {
      final curMaskChar = mask[maskPos];
      final isMaskChar = _maskChars.contains(curMaskChar);

      var curTextInRange = curTextPos < _resultTextArray.length;

      String? curTextChar;
      if (isMaskChar && curTextInRange) {
        while (curTextChar == null && curTextInRange) {
          final potentialTextChar = _resultTextArray[curTextPos];
          if (_maskFilter?[curMaskChar]?.hasMatch(potentialTextChar) ?? false) {
            curTextChar = potentialTextChar;
          } else {
            _resultTextArray.removeAt(curTextPos);
            curTextInRange = curTextPos < _resultTextArray.length;
            if (curTextPos <= targetCursorPosition) {
              targetCursorPosition -= 1;
            }
          }
        }
      } else if (!isMaskChar &&
          !curTextInRange &&
          type == GrockMaskAutoCompletionType.eager) {
        curTextInRange = true;
      }

      if (isMaskChar && curTextInRange && curTextChar != null) {
        _resultTextMasked += curTextChar;
        if (curTextPos == targetCursorPosition && cursorPos == -1) {
          cursorPos = maskPos - nonMaskedCount;
        }
        nonMaskedCount = 0;
        curTextPos += 1;
      } else {
        if (curTextPos == targetCursorPosition &&
            cursorPos == -1 &&
            !curTextInRange) {
          cursorPos = maskPos;
        }

        if (!curTextInRange) {
          break;
        } else {
          _resultTextMasked += mask[maskPos];
        }

        if (type == GrockMaskAutoCompletionType.lazy ||
            lengthRemoved > 0 ||
            currentResultSelectionLength > 0) {
          nonMaskedCount++;
        }
      }
      maskPos += 1;
    }

    if (nonMaskedCount > 0) {
      _resultTextMasked = _resultTextMasked.substring(
          0, _resultTextMasked.length - nonMaskedCount);
      cursorPos -= nonMaskedCount;
    }

    if (_resultTextArray.length > _maskLength) {
      _resultTextArray.removeRange(_maskLength, _resultTextArray.length);
    }

    final finalCursorPosition =
        cursorPos < 0 ? _resultTextMasked.length : cursorPos;

    return TextEditingValue(
        text: _resultTextMasked,
        selection: TextSelection(
            baseOffset: finalCursorPosition,
            extentOffset: finalCursorPosition,
            affinity: newValue.selection.affinity,
            isDirectional: newValue.selection.isDirectional));
  }

  void _calcMaskLength() {
    _maskLength = 0;
    final mask = _mask;
    if (mask != null) {
      for (var i = 0; i < mask.length; i++) {
        if (_maskChars.contains(mask[i])) {
          _maskLength++;
        }
      }
    }
  }

  void _updateFilter(Map<String, RegExp> filter) {
    _maskFilter = filter;
    _maskChars = _maskFilter?.keys.toList(growable: false) ?? [];
  }
}

class _TextMatcher {
  final List<String> _symbolArray = <String>[];

  int get length => _symbolArray.fold(0, (prev, match) => prev + match.length);

  void removeRange(int start, int end) => _symbolArray.removeRange(start, end);

  void insert(int start, String substring) {
    for (var i = 0; i < substring.length; i++) {
      _symbolArray.insert(start + i, substring[i]);
    }
  }

  bool get isEmpty => _symbolArray.isEmpty;

  void removeAt(int index) => _symbolArray.removeAt(index);

  String operator [](int index) => _symbolArray[index];

  void clear() => _symbolArray.clear();

  @override
  String toString() => _symbolArray.join();

  void set(String text) {
    _symbolArray.clear();
    for (var i = 0; i < text.length; i++) {
      _symbolArray.add(text[i]);
    }
  }
}

class GrockFormatters {
  static final TextInputFormatter number =
      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));
  static final TextInputFormatter numberWithDot =
      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'));
  static final TextInputFormatter numberWithComma =
      FilteringTextInputFormatter.allow(RegExp(r'[0-9,]'));
  static final TextInputFormatter numberWithDotAndComma =
      FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'));
  static final TextInputFormatter numberAndMinus =
      FilteringTextInputFormatter.allow(RegExp(r'[0-9-]'));
  static final TextInputFormatter numberAndUppercasedLetter =
      FilteringTextInputFormatter.allow(RegExp(r'[0-9A-Z]'));
  static final TextInputFormatter numberAndLowercasedLetter =
      FilteringTextInputFormatter.allow(RegExp(r'[0-9a-z]'));
  static final TextInputFormatter numberAndLetter =
      FilteringTextInputFormatter.allow(RegExp(r'[0-9A-Za-z]'));

  /// Example: +7 (999) 999-99-99
  static final TextInputFormatter phoneNumber = GrockInputFormatter(
      mask: '+# (###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: GrockMaskAutoCompletionType.lazy);

  /// Example: 9999 9999 9999 9999
  static final TextInputFormatter creditCardNumber = GrockInputFormatter(
      mask: '#### #### #### ####',
      filter: {"#": RegExp(r'[0-9]')},
      type: GrockMaskAutoCompletionType.lazy);

  /// Example: 99/99
  static final TextInputFormatter creditCardExpirationDate =
      GrockInputFormatter(
          mask: '##/##',
          filter: {"#": RegExp(r'[0-9]')},
          type: GrockMaskAutoCompletionType.lazy);

  /// Example: 999
  static final TextInputFormatter creditCardCVV = GrockInputFormatter(
      mask: '###',
      filter: {"#": RegExp(r'[0-9]')},
      type: GrockMaskAutoCompletionType.lazy);

  /// Example: 9999
  static final TextInputFormatter creditCardZipCode = GrockInputFormatter(
      mask: '####',
      filter: {"#": RegExp(r'[0-9]')},
      type: GrockMaskAutoCompletionType.lazy);

  /// Example: 99:99
  static final TextInputFormatter time = GrockInputFormatter(
      mask: '##:##',
      filter: {"#": RegExp(r'[0-9]')},
      type: GrockMaskAutoCompletionType.lazy);

  /// Example: 99:99:99
  static final TextInputFormatter timeWithSeconds = GrockInputFormatter(
      mask: '##:##:##',
      filter: {"#": RegExp(r'[0-9]')},
      type: GrockMaskAutoCompletionType.lazy);

  /// Example: 99.99
  static final TextInputFormatter decimal = GrockInputFormatter(
      mask: '##.##',
      filter: {"#": RegExp(r'[0-9]')},
      type: GrockMaskAutoCompletionType.lazy);

  /// Example: 99.99.9999
  static final TextInputFormatter date = GrockInputFormatter(
      mask: '##.##.####',
      filter: {"#": RegExp(r'[0-9]')},
      type: GrockMaskAutoCompletionType.lazy);

  /// Example: 99.99.9999 99:99
  static final TextInputFormatter dateTime = GrockInputFormatter(
      mask: '##.##.#### ##:##',
      filter: {"#": RegExp(r'[0-9]')},
      type: GrockMaskAutoCompletionType.lazy);

  /// Example: 99.99.9999 99:99:99
  static final TextInputFormatter dateTimeWithSeconds = GrockInputFormatter(
      mask: '##.##.#### ##:##:##',
      filter: {"#": RegExp(r'[0-9]')},
      type: GrockMaskAutoCompletionType.lazy);

  /// Example: Money formatter with 2 decimal places // 999,999,999,999.99
  static final TextInputFormatter money = GrockInputFormatter(
      mask: '###,###,###,###.##',
      filter: {"#": RegExp(r'[0-9]')},
      type: GrockMaskAutoCompletionType.lazy);

  /// Example: iban formatter // AA99 9999 9999 9999 9999 9999 99
  static final TextInputFormatter iban = GrockInputFormatter(
      mask: '**## #### #### #### #### #### ##',
      filter: {"#": RegExp(r'[0-9]'), "*": RegExp(r'[A-Z]')},
      type: GrockMaskAutoCompletionType.lazy);

  /// Example: tr iban formatter // TR99 9999 9999 9999 9999 9999 99
  static final TextInputFormatter trIban = GrockInputFormatter(
      mask: 'TR## #### #### #### #### #### ##',
      filter: {"#": RegExp(r'[0-9]')},
      type: GrockMaskAutoCompletionType.lazy);

  static final trPhoneNumber = GrockInputFormatter(
      mask: '+90 (###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: GrockMaskAutoCompletionType.lazy);

  /// Example: tr identity number formatter // 99999999999
  static final TextInputFormatter trIdentityNumber = GrockInputFormatter(
      mask: '###########',
      filter: {"#": RegExp(r'[0-9]')},
      type: GrockMaskAutoCompletionType.lazy);

  static final TextInputFormatter email =
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@._-]'));

  /// Example: tr plate number formatter // 99 AAA 999
  static final TextInputFormatter trPlateNumber = GrockInputFormatter(
      mask: '## *** ###',
      filter: {"#": RegExp(r'[0-9]'), "*": RegExp(r'[A-Z]')},
      type: GrockMaskAutoCompletionType.lazy);
}
