// Copyright 2025 Brian Erst
// SPDX-License-Identifier: MIT

import 'package:intl/intl.dart';
import 'package:numeric_utils/constants/numeric_constants.dart';
import 'package:rational/rational.dart';

/// Defines standard rounding modes for numerical rounding
enum RoundingMode {
  /// Rounds towards negative infinity
  ///
  /// Example:
  /// ```dart
  /// Rational.parse("-2.7").rounded(RoundingMode.floor); // -3
  /// Rational.parse("2.7").rounded(RoundingMode.floor);  // 2
  /// ```
  floor,

  /// Rounds towards positive infinity
  ///
  /// Example:
  /// ```dart
  /// Rational.parse("-2.3").rounded(RoundingMode.ceil); // -2
  /// Rational.parse("2.3").rounded(RoundingMode.ceil);  // 3
  /// ```
  ceil,

  /// Rounds towards zero (truncates fractional part)
  ///
  /// Example:
  /// ```dart
  /// Rational.parse("-2.7").rounded(RoundingMode.truncate); // -2
  /// Rational.parse("2.7").rounded(RoundingMode.truncate);  // 2
  /// ```
  truncate,

  /// Rounds away from zero, increasing the magnitude of the number
  ///
  /// - Positive values round up (toward +∞)
  /// - Negative values round down (toward -∞)
  ///
  /// Example:
  /// ```dart
  /// Rational.parse("-2.3").rounded(RoundingMode.up); // -3
  /// Rational.parse("2.3").rounded(RoundingMode.up);  // 3
  /// Rational.parse("-2.9").rounded(RoundingMode.up); // -3
  /// Rational.parse("2.9").rounded(RoundingMode.up);  // 3
  /// ```
  up,

  /// Rounds to the nearest integer using half-up rounding
  ///
  /// - If the fractional part is `>= 0.5`, rounds up
  /// - Otherwise, rounds down
  ///
  /// Example:
  /// ```dart
  /// Rational.parse("2.5").rounded(RoundingMode.halfUp);  // 3
  /// Rational.parse("2.4").rounded(RoundingMode.halfUp);  // 2
  /// Rational.parse("-2.5").rounded(RoundingMode.halfUp); // -3
  /// ```
  halfUp,

  /// Rounds to the nearest integer using half-down rounding
  ///
  /// - If the fractional part is `> 0.5`, rounds up
  /// - Otherwise, rounds down
  ///
  /// Example:
  /// ```dart
  /// Rational.parse("2.5").rounded(RoundingMode.halfDown);  // 2
  /// Rational.parse("2.6").rounded(RoundingMode.halfDown);  // 3
  /// Rational.parse("-2.5").rounded(RoundingMode.halfDown); // -2
  /// ```
  halfDown,

  /// Rounds to the nearest even integer in case of a tie
  ///
  /// Example:
  /// ```dart
  /// Rational.parse("2.5").rounded(RoundingMode.halfEven);  // 2
  /// Rational.parse("3.5").rounded(RoundingMode.halfEven);  // 4
  /// Rational.parse("-2.5").rounded(RoundingMode.halfEven); // -2
  /// Rational.parse("-3.5").rounded(RoundingMode.halfEven); // -4
  /// ```
  halfEven,
}

