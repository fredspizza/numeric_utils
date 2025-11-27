// Copyright 2025 Brian Erst
// SPDX-License-Identifier: MIT

import 'package:rational/rational.dart';
import 'package:numeric_utils/extensions/numeric_extensions.dart';

void main() {
  // Creating Rational numbers
  final rational1 = Rational.fromInt(3, 4);   // 3/4
  final rational2 = Rational.parse('1.5');    // 3/2

  // Basic arithmetic
  final sum = rational1 + rational2;
  print('Sum: $sum'); // Output: Sum: 9/4

  // Rounding
  final rounded = rational2.rounded();
  print('Rounded 1.5: $rounded'); // Output: Rounded 1.5: 2

  // Formatting
  final formattedNoMin = rational1.toPercentageString(2);
  print('Percentage: $formattedNoMin'); // Output: Percentage: 75%

  // Formatting
  final formattedWithMin = rational1.toPercentageString(2, minDecimals: 2);
  print('Percentage: $formattedWithMin'); // Output: Percentage: 75.00%

  // Currency formatting
  final price = Rational.parse('19.99');
  print('Price: ${price.toCurrencyString(locale: 'en_US')}'); // Output: Price: $19.99
  print('Price: ${price.toCurrencyString(locale: 'fr_FR')}'); // Output: Price: 19,99 €

  // BigInt rounded division
  final bigIntResult = BigInt.from(10).roundedDiv(BigInt.from(3), RoundingMode.ceil);
  print('BigInt rounded division: $bigIntResult'); // Output: BigInt rounded division: 4
}