## 0.1.1

- Downgraded intl to 0.19.0 due to Flutter pinning

## 0.1.0

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
