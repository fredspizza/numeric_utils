### [0.4.0] - TBD

#### Breaking Changes

- **Renamed rounding method** for clarity and consistency:
  - `RationalCommonRoundingExtension.toDecimalPlace(int places)` → `toNearestDecimal(int decimalPlaces)`
  - This aligns with the naming pattern of `toNearestHalf()`, `toNearestThird()`, `toNearestQuarter()`, etc.

- **Renamed formatting method** for clarity and consistency:
  - `RationalFormattingExtension.toDecimalPlaces(int places)` → `toDecimal(int decimalPlaces)`
  - This aligns with the naming pattern of `toPercentage()` and `toCurrency()`

- **`isMultipleOf()` behavior change** for all numeric types (`int`, `double`, `BigInt`, `Rational`):
  - Now throws `ArgumentError` when checking if a number is a multiple of zero
  - Previously returned a boolean value (implementation-dependent)

#### Added

- **`RationalPercentageExtension`**: New extension providing percentage calculation utilities:
  - `percentageOf(Rational total)`: Calculates what percentage this value represents of the total
  - `percentChangeOn(Rational baseValue)`: Applies this value as a percentage change to the base value
  - `percentDifferenceFrom(Rational other)`: Calculates the percentage difference between two values

- **New `RationalConstants`**:
  - `twoFifths` (2/5)
  - `threeFifths` (3/5)
  - `fourFifths` (4/5)
  - `onePercent` (1/100 or 0.01)
  - `fivePercent` (1/20 or 0.05)
  - `tenPercent` (1/10 or 0.1)
  - `twentyFivePercent` (1/4 or 0.25)
  - `fiftyPercent` (1/2 or 0.5)

#### Fixed

- Fixed documentation typo in `RationalConstants.twentyFifth` (was incorrectly labeled as "twentieth")

#### Documentation

- Added library-level documentation to `numeric_constants.dart` explaining runtime constant computation
- Added library-level documentation to `numeric_extensions.dart` describing key features
- Added **Performance Notes** section to README explaining Rational vs. double trade-offs
- Added **Troubleshooting** section to README with common issues and solutions
- Added comprehensive **Migration Guide** to README for v0.4.0 and v0.3.0
- Added `financial_calculations.dart` example demonstrating real-world financial use cases

### [0.3.1] - 2025-05-17

#### Modified

- `RationalParsing.tryFromString` now handles `null` inputs and returns `null` instead of throwing an exception.

### [0.3.0] - 2025-04-02

#### Breaking change

- `Rational.toPercentage` was modified to remove the `places` parameter and replace it with `maxDecimals` 
and `minDecimals`. `maxDecimals` is required, `minDecimals` is defaulted to 0.

### [0.2.3] - 2025-03-29

#### Added

- `xxxInRangeExtension`: New extensions that provide an `isInRange` method to check if a value is within a specified 
  range (for `int`, `BigInt`, `double` and `Rational`).
- `xxxToleranceExtension`: New extensions that provide `isWithinTolerance` methods to check if a value is within a 
  specified tolerance of another value (for `int`, `BigInt`, `double` and `Rational`).
- `DoubleToleranceExtension`: The double version of `xxxToleranceExtension` also provides an `isCloseTo` method to check 
  if a double value is close to another value, considering floating-point inaccuracies.
- `xxxMultipleOfExtension`: Added `double` and `Rational` versions of `isMultipleOf` methods.

### [0.2.2] - 2025-03-27

#### Upgraded
- `RationalFormattingExtension.toPercentage`: Now takes an optional parameter `asRatio` to determine whether to 
  treat the input as a ratio value (e.g., 33/100 or 0.33) or a value between 0 and 100 (e.g., 33 out of 100).
  Defaults to `true` for backward compatibility.

### [0.2.1] - 2025-03-26

#### Added
- `RationalParsing.tryFromString`: A version of `RationalParsing.fromString` that returns null if parsing fails.

### [0.2.0] - 2025-03-05

#### Added
- `RationalParsing.fromString`: A new utility method that parses strings into `Rational` objects, supporting the 
  output of `Rational.toString` (e.g., fractions like "3/4", mixed numbers like "1 3/4") as well as formats parsable
  by `Rational.parse` (e.g., integers, decimals, scientific notation). Enables round-trip serialization for JSON 
  and other formats.
 
### [0.1.1] - 2025-02-23

#### Fixed
- Downgraded intl to 0.19.0 due to Flutter pinning

### [0.1.0] - 2025-02-23

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