/// An extension on `Rational` to provide rounding functionality
extension RationalRoundingExtension on Rational {
  /// Rounds the `Rational` value according to the specified [mode]
  ///
  /// Uses the specified [mode] for rounding (default is `halfUp`)
  ///
  /// The rounding behavior varies based on the mode:
  /// - `floor`:    Rounds down to the nearest lower integer
  /// - `ceil`:     Rounds up to the nearest higher integer
  /// - `truncate`: Rounds towards zero, removing the fractional part
  /// - `up`:       Rounds away from zero, increasing the magnitude of the number
  /// - `halfUp`:   Rounds to the nearest integer, rounding up if exactly halfway
  /// - `halfDown`: Rounds to the nearest integer, rounding down if exactly halfway
  /// - `halfEven`: Rounds to the nearest integer; if exactly halfway, rounds to the nearest even integer
  ///
  /// Example:
  /// ```dart
  /// print(Rational.parse("7.51").rounded(RoundingMode.floor));     // 7.51 --> 7
  /// print(Rational.parse("7.01").rounded(RoundingMode.ceil));      // 7.01 --> 8
  /// print(Rational.parse("7.99").rounded(RoundingMode.truncate));  // 7.99 --> 7
  /// print(Rational.parse("-7.99").rounded(RoundingMode.truncate)); // -7.99 --> -7
  /// print(Rational.parse("7.01").rounded(RoundingMode.up));        // 7.01 --> 8
  /// print(Rational.parse("-7.01").rounded(RoundingMode.up));       // -7.01 --> -8
  /// print(Rational.parse("7.5").rounded(RoundingMode.halfUp));     // 7.5  --> 8
  /// print(Rational.parse("7.5").rounded(RoundingMode.halfDown));   // 7.5  --> 7
  /// print(Rational.parse("7.5").rounded(RoundingMode.halfEven));   // 7.5  --> 8 (rounds up to even)
  /// print(Rational.parse("8.5").rounded(RoundingMode.halfEven));   // 8.5  --> 8 (rounds down to even)
  /// ```
  Rational rounded([RoundingMode mode = RoundingMode.halfUp]) {
    final BigInt wholeNumber = truncate(); // Extract integer part
    final Rational fraction = this - Rational(wholeNumber); // Extract fractional part

    // If it's already an integer, return as is
    if (fraction == Rational.zero) {
      return this;
    }

    switch (mode) {
      case RoundingMode.floor:
        return fraction < Rational.zero ? Rational(wholeNumber - BigInt.one) : Rational(wholeNumber);

      case RoundingMode.ceil:
        return fraction > Rational.zero ? Rational(wholeNumber + BigInt.one) : Rational(wholeNumber);

      case RoundingMode.truncate:
        return Rational(wholeNumber);

      case RoundingMode.up:
        // Round up for positive numbers, down for negative
        return fraction > Rational.zero ? Rational(wholeNumber + BigInt.one) : Rational(wholeNumber - BigInt.one);

      case RoundingMode.halfUp:
        return _roundedHalf(wholeNumber, fraction, roundUp: true);

      case RoundingMode.halfDown:
        return _roundedHalf(wholeNumber, fraction, roundUp: false);

      case RoundingMode.halfEven:
        return _roundedHalfEven(wholeNumber, fraction);
    }
  }

  /// Handles half-up and half-down rounding modes
  Rational _roundedHalf(BigInt wholeNumber, Rational fraction, {required bool roundUp}) {
    final BigInt doubleNumerator = fraction.numerator * BigInt.two;
    final BigInt denominator = fraction.denominator;

    // Only round up if fraction is strictly greater than 0.5 OR if using halfUp
    if (doubleNumerator.abs() > denominator || (roundUp && doubleNumerator.abs() == denominator)) {
      return Rational(wholeNumber + (fraction > Rational.zero ? BigInt.one : -BigInt.one));
    } else {
      return Rational(wholeNumber);
    }
  }

  /// Handles half-even rounding mode
  Rational _roundedHalfEven(BigInt wholeNumber, Rational fraction) {
    final BigInt doubleNumerator = fraction.numerator * BigInt.two;
    final BigInt denominator = fraction.denominator;

    if (doubleNumerator.abs() < denominator) {
      return Rational(wholeNumber); // Round down
    }

    if (doubleNumerator.abs() > denominator) {
      return Rational(wholeNumber + (fraction > Rational.zero ? BigInt.one : -BigInt.one)); // Round up
    }

    // If exactly halfway, round to the nearest even number
    return (wholeNumber.isEven)
        ? Rational(wholeNumber)
        : Rational(wholeNumber + (fraction > Rational.zero ? BigInt.one : -BigInt.one));
  }

