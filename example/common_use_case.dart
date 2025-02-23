// Copyright 2025 Brian Erst
// SPDX-License-Identifier: MIT

import 'package:rational/rational.dart';
import 'package:numeric_utils/extensions/numeric_extensions.dart';

void main() {
  // Rounding a price to the nearest cent
  final price = Rational.parse('19.994');
  final roundedPrice = price.toCents();
  print('Rounded price: ${roundedPrice.toDouble()}'); // Output: Rounded price: 19.99

  // Rounding a measurement to the nearest quarter
  final measurement = Rational.parse('3.37');
  final roundedMeasurement = measurement.toNearestQuarter();
  print('Rounded measurement: ${roundedMeasurement.toDouble()}'); // Output: Rounded measurement: 3.25

  // Checking if a BigInt is a multiple.
  final bigIntValue = BigInt.from(10);
  final isMultiple = bigIntValue.isMultipleOf(BigInt.from(5));
  print('Is 10 a multiple of 5: $isMultiple'); // Output: Is 10 a multiple of 5: true
}