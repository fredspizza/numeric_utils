// Copyright 2025 Brian Erst
// SPDX-License-Identifier: MIT

import 'package:rational/rational.dart';
import 'package:numeric_utils/extensions/numeric_extensions.dart';

void main() {
  // Division by zero with BigInt
  try {
    BigInt.from(10).roundedDiv(BigInt.zero, RoundingMode.halfUp);
  } catch (e) {
    // Output - Error: Invalid argument(s): zero can not be used as denominator
    print('Error: $e');
  }

  // Negative decimal places
  try {
    Rational.parse('1.23').toDecimalPlace(-1);
  } catch (e) {
    // Output - Error: Invalid argument(s): The number of places must be non-negative.
    print('Error: $e');
  }

  // Invalid locale
  try {
    Rational.parse('19.99').toCurrency(locale: 'bad_locale');
  } catch(e) {
    // Output - Error: Invalid argument(s): Invalid Locale
    print('Error: $e');
  }
}