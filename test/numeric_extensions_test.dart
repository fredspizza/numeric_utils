// Copyright 2025 Brian Erst
// SPDX-License-Identifier: MIT

import 'package:test/test.dart';
import 'package:rational/rational.dart';
import 'package:numeric_utils/extensions/numeric_extensions.dart';

void main() {
  group('Rational.rounded()', () {
    test('Floor rounding', () {
      expect(Rational.parse('7.51').rounded(RoundingMode.floor), Rational.fromInt(7));
      expect(Rational.parse('-7.51').rounded(RoundingMode.floor), Rational.fromInt(-8));
    });

    test('Ceil rounding', () {
      expect(Rational.parse('7.01').rounded(RoundingMode.ceil), Rational.fromInt(8));
      expect(Rational.parse('-7.99').rounded(RoundingMode.ceil), Rational.fromInt(-7));
    });

    test('Truncate rounding', () {
      expect(Rational.parse('7.99').rounded(RoundingMode.truncate), Rational.fromInt(7));
      expect(Rational.parse('-7.99').rounded(RoundingMode.truncate), Rational.fromInt(-7));
    });

    test('Up rounding (away from zero)', () {
      expect(Rational.parse('7.01').rounded(RoundingMode.up), Rational.fromInt(8));
      expect(Rational.parse('-7.01').rounded(RoundingMode.up), Rational.fromInt(-8));
    });

    test('Half-up rounding', () {
      expect(Rational.parse('7.5').rounded(RoundingMode.halfUp), Rational.fromInt(8));
      expect(Rational.parse('-7.5').rounded(RoundingMode.halfUp), Rational.fromInt(-8));
    });

    test('Half-down rounding', () {
      expect(Rational.parse('7.5').rounded(RoundingMode.halfDown), Rational.fromInt(7));
      expect(Rational.parse('-7.5').rounded(RoundingMode.halfDown), Rational.fromInt(-7));
    });

    test('Half-even rounding', () {
      expect(Rational.parse('7.5').rounded(RoundingMode.halfEven), Rational.fromInt(8));
      expect(Rational.parse('8.5').rounded(RoundingMode.halfEven), Rational.fromInt(8));
      expect(Rational.parse('9.5').rounded(RoundingMode.halfEven), Rational.fromInt(10));
      expect(Rational.parse('-7.5').rounded(RoundingMode.halfEven), Rational.fromInt(-8));
    });

    test('Values just below and above rounding thresholds', () {
      expect(Rational.parse('7.4999999999').rounded(RoundingMode.halfUp), Rational.fromInt(7));
      expect(Rational.parse('7.5000000001').rounded(RoundingMode.halfUp), Rational.fromInt(8));
      expect(Rational.parse('7.4999999999').rounded(RoundingMode.halfDown), Rational.fromInt(7));
      expect(Rational.parse('7.5000000001').rounded(RoundingMode.halfDown), Rational.fromInt(8));
    });

    test('Large numbers rounding', () {
      expect(Rational.parse('99999999999.5').rounded(RoundingMode.halfUp), Rational.parse('100000000000'));
      expect(Rational.parse('99999999999.5').rounded(RoundingMode.halfDown), Rational.parse('99999999999'));
    });

    test('Very small over/under rounding', () {
      expect(Rational.parse('0.499999999999999').rounded(RoundingMode.halfUp), Rational.fromInt(0));
      expect(Rational.parse('0.500000000000001').rounded(RoundingMode.halfUp), Rational.fromInt(1));
    });

    test('Negative half rounding', () {
      expect(Rational.parse('-0.5').rounded(RoundingMode.halfUp), Rational.fromInt(-1));
      expect(Rational.parse('-0.5').rounded(RoundingMode.halfDown), Rational.fromInt(0));
      expect(Rational.parse('-1.5').rounded(RoundingMode.halfEven), Rational.fromInt(-2));
    });

    test('Rational rounding is immutable', () {
      final original = Rational.parse('7.5');
      final rounded = original.rounded(RoundingMode.halfUp);
      expect(original, Rational.parse('7.5')); // Original should be unchanged
      expect(rounded, Rational.fromInt(8));
    });

    test('Zero rounding', () {
      expect(Rational.zero.rounded(RoundingMode.floor), Rational.zero);
      expect(Rational.zero.rounded(RoundingMode.ceil), Rational.zero);
      expect(Rational.zero.rounded(RoundingMode.truncate), Rational.zero);
      expect(Rational.zero.rounded(RoundingMode.up), Rational.zero);
      expect(Rational.zero.rounded(RoundingMode.halfUp), Rational.zero);
      expect(Rational.zero.rounded(RoundingMode.halfDown), Rational.zero);
      expect(Rational.zero.rounded(RoundingMode.halfEven), Rational.zero);
    });

    test('Near zero rounding', () {
      expect(Rational.parse('0.0000000001').rounded(RoundingMode.halfUp), Rational.zero);
      expect(Rational.parse('-0.0000000001').rounded(RoundingMode.halfUp), Rational.zero);
    });

    test('Integer values remain unchanged', () {
      expect(Rational.fromInt(5).rounded(RoundingMode.halfUp), Rational.fromInt(5));
      expect(Rational.fromInt(-5).rounded(RoundingMode.halfUp), Rational.fromInt(-5));
    });

    test('Very large negative numbers rounding', () {
      expect(Rational.parse('-99999999999.5').rounded(RoundingMode.halfUp), Rational.parse('-100000000000'));
      expect(Rational.parse('-99999999999.5').rounded(RoundingMode.halfDown), Rational.parse('-99999999999'));
    });
  });

  group('Rational.toNearest()', () {
    final Rational increment = Rational.fromInt(1, 4);

    test('Floor rounding', () {
      expect(Rational.parse('7.24').toNearest(increment, mode: RoundingMode.floor), Rational.parse('7.00'));
    });

    test('Ceil rounding', () {
      expect(Rational.parse('7.26').toNearest(increment, mode: RoundingMode.ceil), Rational.parse('7.5'));
    });

    test('Truncate rounding', () {
      expect(Rational.parse('7.76').toNearest(increment, mode: RoundingMode.truncate), Rational.parse('7.75'));
      expect(Rational.parse('-7.76').toNearest(increment, mode: RoundingMode.truncate), Rational.parse('-7.75'));
    });

    test('Up rounding (away from zero)', () {
      expect(Rational.parse('7.26').toNearest(increment, mode: RoundingMode.up), Rational.parse('7.5'));
      expect(Rational.parse('-7.26').toNearest(increment, mode: RoundingMode.up), Rational.parse('-7.5'));
    });

    test('Half-up rounding', () {
      expect(Rational.parse('7.375').toNearest(increment, mode: RoundingMode.halfUp), Rational.parse('7.5'));
      expect(Rational.parse('-7.375').toNearest(increment, mode: RoundingMode.halfUp), Rational.parse('-7.5'));
    });

    test('Half-down rounding', () {
      expect(Rational.parse('7.375').toNearest(increment, mode: RoundingMode.halfDown), Rational.parse('7.25'));
      expect(Rational.parse('-7.375').toNearest(increment, mode: RoundingMode.halfDown), Rational.parse('-7.25'));
    });

    test('halfEven rounding (should throw error)', () {
      expect(() => Rational.parse('7.50').toNearest(Rational.fromInt(1, 2), mode: RoundingMode.halfEven),
          throwsA(isA<ArgumentError>()));
    });

    test('Exact multiples of minIncrement remain unchanged', () {
      expect(Rational.parse('7.25').toNearest(increment, mode: RoundingMode.floor), Rational.parse('7.25'));
      expect(Rational.parse('7.25').toNearest(increment, mode: RoundingMode.ceil), Rational.parse('7.25'));
      expect(Rational.parse('7.25').toNearest(increment, mode: RoundingMode.truncate), Rational.parse('7.25'));
    });

    test('Values just below and above rounding thresholds', () {
      expect(Rational.parse('7.4999999999').toNearest(increment, mode: RoundingMode.halfUp), Rational.parse('7.5'));
      expect(Rational.parse('7.5000000001').toNearest(increment, mode: RoundingMode.halfUp), Rational.parse('7.5'));
    });

    test('Large numbers rounding', () {
      expect(Rational.parse('9999999.49').toNearest(increment, mode: RoundingMode.floor), Rational.parse('9999999.25'));
      expect(Rational.parse('9999999.51').toNearest(increment, mode: RoundingMode.ceil), Rational.parse('9999999.75'));
    });

    test('Very small numbers rounding to nearest fraction', () {
      expect(Rational.parse('0.00000001').toNearest(increment, mode: RoundingMode.floor), Rational.parse('0.00'));
      expect(Rational.parse('0.00000001').toNearest(increment, mode: RoundingMode.ceil), Rational.parse('0.25'));
    });

    test('toNearest - Zero and small increments', () {
      final Rational tinyIncrement = Rational.parse('0.0000000001');
      expect(Rational.zero.toNearest(tinyIncrement, mode: RoundingMode.halfUp), Rational.zero);
      expect(Rational.parse('0.00000000005').toNearest(tinyIncrement, mode: RoundingMode.halfUp), tinyIncrement); // Or zero, depending on desired rounding
      expect(Rational.parse('-0.00000000005').toNearest(tinyIncrement, mode: RoundingMode.halfUp), -tinyIncrement); // Or zero
    });

    test('Zero increment throws ArgumentError', () {
      expect(() => Rational.fromInt(5).toNearest(Rational.zero), throwsA(isA<ArgumentError>()));
    });

    test('Zero value toNearest', () {
      expect(Rational.zero.toNearest(increment, mode: RoundingMode.halfUp), Rational.zero);
    });

    test('Negative increments rounding', () {
      expect(Rational.parse('-7.24').toNearest(-increment, mode: RoundingMode.floor), Rational.parse('-7.00'));
      expect(Rational.parse('-7.26').toNearest(-increment, mode: RoundingMode.ceil), Rational.parse('-7.5'));
    });

    test('Large increments rounding', () {
      final Rational largeIncrement = Rational.fromInt(10);
      expect(Rational.parse('12').toNearest(largeIncrement, mode: RoundingMode.floor), Rational.fromInt(10));
      expect(Rational.parse('12').toNearest(largeIncrement, mode: RoundingMode.ceil), Rational.fromInt(20));
    });

    test('Exact zero', () {
      expect(Rational.zero.toNearest(increment, mode: RoundingMode.halfUp), Rational.zero);
    });
  });

  group('BigInt.roundedDiv()', () {
    test('Floor rounding', () {
      expect(BigInt.from(7).roundedDiv(BigInt.from(2), RoundingMode.floor), BigInt.from(3));
      expect(BigInt.from(-7).roundedDiv(BigInt.from(2), RoundingMode.floor), BigInt.from(-4));
    });

    test('Ceil rounding', () {
      expect(BigInt.from(7).roundedDiv(BigInt.from(2), RoundingMode.ceil), BigInt.from(4));
      expect(BigInt.from(-7).roundedDiv(BigInt.from(2), RoundingMode.ceil), BigInt.from(-3));
    });

    test('Truncate rounding', () {
      expect(BigInt.from(7).roundedDiv(BigInt.from(2), RoundingMode.truncate), BigInt.from(3));
      expect(BigInt.from(-7).roundedDiv(BigInt.from(2), RoundingMode.truncate), BigInt.from(-3));
    });

    test('Up rounding (away from zero)', () {
      expect(BigInt.from(7).roundedDiv(BigInt.from(2), RoundingMode.up), BigInt.from(4));
      expect(BigInt.from(-7).roundedDiv(BigInt.from(2), RoundingMode.up), BigInt.from(-4));
    });

    test('Half-up rounding', () {
      expect(BigInt.from(7).roundedDiv(BigInt.from(2), RoundingMode.halfUp), BigInt.from(4));
      expect(BigInt.from(-7).roundedDiv(BigInt.from(2), RoundingMode.halfUp), BigInt.from(-4));
    });

    test('Half-down rounding', () {
      expect(BigInt.from(7).roundedDiv(BigInt.from(2), RoundingMode.halfDown), BigInt.from(3));
      expect(BigInt.from(-7).roundedDiv(BigInt.from(2), RoundingMode.halfDown), BigInt.from(-3));
    });

    test('Half-even rounding', () {
      expect(BigInt.from(7).roundedDiv(BigInt.from(2), RoundingMode.halfEven), BigInt.from(4));
      expect(BigInt.from(5).roundedDiv(BigInt.from(2), RoundingMode.halfEven), BigInt.from(2));
      expect(BigInt.from(6).roundedDiv(BigInt.from(2), RoundingMode.halfEven), BigInt.from(3));
    });

    test('Large BigInt division rounding', () {
      expect(BigInt.parse('1000000000000000000').roundedDiv(BigInt.from(3), RoundingMode.halfUp), BigInt.parse('333333333333333333'));
    });

    test('Zero denominator throws exception', () {
      expect(() => BigInt.from(10).roundedDiv(BigInt.zero, RoundingMode.halfUp), throwsA(isA<ArgumentError>()));
    });

    test('Zero numerator returns zero', () {
      expect(BigInt.zero.roundedDiv(BigInt.from(5), RoundingMode.halfUp), BigInt.zero);
    });

    test('Negative division', () {
      expect(BigInt.from(-7).roundedDiv(BigInt.from(2), RoundingMode.halfUp), BigInt.from(-4));
      expect(BigInt.from(7).roundedDiv(BigInt.from(-2), RoundingMode.halfUp), BigInt.from(-4));
    });

    test('Exact division remains unchanged', () {
      expect(BigInt.from(10).roundedDiv(BigInt.from(2), RoundingMode.halfUp), BigInt.from(5));
      expect(BigInt.from(-10).roundedDiv(BigInt.from(2), RoundingMode.halfUp), BigInt.from(-5));
    });
  });

  group('RationalCommonRoundingExtension', () {
    test('toDecimalPlace', () {
      expect(Rational.parse('1.2345').toDecimalPlace(2), Rational.parse('1.23'));
      expect(Rational.parse('1.2345').toDecimalPlace(3), Rational.parse('1.235'));
      expect(Rational.parse('1.2345').toDecimalPlace(0), Rational.parse('1'));
      expect(Rational.parse('1.2345').toDecimalPlace(2, mode: RoundingMode.ceil), Rational.parse('1.24'));
      expect(() => Rational.parse('1.2345').toDecimalPlace(-1), throwsA(isA<ArgumentError>()));
    });

    test('toCents', () {
      expect(Rational.parse('1.2345').toCents(), Rational.parse('1.23'));
      expect(Rational.parse('1.235').toCents(), Rational.parse('1.24'));
      expect(Rational.parse('1.2345').toCents(RoundingMode.floor), Rational.parse('1.23'));
    });

    test('toNearestHalf', () {
      expect(Rational.parse('1.24').toNearestHalf(), Rational.fromInt(1));
      expect(Rational.parse('1.25').toNearestHalf(), Rational.fromInt(3, 2));
      expect(Rational.parse('1.26').toNearestHalf(), Rational.fromInt(3, 2));
      expect(Rational.parse('1.74').toNearestHalf(), Rational.fromInt(3, 2));
      expect(Rational.parse('1.75').toNearestHalf(), Rational.fromInt(2));
      expect(Rational.parse('1.76').toNearestHalf(), Rational.fromInt(2));
    });

    test('toNearestThird', () {
      expect(Rational.parse('1.32').toNearestThird(), Rational.fromInt(4, 3));
      expect(Rational.parse('1.34').toNearestThird(), Rational.fromInt(4, 3));
      expect(Rational.parse('1.65').toNearestThird(), Rational.fromInt(5, 3));
      expect(Rational.parse('1.67').toNearestThird(), Rational.fromInt(5, 3));
    });

    test('toNearestQuarter', () {
      expect(Rational.parse('1.24').toNearestQuarter(), Rational.fromInt(5, 4));
      expect(Rational.parse('1.26').toNearestQuarter(), Rational.fromInt(5, 4));
      expect(Rational.parse('1.37').toNearestQuarter(), Rational.fromInt(5, 4));
      expect(Rational.parse('1.38').toNearestQuarter(), Rational.fromInt(3, 2));
    });
  });

  group('Rational Formatting Extensions', () {
    test('toCurrency', () {
      // Test currencies with decimal coins
      expect(Rational.parse('19.99').toCurrency(locale: 'en_US'), '\$19.99');
      expect(Rational.parse('19.994').toCurrency(locale: 'en_US'), '\$19.99');
      expect(Rational.parse('19.99').toCurrency(locale: 'fr_FR'), '19,99\u00A0€');

      // Yen don't have "cents", so this should round to ¥20
      expect(Rational.parse('19.99').toCurrency(locale: 'ja_JP'), '¥20');

      // Test with currencyName (we're explicitly overriding the locale)
      expect(Rational.parse('19.99').toCurrency(locale: 'ja_JP', currencyName: 'USD'), '\$19.99');

      // Test with Kuwaiti Dinar (KWD) - 3 decimal places and right-to-left
      expect(Rational.parse('19.999').toCurrency(locale: 'ar_KW', decimalDigits: 3), '\u200F19.999\u00A0E£');

      // Test with zero value
      expect(Rational.zero.toCurrency(locale: 'en_US'), '\$0.00');

      // Test with negative value
      expect(Rational.parse('-19.99').toCurrency(locale: 'en_US'), '-\$19.99');
      expect(() => Rational.parse('19.99').toCurrency(locale: 'bad_locale'), throwsA(isA<ArgumentError>()));
    });

    test('toPercentage', () {
      expect(Rational.fromInt(1, 3).toPercentage(2), '33.33%');
      expect(Rational.fromInt(1, 3).toPercentage(0), '33%');
      expect(Rational.fromInt(1, 3).toPercentage(2, mode: RoundingMode.ceil), '33.34%');
      expect(Rational.fromInt(1, 3).toPercentage(2, locale: 'fr_FR'), '33,33%');
    });
  });

  group('BigInt MultipleOf Extension', () {
    test('isMultipleOf', () {
      expect(BigInt.from(10).isMultipleOf(BigInt.from(5)), true);
      expect(BigInt.from(11).isMultipleOf(BigInt.from(5)), false);
      expect(BigInt.from(10).isMultipleOf(BigInt.zero), false);
      expect(BigInt.zero.isMultipleOf(BigInt.zero), true);
    });
  });

  group('Int MultipleOf Extension', () {
    test('isMultipleOf', () {
      expect(10.isMultipleOf(5), true);
      expect(11.isMultipleOf(5), false);
      expect(10.isMultipleOf(0), false);
      expect(0.isMultipleOf(0), true);
    });
  });
}