  /// Rounds the `Rational` value to the nearest multiple of [minIncrement]
  ///
  /// Uses the specified [mode] for rounding (default is `halfUp`)
  ///
  /// - `floor`:    Rounds down to the nearest multiple of `minIncrement`
  /// - `ceil`:     Rounds up to the nearest multiple of `minIncrement`
  /// - `truncate`: Rounds towards zero to the nearest multiple
  /// - `up`:       Rounds away from zero, increasing the magnitude of the number
  /// - `halfUp`:   Rounds to the nearest multiple, rounding up on ties
  /// - `halfDown`: Rounds to the nearest multiple, rounding down on ties
  /// - `halfEven`: Not supported —  Ambiguous for fractional increments.  'Half-even' rounding is not meaningfully defined for rounding to the nearest multiple of a fraction.
  ///
  /// If [minIncrement] is zero or [mode] is `halfEven`, an [ArgumentError] is thrown
  ///
  /// Example:
  /// ```dart
  /// Rational increment = Rational.fromInt(1, 4);
  ///
  /// print(Rational.parse("7.24").toNearest(increment, mode: RoundingMode.floor));     // 7.24 --> 7.0
  /// print(Rational.parse("7.26").toNearest(increment, mode: RoundingMode.ceil));      // 7.26 --> 7.5
  /// print(Rational.parse("7.76").toNearest(increment, mode: RoundingMode.truncate));  // 7.76 --> 7.75
  /// print(Rational.parse("-7.76").toNearest(increment, mode: RoundingMode.truncate)); // -7.76 --> -7.75
  /// print(Rational.parse("7.26").toNearest(increment, mode: RoundingMode.up));        // 7.26 --> 7.5
  /// print(Rational.parse("-7.26").toNearest(increment, mode: RoundingMode.up));       // -7.26 --> -7.5
  /// print(Rational.parse("7.375").toNearest(increment, mode: RoundingMode.halfUp));   // 7.375 --> 7.5
  /// print(Rational.parse("7.375").toNearest(increment, mode: RoundingMode.halfDown)); // 7.375 --> 7.25
  /// print(Rational.parse("7.50").toNearest(increment, mode: RoundingMode.halfEven));  // Throws ArgumentError
  /// ```
  /// Throws:
  ///   - `ArgumentError`: If [minIncrement] is zero or if [mode] is [RoundingMode.halfEven]
  Rational toNearest(Rational minIncrement, {RoundingMode mode = RoundingMode.halfUp}) {
    if (minIncrement == Rational.zero) {
      throw ArgumentError('minIncrement cannot be zero');
    }

    if (mode == RoundingMode.halfEven) {
      throw ArgumentError('halfEven is not supported for fractional rounding');
    }

    final Rational scaled = this / minIncrement;
    final Rational rounded = scaled.rounded(mode);
    return rounded * minIncrement;
  }
}

/// An extension on `Rational` to provide some common rounding functionality
extension RationalCommonRoundingExtension on Rational {
  /// Rounds the rational number to the nearest decimal place
  ///
  /// Parameters:
  ///   - `places`: The number of decimal places to round to
  ///   - `mode`: The rounding mode to apply. Defaults to [RoundingMode.halfUp]
  ///
  /// Returns:
  ///   The rational number rounded to the nearest decimal place
  Rational toDecimalPlace(int places, {RoundingMode mode = RoundingMode.halfUp}) {
    if (places < 0) {
      throw ArgumentError('The number of places must be non-negative.');
    }
    final scale = Rational(BigInt.from(10).pow(places));
    return (this * scale).rounded(mode) / scale;
  }

  /// Rounds the rational number to the nearest cent (two decimal places)
  ///
  /// Parameters:
  ///   - `mode`: The rounding mode to apply. Defaults to [RoundingMode.halfUp]
  ///
  /// Returns:
  ///   The rational number rounded to the nearest cent
  Rational toCents([RoundingMode mode = RoundingMode.halfUp]) {
    return toDecimalPlace(2, mode: mode);
  }

  /// Rounds the rational number to the nearest half
  ///
  /// Parameters:
  ///   - `mode`: The rounding mode to apply. Defaults to [RoundingMode.halfUp]
  ///
  /// Returns:
  ///   The rational number rounded to the nearest half
  Rational toNearestHalf([RoundingMode mode = RoundingMode.halfUp]) {
    return toNearest(RationalConstants.half, mode: mode);
  }

  /// Rounds the rational number to the nearest third
  ///
  /// Parameters:
  ///   - `mode`: The rounding mode to apply. Defaults to [RoundingMode.halfUp]
  ///
  /// Returns:
  ///   The rational number rounded to the nearest third
  Rational toNearestThird([RoundingMode mode = RoundingMode.halfUp]) {
    return toNearest(RationalConstants.third, mode: mode);
  }

