// Copyright 2025 Brian Erst
// SPDX-License-Identifier: MIT

import 'package:rational/rational.dart';
import 'package:numeric_utils/extensions/numeric_extensions.dart';

void main() {
  // Formatting with custom pattern
  final rational = Rational.parse('0.75');
  final formatted = rational.toDecimalString(2, pattern: '#.00%');
  print('Formatted: $formatted'); // Output: Formatted: 75.00%

  // Using halfEven rounding when the closest even is down
  var rationalHalfEven = Rational.parse('2.5');
  var roundedHalfEven = rationalHalfEven.rounded(RoundingMode.halfEven);
  
  // Output: HalfEven rounded: 2
  print('HalfEven rounded 2.5: $roundedHalfEven');

  // Using halfEven rounding when the closest even is up
  rationalHalfEven = Rational.parse('3.5');
  roundedHalfEven = rationalHalfEven.rounded(RoundingMode.halfEven);

  // Output: HalfEven rounded: 4
  print('HalfEven rounded 3.5: $roundedHalfEven');

  // Rounding to 3 decimal places in a specific locale.
  final kwd = Rational.parse('19.999');
  final formattedKwd = kwd.toCurrencyString(locale: 'ar_KW', decimalDigits: 3);

  // Output: KWD: ‏19.999E£
  print('KWD: $formattedKwd');
}