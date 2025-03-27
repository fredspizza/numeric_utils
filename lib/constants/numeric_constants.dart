// Copyright 2025 Brian Erst
// SPDX-License-Identifier: MIT

import 'package:rational/rational.dart';

/// Provides useful constants for the `int` type
class IntConstants {
  /// The maximum finite value for an `int` (on native platforms)
  /// On web platforms, int values are represented as 64-bit floating-point numbers.
  /// Bitwise operations on the web operate on 32 bit integers.
  static const int maxFinite = 0x7FFFFFFFFFFFFFFF;

  /// The minimum finite value for an `int` (on native platforms)
  /// On web platforms, int values are represented as 64-bit floating-point numbers.
  /// Bitwise operations on the web operate on 32 bit integers.
  static const int minFinite = -0x8000000000000000;

  /// Represents 2^8 (256), a byte.
  static const int byte = 256;

  /// Represents 2^16 (65536), a word.
  static const int word = 65536;
}

/// Provides useful constants for the `Rational` type
final class RationalConstants {
  // Large Numbers
  /// Represents one trillion (1,000,000,000,000)
  static final Rational trillion = Rational.fromInt(1000000000000, 1);

  /// Represents one billion (1,000,000,000)
  static final Rational billion = Rational.fromInt(1000000000, 1);

  /// Represents one million (1,000,000)
  static final Rational million = Rational.fromInt(1000000, 1);

  /// Represents one thousand (1,000)
  static final Rational thousand = Rational.fromInt(1000, 1);

  /// Represents one hundred (100)
  static final Rational hundred = Rational.fromInt(100, 1);

  // Small Integers
  /// Represents one dozen (12)
  static final Rational dozen = Rational.fromInt(12, 1);

  /// Represents twelve (12)
  static final Rational twelve = dozen;

  /// Represents ten (10)
  static final Rational ten = Rational.fromInt(10, 1);

  /// Represents nine (9)
  static final Rational nine = Rational.fromInt(9, 1);

  /// Represents eight (8)
  static final Rational eight = Rational.fromInt(8, 1);

  /// Represents seven (7)
  static final Rational seven = Rational.fromInt(7, 1);

  /// Represents six (6)
  static final Rational six = Rational.fromInt(6, 1);

  /// Represents five (5)
  static final Rational five = Rational.fromInt(5, 1);

  /// Represents four (4)
  static final Rational four = Rational.fromInt(4, 1);

  /// Represents three (3)
  static final Rational three = Rational.fromInt(3, 1);

  /// Represents two (2)
  static final Rational two = Rational.fromInt(2, 1);

  // Fractions
  /// Represents three quarters (3/4)
  static final Rational threeQuarters = Rational.fromInt(3, 4);

  /// Represents two thirds (2/3)
  static final Rational twoThirds = Rational.fromInt(2, 3);

  /// Represents one half (1/2)
  static final Rational half = Rational.fromInt(1, 2);

  /// Represents one third (1/3)
  static final Rational third = Rational.fromInt(1, 3);

  /// Represents one quarter (1/4)
  static final Rational quarter = Rational.fromInt(1, 4);

  /// Represents one fifth (1/5)
  static final Rational fifth = Rational.fromInt(1, 5);

  /// Represents one sixth (1/6)
  static final Rational sixth = Rational.fromInt(1, 6);

  /// Represents one seventh (1/7)
  static final Rational seventh = Rational.fromInt(1, 7);

  /// Represents one eighth (1/8)
  static final Rational eighth = Rational.fromInt(1, 8);

  /// Represents one ninth (1/9)
  static final Rational ninth = Rational.fromInt(1, 9);

  /// Represents one tenth (1/10)
  static final Rational tenth = Rational.fromInt(1, 10);

  /// Represents one twelfth (1/12)
  static final Rational twelfth = Rational.fromInt(1, 12);

  /// Represents one sixteenth (1/16)
  static final Rational sixteenth = Rational.fromInt(1, 16);

  /// Represents one twentieth (1/20)
  static final Rational twentieth = Rational.fromInt(1, 20);

  /// Represents one twentieth (1/20)
  static final Rational twentyFifth = Rational.fromInt(1, 25);

  /// Represents one hundredth (1/100)
  static final Rational hundredth = Rational.fromInt(1, 100);

  /// Represents one thousandth (1/1,000)
  static final Rational thousandth = Rational.fromInt(1, 1000);

  /// Represents one ten-thousandth (1/10,000)
  static final Rational tenThousandth = Rational.fromInt(1, 10000);

  /// Represents one hundred-thousandth (1/100,000)
  static final Rational hundredThousandth = Rational.fromInt(1, 100000);

  /// Represents one millionth (1/1,000,000)
  static final Rational millionth = Rational.fromInt(1, 1000000);