  /// Rounds the rational number to the nearest quarter
  ///
  /// Parameters:
  ///   - `mode`: The rounding mode to apply. Defaults to [RoundingMode.halfUp]
  ///
  /// Returns:
  ///   The rounded rational number
  Rational toNearestQuarter([RoundingMode mode = RoundingMode.halfUp]) {
    return toNearest(RationalConstants.quarter, mode: mode);
  }
}

/// An extension on `Rational` to provide additional formatting functionality
extension RationalFormattingExtension on Rational {
  /// Formats the rational number as a localized decimal string with a specified number of decimal places,
  /// applying the given rounding mode
  ///
  /// Example:
  /// ```dart
  /// import 'package:numeric_utils/extensions/numeric_extensions.dart';
  /// import 'package:rational/rational.dart';
  ///
  /// final rational = Rational.fromInt(1, 3);                                       // i.e., Rational.parse('1/3');
  /// print(rational.toDecimalPlaces(3, locale: 'en_US'));                           // Output: 0.333
  /// print(rational.toDecimalPlaces(3, mode: RoundingMode.up, locale: 'fr_FR'));    // Output: 0,334
  ///
  /// final quarter = Rational.fromInt(1, 4);                                        // i.e., Rational.parse('1/4');
  /// print(quarter.toDecimalPlaces(3, locale: 'de_DE'));                            // Output: 0,250
  /// print(quarter.toDecimalPlaces(3, stripTrailingZeros: true, locale: 'de_DE'));  // Output: 0,25
  ///
  /// // Using a custom pattern to show percentage with 2 decimal places
  /// final percentage = Rational.fromInt(75, 100)                                   // i.e., Rational.parse('75/100');
  /// print(percentage.toDecimalPlaces(2, pattern: '#.00%', locale: 'en_US'));       // Output: 75.00%
  ///
  /// // Using a custom pattern to show currency
  /// final price = Rational.fromInt(1999, 100)                                      // i.e., Rational.parse('1999/100');
  /// print(price.toDecimalPlaces(2, pattern: '¤#,##0.00', locale: 'en_US'));        // Output: $19.99
  /// ```
  ///
  /// Parameters:
  ///   - `places`: The number of decimal places to include in the formatted string
  ///   - `mode`: The rounding mode to apply when truncating or rounding the number. Defaults to [RoundingMode.halfUp]
  ///   - `stripTrailingZeros`: If `true`, trailing zeros after the decimal point are removed. Defaults to `false`
  ///   - `locale`: The locale to use for formatting the number. Defaults to the system's default locale
  ///   - `pattern`: Optional custom number pattern to use for formatting. If not provided, uses the locale's decimal pattern
  ///
  /// Returns:
  ///   A localized string representation of the rational number with the specified decimal places and rounding
  ///
  /// Throws:
  ///   - `ArgumentError`: If `places` is negative
  ///   - `FormatException`: If the number cannot be parsed or formatted
  String toDecimalPlaces(
    int places, {
    RoundingMode mode = RoundingMode.halfUp,
    bool stripTrailingZeros = false,
    String? locale,
    String? pattern,
  }) {
    if (places < 0) {
      throw ArgumentError('The number of places must be non-negative.');
    }

    // Scale and round the number
    final scale = BigInt.from(10).pow(places);
    final scaled = (this * Rational(scale)).rounded(mode);
    final result = scaled / Rational(scale);

    try {
      // Create number format based on locale and/or pattern
      final numberFormat = pattern != null ? NumberFormat(pattern, locale) : NumberFormat.decimalPattern(locale);

      // Configure decimal places
      numberFormat.minimumFractionDigits = stripTrailingZeros ? 0 : places;
      numberFormat.maximumFractionDigits = places;

      // Return the formatted number
      return numberFormat.format(result.toDouble());
    } on FormatException catch (e) {
      throw FormatException('Failed to format number: ${e.message}', e.source, e.offset);
    }
  }

