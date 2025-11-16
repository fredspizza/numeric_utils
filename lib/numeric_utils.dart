// Copyright 2025 Brian Erst
// SPDX-License-Identifier: MIT

/// A comprehensive library for working with numeric types in Dart.
///
/// This library provides extensions and utilities for precise numeric operations,
/// particularly useful for financial calculations, measurements, and scenarios
/// requiring exact decimal arithmetic.
///
/// ## Key Features
///
/// - **Rounding**: Multiple rounding modes (floor, ceil, halfUp, halfEven, etc.)
/// - **Formatting**: Localized currency, percentage, and decimal formatting
/// - **Parsing**: Parse fractions, mixed numbers, and various numeric formats
/// - **Validation**: Range checking, tolerance comparisons, multiple checking
/// - **Constants**: Common fractions, percentages, and numeric values
/// - **Percentage Calculations**: Semantic helpers for percentage operations
///
/// ## Quick Start
///
/// ```dart
/// import 'package:numeric_utils/numeric_utils.dart';
/// import 'package:rational/rational.dart';
///
/// void main() {
///   // Exact decimal arithmetic
///   final price = Rational.parse('19.99');
///   final taxRate = Rational.parse('0.08');
///   final total = price * (Rational.one + taxRate);
///
///   // Formatted output
///   print(total.toCurrency(locale: 'en_US')); // $21.59
///
///   // Percentage calculations
///   final discount = Rational.parse('15'); // 15%
///   final discountedPrice = discount.percentChangeOn(price);
///   print(discountedPrice.toCurrency(locale: 'en_US')); // $22.99
///
///   // Common rounding
///   final value = Rational.parse('1.234');
///   print(value.toNearestDecimal(2)); // 617/500 (1.234 rounded to 2 places)
///   print(value.toDecimal(2)); // "1.23" (formatted string)
/// }
/// ```
///
/// ## Importing
///
/// Import the entire library:
/// ```dart
/// import 'package:numeric_utils/numeric_utils.dart';
/// ```
///
/// Or import specific parts:
/// ```dart
/// import 'package:numeric_utils/extensions/numeric_extensions.dart';
/// import 'package:numeric_utils/constants/numeric_constants.dart';
/// ```
library;

export 'constants/numeric_constants.dart';
export 'extensions/numeric_extensions.dart';
