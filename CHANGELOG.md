## [0.2.2] - 2025-03-27

### Upgraded
- `RationalFormattingExtension.toPercentage`: Now takes an optional parameter `asRatio` to determine whether to 
  treat the input as a ratio value (e.g., 33/100 or 0.33) or a value between 0 and 100 (e.g., 33 out of 100).
  Defaults to `true` for backward compatibility.

## [0.2.1] - 2025-03-26

### Added
- `RationalParsing.tryFromString`: A version of `RationalParsing.fromString` that returns null if parsing fails.

## [0.2.0] - 2025-03-05

### Added
- `RationalParsing.fromString`: A new utility method that parses strings into `Rational` objects, supporting the 
  output of `Rational.toString` (e.g., fractions like "3/4", mixed numbers like "1 3/4") as well as formats parsable
  by `Rational.parse` (e.g., integers, decimals, scientific notation). Enables round-trip serialization for JSON 
  and other formats.
 
## [0.1.1] - 2025-02-23

### Fixed
- Downgraded intl to 0.19.0 due to Flutter pinning

## [0.1.0] - 2025-02-23

- Initial version of numeric_utils.
- Features:
  - Added `RationalRoundingExtension` with various rounding methods (`rounded`, `toNearest`, etc.).
    - Added `RoundingMode` enum.
  - Added `BigIntRoundedDivisionExtension` for rounded division of BigInts.
  - Added `RationalFormattingExtension` with `toDecimalPlaces`, `toCurrency` and `toPercentage` methods.
  - Added `RationalCommonRoundingExtension` with `toDecimalPlace`, `toCents`, `toNearestHalf`, `toNearestThird`, and `toNearestQuarter` methods.
  - Added `BigIntMultipleOfExtension` and `IntMultipleOfExtension` for `isMultipleOf` methods.
- Constants:
    - Added `RationalConstants` with common rational values as well as `IntConstants` and `BigIntConstants`