  /// Formats the rational number as a localized currency string
  ///
  /// Example:
  /// ```dart
  /// import 'package:numeric_utils/extensions/numeric_extensions.dart';
  /// import 'package:rational/rational.dart';
  ///
  /// final price = Rational.fromInt(1999, 100);  // i.e., Rational.parse('1999/100');
  /// print(price.toCurrency(locale: 'en_US'));   // Output: $19.99
  /// print(price.toCurrency(locale: 'fr_FR'));   // Output: 19,99 €
  /// print(price.toCurrency(locale: 'ja_JP'));   // Output: ¥1,999
  /// print(price.toCurrency(locale: 'en_US', currencyName: 'USD')); // Output: $19.99
  /// ```
  ///
  /// Parameters:
  ///   - `mode`: The rounding mode to apply when rounding the number. Defaults to [RoundingMode.halfUp].
  ///   - `locale`: The locale to use for formatting the currency. Defaults to the system's default locale.
  ///   - `currencyName`: Optional currency name (e.g., 'USD', 'EUR') to use. If not provided, uses the locale's default currency.
  ///   - `decimalDigits`: Optional number of decimal digits. If not provided, uses the locale's default.
  ///
  /// Returns:
  ///   A localized currency string representation of the rational number with the specified rounding.
  ///
  /// Throws:
  ///   - `FormatException`: If the number cannot be formatted.
  ///   - `ArgumentError`: If locale is invalid.
  String toCurrency({
    String? locale,
    String? currencyName, // Changed from symbol to currencyName
    int? decimalDigits,
  }) {
    try {
      final numberFormat = NumberFormat.simpleCurrency(
        locale: locale,
        name: currencyName, // Using currencyName here
        decimalDigits: decimalDigits,
      );

      return numberFormat.format(toDouble());
    } on FormatException catch (e) {
      throw FormatException('Failed to format currency: ${e.message}', e.source, e.offset);
    } catch (e) {
      throw ArgumentError('Invalid Locale');
    }
  }

  /// Formats the rational number as a percentage string, with a specified number of decimal places,
  /// applying the given rounding mode.
  ///
  /// Allows formatting percentages where the input is either a ratio value (e.g., 0.33)
  /// or already a value between 0 and 100 (e.g., 33).
  ///
  /// Example (assuming `asRatio` is true - default):
  /// ```dart
  /// import 'package:numeric_utils/numeric_extensions.dart';
  /// import 'package:rational/rational.dart';
  ///
  /// final rationalUnit = Rational.fromInt(1, 3);
  /// print(rationalUnit.toPercentage(2));                          // Output: 33.33%
  /// print(rationalUnit.toPercentage(2, mode: RoundingMode.ceil)); // Output: 33.34%
  /// print(rationalUnit.toPercentage(0));                          // Output: 33%
  /// print(rationalUnit.toPercentage(2, locale: 'fr_FR'));         // Output: 33,33%
  /// ```
  ///
  /// Example (when `asRatio` is false):
  /// ```dart
  /// final rationalPercentage = Rational.fromInt(66, 2); // Represents 33
  /// print(rationalPercentage.toPercentage(2, asRatio: false));     // Output: 33.00%
  /// ```
  ///
  /// Parameters:
  ///   - `places`: The number of decimal places to include in the formatted percentage string.
  ///   - `mode`: The rounding mode to apply when truncating or rounding the number. Defaults to [RoundingMode.halfUp].
  ///   - `locale`: The locale to use for formatting the number. Defaults to the system's default locale.
  ///   - `asRatio`: A boolean indicating whether the rational number should be treated as a ratio (between 0 and 1) and multiplied by 100 before formatting. Defaults to `true`.
  ///
  /// Returns:
  ///   A localized percentage string representation of the rational number with the specified decimal places and rounding.
  ///
  /// Throws:
  ///   - `ArgumentError`: If `places` is negative.
  String toPercentage(
      int places, {
        RoundingMode mode = RoundingMode.halfUp,
        String? locale,
        bool asRatio = true,
      }) {
    if (places < 0) {
      throw ArgumentError('The number of places must be non-negative.');
    }

    Rational valueToFormat = this;
    if (asRatio) {
      valueToFormat *= Rational.fromInt(100);
    }

    final scale = Rational(BigInt.from(10).pow(places));
    final scaled = (valueToFormat * scale).rounded(mode);
    final result = scaled / scale;

    final numberFormat = NumberFormat.decimalPattern(locale);
    numberFormat.minimumFractionDigits = places;
    numberFormat.maximumFractionDigits = places;
    return '${numberFormat.format(result.toDouble())}%';
  }
}