  /// Represents one billionth (1/1,000,000,000)
  static final Rational billionth = Rational.fromInt(1, 1000000000);

  // Time/Measurement Related
  /// Represents one hour as a fraction of a day (1/24).
  static final Rational hourFractionOfDay = Rational.fromInt(1, 24);

  /// Represents one minute as a fraction of an hour (1/60).
  static final Rational minuteFractionOfHour = Rational.fromInt(1, 60);

  /// Represents one minute as a fraction of a day (1/1440).
  static final Rational minuteFractionOfDay = Rational.fromInt(1, 1440);

  /// Represents one second as a fraction of an hour (1/3600)
  static final Rational secondFractionOfHour = Rational.fromInt(1, 3600);

  /// Represents one second as a fraction of a day (1/86400).
  static final Rational secondFractionOfDay = Rational.fromInt(1, 86400);
}

/// Provides useful constants for the `BigInt` type
final class BigIntConstants {
  /// Represents one googol (10^100)
  static final BigInt googol = BigInt.from(10).pow(100);

  /// Represents one nonillion (1,000,000,000,000,000,000,000,000,000,000)
  static final BigInt nonillion = BigInt.from(10).pow(30);

  /// Represents one octillion (1,000,000,000,000,000,000,000,000,000)
  static final BigInt octillion = BigInt.from(10).pow(27);

  /// Represents one septillion (1,000,000,000,000,000,000,000,000)
  static final BigInt septillion = BigInt.from(10).pow(24);

  /// Represents one sextillion (1,000,000,000,000,000,000,000)
  static final BigInt sextillion = BigInt.from(10).pow(21);

  /// Represents one quintillion (1,000,000,000,000,000,000)
  static final BigInt quintillion = BigInt.from(10).pow(18);

  /// Represents one quadrillion (1,000,000,000,000,000)
  static final BigInt quadrillion = BigInt.from(10).pow(15);

  /// Represents one trillion (1,000,000,000,000)
  static final BigInt trillion = BigInt.from(10).pow(12);

  /// Represents one billion (1,000,000,000)
  static final BigInt billion = BigInt.from(10).pow(9);

  /// Represents one million (1,000,000)
  static final BigInt million = BigInt.from(10).pow(6);

  /// Represents one thousand (1,000)
  static final BigInt thousand = BigInt.from(1000);

  /// Represents one hundred (100)
  static final BigInt hundred = BigInt.from(100);

  /// Represents a dozen (12)
  static final BigInt dozen = BigInt.from(12);

  /// Represents twelve (12)
  static final BigInt twelve = dozen;

  /// Represents ten (10)
  static final BigInt ten = BigInt.from(10);

  /// Represents nine (9)
  static final BigInt nine = BigInt.from(9);

  /// Represents eight (8)
  static final BigInt eight = BigInt.from(8);

  /// Represents seven (7)
  static final BigInt seven = BigInt.from(7);

  /// Represents six (6)
  static final BigInt six = BigInt.from(6);

  /// Represents five (5)
  static final BigInt five = BigInt.from(5);

  /// Represents four (4)
  static final BigInt four = BigInt.from(4);

  /// Represents three (3)
  static final BigInt three = BigInt.from(3);

  /// Represents two (2)
  static final BigInt two = BigInt.from(2);

  // Common Computer Science Terms (Powers of 2)
  /// Represents 2^8 (256), a byte.
  static final BigInt byte = BigInt.from(2).pow(8);

  /// Represents 2^16 (65536), a word.
  static final BigInt word = BigInt.from(2).pow(16);

  /// Represents 2^32, a double word.
  static final BigInt doubleWord = BigInt.from(2).pow(32);

  /// Represents 2^64, a quad word.
  static final BigInt quadWord = BigInt.from(2).pow(64);

  /// Represents 2^10 (1024), a kilobyte (KiB)
  static final BigInt kilobyte = BigInt.from(2).pow(10);

  /// Represents 2^20 (1,048,576), a megabyte (MiB)
  static final BigInt megabyte = BigInt.from(2).pow(20);

  /// Represents 2^30 (1,073,741,824), a gigabyte (GiB)
  static final BigInt gigabyte = BigInt.from(2).pow(30);

  /// Represents 2^40, a terabyte (TiB)
  static final BigInt terabyte = BigInt.from(2).pow(40);

  /// Represents 2^50, a petabyte (PiB)
  static final BigInt petabyte = BigInt.from(2).pow(50);

  /// Represents 2^60, an exabyte (EiB)
  static final BigInt exabyte = BigInt.from(2).pow(60);

  /// Represents 2^70, a zettabyte (ZiB)
  static final BigInt zettabyte = BigInt.from(2).pow(70);

  /// Represents 2^80, a yottabyte (YiB)
  static final BigInt yottabyte = BigInt.from(2).pow(80);
}
