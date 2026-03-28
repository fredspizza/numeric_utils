# numeric_utils — Architecture Overview

## What this package is
- Dart package that adds *small, practical* numeric helpers, mainly for exact arithmetic via `Rational` (from `package:rational`) plus some `int`, `double`, and `BigInt` utilities.
- Two buckets:
  - **Constants** (common magnitudes/fractions/percent/time/computer sizes)
  - **Extensions** (rounding, formatting, parsing, validation/comparison helpers)

## Where the code is (no spelunking needed)
- Public entrypoint (exports everything): `lib/numeric_utils.dart`
- Constants: `lib/constants/numeric_constants.dart`
- All extensions/utilities (main file): `lib/extensions/numeric_extensions.dart`
- That’s the whole implementation (only 3 Dart files).

## API map (by capability)
- **Rounding**
  - `enum RoundingMode`
  - `Rational.rounded([mode])`
  - `Rational.toNearest(increment, {mode})`
  - Convenience: `toNearestDecimal`, `toCents`, `toNearestHalf|Third|Quarter`
  - `BigInt.roundedDiv(denominator, mode)`
  - `Rational.toInt([mode])`
- **Formatting** (uses `package:intl`; formats via `toDouble()` for display)
  - `Rational.toDecimalString(decimalPlaces, {mode, stripTrailingZeros, locale, pattern})`
  - `Rational.toPercentageString(maxDecimals, {minDecimals, mode, locale, asRatio})`
  - `Rational.toCurrencyString({locale, currencyName, decimalDigits})`
- **Parsing / persistence seam**
  - `RationalParsing.fromString(...)` supports fractions (`"3/4"`), mixed (`"1 3/4"`), ints/decimals/sci (`"1e-3"`)
  - `RationalParsing.tryFromString(...)` (null on invalid)
  - `RationalCodec.encode/decode/tryDecode` for canonical `Rational` ↔ `String` at storage boundaries
- **Validation / comparisons**
  - Multiples: `isMultipleOf` on `int`, `double`, `BigInt`, `Rational`
  - Ranges: `isInRange` on `int`, `double`, `BigInt`, `Rational`
  - Fixed tolerance: `isWithinTolerance` on `int`, `double`, `BigInt`, `Rational`
  - Robust “close to”: `double.isCloseTo(...)`, `Rational.isCloseTo(...)` (relative + absolute tolerances)
- **Constants**
  - `IntConstants` (native max/min finite, byte/word)
  - `RationalConstants` (fractions, percent ratios, time fractions, magnitudes)
  - `BigIntConstants` (large magnitudes + powers of ten)

## Fast “jump to code” commands
- Find the exact extension/class: `rg -n "extension .*Rational|class RationalParsing|class RationalCodec|enum RoundingMode" lib/extensions/numeric_extensions.dart`
- Find constants: `rg -n "class IntConstants|class BigIntConstants|class RationalConstants" lib/constants/numeric_constants.dart`