/// A utility class for parsing strings into [Rational] objects with round-trip support.
/// Unlike [Rational.parse], which only handles integers, decimals, and scientific notation,
/// this class can parse fractions (e.g., "7/4") produced by [Rational.toString], ensuring
/// compatibility with its output format as well as mixed fractions (e.g., "1 3/4").
class RationalParsing {
  // Regex for mixed numbers and simple fractions with flexible whitespace
  // - \s*: Optional whitespace at the start
  // - (-)?\s*: Optional negative sign with optional whitespace after it
  // - (?:(\d+)\s+)?\s*: Optional whole part with optional whitespace around it
  // - (\d+)\s*/\s*(\d+): Fraction part with optional whitespace around the slash
  // - \s*: Optional whitespace at the end
  static final fractionRegex = RegExp(r'^\s*(-)?\s*(?:(\d+)\s+)?(\d+)\s*/\s*(\d+)\s*$');

  /// Parses a string into a [Rational] object, supporting fractions, mixed numbers,
  /// integers, decimals, and scientific notation.
  ///
  /// This method extends the functionality of [Rational.parse] by handling fraction
  /// formats produced by [Rational.toString] (e.g., "7/4") as well mixed fractions
  /// (e.g., "1 3/4"). It ignores whitespace and accepts positive and negative:
  /// - Mixed numbers (e.g., "1 3/4", " - 2 1/2 ") with optional whole parts and whitespace
  /// - Simple fractions (e.g., "3/4", " - 5/6 ") with optional whitespace
  /// - Integers, decimals, and scientific notation (e.g., "5", "0.75", "1e-3"), passed to [Rational.parse]
  ///
  /// Example:
  /// ```dart
  /// print(RationalParsing.fromString("1 3/4"));      // Outputs: 7/4
  /// print(RationalParsing.fromString("-2 1/2"));     // Outputs: -5/2
  /// print(RationalParsing.fromString(" 3/4 "));      // Outputs: 3/4
  /// print(RationalParsing.fromString(" - 5/6 "));    // Outputs: -5/6
  /// print(RationalParsing.fromString("5"));          // Outputs: 5
  /// print(RationalParsing.fromString("0.75"));       // Outputs: 3/4
  /// print(RationalParsing.fromString("1e-3"));       // Outputs: 1/1000
  /// ```
  ///
  /// - [value]: The string to parse into a [Rational]
  /// - Returns: A [Rational] object representing the parsed value
  /// - Throws: [FormatException] if the string is not a valid number or fraction format,
  ///          or if the denominator of a fraction is zero
  static Rational fromString(String value) {
    // Case 1: Mixed number or simple fraction (e.g., " 1 3/4 ", " - 3/4 ")
    if (fractionRegex.hasMatch(value)) {
      final match = fractionRegex.firstMatch(value)!;

      // Extract the negative sign (group 1)
      final isNegative = match.group(1) != null;

      // Whole part might be null if there's no whole number (e.g., "3/4")
      final whole = match.group(2);
      final numerator = int.parse(match.group(3)!);
      final denominator = int.parse(match.group(4)!);

      if (denominator == 0) {
        throw FormatException('Denominator cannot be zero in fraction: $value');
      }

      // If there's a whole part, convert mixed number to improper fraction
      // Otherwise, use just the fraction part
      final wholePart = denominator * (whole != null ? int.parse(whole) : 0);
      final result = Rational.fromInt(wholePart + numerator, denominator);
      return isNegative ? -result : result;
    }
    // Case 2: Decimal or Integer (e.g., " 0.75 ", " 5 ")
    else {
      try {
        // Rational.parse doesn't handle whitespace, but we do
        return Rational.parse(value.trim());
      } catch (e) {
        throw FormatException('Invalid number format: $value');
      }
    }
  }

