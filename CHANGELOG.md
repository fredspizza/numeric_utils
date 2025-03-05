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