  /// Attempts to parse a string into a [Rational] object.
  ///
  /// This method uses [fromString] to parse the input string. If parsing fails,
  /// it returns `null` instead of throwing an exception.
  ///
  /// Example:
  /// ```dart
  /// print(RationalParsing.tryFromString("1 3/4"));   // Outputs: 7/4
  /// print(RationalParsing.tryFromString("invalid")); // Outputs: null
  /// ```
  ///
  /// - [value]: The string to attempt to parse into a [Rational].
  /// - Returns: A [Rational] object if parsing is successful, or `null` if parsing fails.
  static Rational? tryFromString(String value) {
    try {
      return fromString(value);
    } catch (e) {
      return null;
    }
  }
}

/// Extension on `BigInt` to support division with rounding
extension BigIntRoundedDivisionExtension on BigInt {
  /// Divides `this` by [denominator] and rounds the result using the specified [mode]
  ///
  /// The rounding behavior varies based on the mode:
  /// - `floor`:    Rounds down to the next lower integer
  /// - `ceil`:     Rounds up to the next higher integer
  /// - `truncate`: Rounds towards zero (removes the fractional part)
  /// - `up`:       Rounds away from zero, increasing the magnitude of the quotient
  /// - `halfUp`:   Rounds to the nearest integer, rounding up on ties
  /// - `halfDown`: Rounds to the nearest integer, rounding down on ties
  /// - `halfEven`: Rounds to the nearest integer; if exactly halfway, rounds to the nearest even integer
  ///
  /// Example:
  /// ```dart
  /// print(BigInt.from(11).roundedDiv(BigInt.from(3), RoundingMode.floor));     // 11 / 3  --> 3
  /// print(BigInt.from(10).roundedDiv(BigInt.from(3), RoundingMode.ceil));      // 10 / 3  --> 4
  /// print(BigInt.from(11).roundedDiv(BigInt.from(3), RoundingMode.truncate));  // 11 / 3  --> 3
  /// print(BigInt.from(-10).roundedDiv(BigInt.from(3), RoundingMode.truncate)); // -11 / 3 --> -3
  /// print(BigInt.from(10).roundedDiv(BigInt.from(3), RoundingMode.up));        // 10 / 3  --> 4
  /// print(BigInt.from(-10).roundedDiv(BigInt.from(2), RoundingMode.up));       // -10 / 3 --> -4
  /// print(BigInt.from(7).roundedDiv(BigInt.from(2), RoundingMode.halfUp));     // 7 / 2   --> 4
  /// print(BigInt.from(7).roundedDiv(BigInt.from(2), RoundingMode.halfDown));   // 7 / 2   --> 3
  /// print(BigInt.from(7).roundedDiv(BigInt.from(2), RoundingMode.halfEven));   // 7 / 2   --> 4
  /// print(BigInt.from(5).roundedDiv(BigInt.from(2), RoundingMode.halfEven));   // 5 / 2   --> 2
  /// print(BigInt.from(6).roundedDiv(BigInt.from(2), RoundingMode.halfEven));   // 6 / 2   --> 3
  /// ```
  ///
  /// - [denominator]: The divisor
  /// - [mode]: The rounding mode to apply
  /// - Returns: The rounded quotient as a `BigInt`
  BigInt roundedDiv(BigInt denominator, RoundingMode mode) {
    final Rational value = Rational(this, denominator);
    return value.rounded(mode).toBigInt();
  }
}

/// Extension on `BigInt` to support isMultipleOf
extension BigIntMultipleOfExtension on BigInt {
  /// Returns true if this BigInt is a multiple of [other]
  ///
  /// Example:
  /// ```dart
  /// BigInt.from(10).isMultipleOf(BigInt.from(5)); // Output: true
  /// BigInt.from(11).isMultipleOf(BigInt.from(5)); // Output: false
  /// ```
  bool isMultipleOf(BigInt other) {
    if (other == BigInt.zero) {
      return this == BigInt.zero;
    }
    return (this % other) == BigInt.zero;
  }
}

/// Extension on `int` to support isMultipleOf
extension IntMultipleOfExtension on int {
  /// Returns true if this int is a multiple of [other]
  ///
  /// Example:
  /// ```dart
  /// 10.isMultipleOf(5); // Output: true
  /// 11.isMultipleOf(5); // Output: false
  /// ```
  bool isMultipleOf(int other) {
    if (other == 0) {
      return this == 0;
    }
    return (this % other) == 0;
  }
}
