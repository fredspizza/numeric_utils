# numeric_utils

A Dart library providing a collection of useful numeric constants and extension methods to enhance numerical operations in Dart, particularly for `Rational`, `BigInt`, and `int` types.

## Features

- **Numeric Constants:**
  - Provides comprehensive constants for `int`, `Rational`, and `BigInt` types, including:
    - Common powers of two (`byte`, `word`, `kilobyte`, `megabyte`, etc.)
    - Large number denominations (`thousand`, `million`, `billion`, `trillion`, etc.)
    - Fractions (`half`, `third`, `quarter`, etc.)
    - Time-related fractions (`hourFractionOfDay`, `minuteFractionOfHour`, etc.)
  - **Rational Rounding Extensions:**
    - Extensive rounding capabilities for `Rational` numbers with various `RoundingMode` options: `floor`, `ceil`, `truncate`, `up`, `halfUp`, `halfDown`, and `halfEven`.
    - Rounding to the nearest multiple of a specified `Rational` increment.
    - Convenience rounding to decimal places, cents, halves, thirds, and quarters.
  - **Rational Formatting Extensions:**
    - Localized formatting of `Rational` numbers as decimal strings with control over decimal places, rounding modes, and trailing zero stripping.
    - Localized currency formatting with locale and currency symbol/name customization.
    - Localized percentage formatting.
  - **BigInt Rounded Division:**
    - Extension method for `BigInt` to perform division with various rounding modes.
  - **MultipleOf Extensions:**
    - Extension methods for `int`, `double`, `BigInt` and `Rational` to easily check if a number is a multiple of another.
  - **isInRange Extensions:**
    - Extension methods for `int`, `double`, `BigInt` and `Rational` to check if a number is within a specified range.
  - **Tolerance Extensions:**
    - Extension methods for `int`, `double`, `BigInt` and `Rational` to check if a number is within a specified tolerance 
      of another value.
    - `isCloseTo` method for `double` to check if a double value is close to another value, considering floating-point inaccuracies.
  - **Rational Parsing:**
    - `RationalParsing.fromString` parses strings into `Rational` objects, supporting round-trip compatibility with `Rational.toString`.
    - Handles mixed numbers (e.g., `"1 3/4"`), simple fractions (e.g., `"3/4"`), integers, decimals, and scientific notation with flexible whitespace.

## Getting Started

Add `numeric_utils` to your `pubspec.yaml` file:

```YAML
dependencies:
  numeric_utils: ^<latest_version>  Replace with the latest version from pub.dev
  rational: ^<latest_version>       Ensure you have the rational package as well
  intl: ^<latest_version>           and the intl package for formatting
```

Then, run `dart pub get` to install the dependencies.

## Usage

Import the library in your Dart code:

```Dart
import 'package:numeric_utils/numeric_utils.dart'; // Or individual files if preferred
import 'package:rational/rational.dart';
```

**Example - Using Constants:**

```Dart
import 'package:numeric_utils/numeric_constants.dart';

void main() {
  print('One million as Rational: ${RationalConstants.million}');
  print('Kilobyte as BigInt: ${BigIntConstants.kilobyte}');
  print('Max finite int: ${IntConstants.maxFinite}');
}
```

**Example - Rational Rounding:**

```Dart
import 'package:numeric_utils/extensions/numeric_extensions.dart';
import 'package:rational/rational.dart';
import 'package:numeric_utils/enums/rounding_mode.dart';

void main() {
final value = Rational.parse("7.567");
  print('Original value: $value');
  print('Rounded to floor: ${value.rounded(RoundingMode.floor)}');
  print('Rounded to 2 decimal places: ${value.toDecimalString(2)}');
  print('Rounded to nearest quarter: ${value.toNearestQuarter()}');
}
```

**Example - Currency Formatting:**

```Dart
import 'package:numeric_utils/extensions/numeric_extensions.dart';
import 'package:rational/rational.dart';

void main() {
  final price = Rational.parse("19.995");
  print('Price in USD: ${price.toCurrencyString(locale: 'en_US')}');
  print('Price in EUR: ${price.toCurrencyString(locale: 'fr_FR')}');
}
```

**Example - Rational Parsing:**

```Dart
import 'package:numeric_utils/numeric_utils.dart';
import 'package:rational/rational.dart';

void main() {
  // fromString - throws FormatException on invalid input
  final mixedNumber = RationalParsing.fromString(" 1 3/4 ");
  print('Mixed number: $mixedNumber'); // Outputs: 7/4

  final fraction = RationalParsing.fromString(" - 3/4 ");
  print('Fraction: $fraction'); // Outputs: -3/4

  final decimal = RationalParsing.fromString("0.75");
  print('Decimal: $decimal'); // Outputs: 3/4

  // Round-trip support for toString()
  final roundTrip = RationalParsing.fromString(Rational.parse("0.75").toString());
  print('Round trip: $roundTrip'); // Outputs: 3/4

  // tryFromString - returns null on invalid input instead of throwing
  final valid = RationalParsing.tryFromString("3/4");
  print('Valid: $valid'); // Outputs: 3/4

  final invalid = RationalParsing.tryFromString("invalid");
  print('Invalid: $invalid'); // Outputs: null

  final nullInput = RationalParsing.tryFromString(null);
  print('Null input: $nullInput'); // Outputs: null
}
```

## Examples Directory

For more detailed examples, please refer to the example/ directory in the repository. It includes examples demonstrating:

- **basic_usage.dart:** Core features of the library.
- **common_use_case.dart:** Practical examples like rounding prices and measurements.
- **edge_cases.dart:** Handling edge cases and potential errors.
- **advanced_features.dart:** Showcasing advanced formatting and halfEven rounding (where applicable).

To run the examples, navigate to the `example/` directory and follow the instructions in its `README.md`.

## Performance Notes

**Rational vs. Double Performance:**
- `Rational` operations provide exact arithmetic but are **slower than `double`** due to the underlying BigInt calculations
- For high-performance numeric code where floating-point precision is acceptable, consider using `double` with `isCloseTo()` for comparisons
- `Rational` is ideal for financial calculations, measurements, and applications where exact decimal representation is critical

**Constants:**
- All constants in this library are computed at **runtime** (not compile-time const) due to `Rational`'s constructor limitations
- Constants are computed on first access and cached thereafter
- This has minimal performance impact for typical usage patterns

**Best Practices:**
- Use `Rational` for money, percentages, and fractions where precision matters
- Use `double` for scientific calculations, graphics, and performance-critical loops
- Cache frequently-used Rational values rather than parsing strings repeatedly
- Prefer `RationalParsing.tryFromString()` when dealing with user input to avoid exception overhead

## Troubleshooting

### Common Issues

**`FormatException` when parsing fractions**
- **Problem:** You're using `Rational.parse()` which doesn't support fractions like "3/4"
- **Solution:** Use `RationalParsing.fromString()` instead, which supports fractions, mixed numbers, decimals, and scientific notation
  ```dart
  // ❌ This throws FormatException
  Rational.parse("3/4");

  // ✅ This works
  RationalParsing.fromString("3/4");
  ```

**Currency formatting shows wrong symbol**
- **Problem:** Invalid or incomplete locale string
- **Solution:** Use full locale format: `'en_US'` not `'US'`, `'fr_FR'` not `'FR'`
  ```dart
  // ❌ Wrong
  value.toCurrencyString(locale: 'US');

  // ✅ Correct
  value.toCurrencyString(locale: 'en_US');
  ```

**Method not found: `toDecimalPlace` or `toDecimalPlaces`**
- **Problem:** Methods were renamed for clarity and consistency
- **Solution:** Use `toNearestDecimal()` for rounding (returns Rational) or `toDecimalString()` for formatting (returns String)
  ```dart
  // ❌ Old (pre-0.4.0) - for rounding
  value.toDecimalPlace(2);  // Returns Rational

  // ✅ New (0.4.0+) - for rounding
  value.toNearestDecimal(2);  // Returns Rational

  // ✅ New (0.4.0+) - for formatting
  value.toDecimalString(2, locale: 'en_US');  // Returns String "1.23"
  ```

## Migration Guide

### Migrating to v0.4.2

**Breaking Changes:** All formatting methods renamed to avoid conflicts with `decimal` package
- **`toDecimal()` → `toDecimalString()`**
  - **Action:** Rename all calls from `toDecimal()` to `toDecimalString()`
- **`toPercentage()` → `toPercentageString()`**
  - **Action:** Rename all calls from `toPercentage()` to `toPercentageString()`
- **`toCurrency()` → `toCurrencyString()`**
  - **Action:** Rename all calls from `toCurrency()` to `toCurrencyString()`

All three methods return formatted strings, and the new names make this explicit while avoiding naming conflicts.

### Migrating to v0.4.0

**Breaking Changes:** Methods renamed for clarity and consistency with naming patterns
- **Rounding method:**
  - **Old:** `toDecimalPlace(int places)` - returned Rational
  - **New:** `toNearestDecimal(int decimalPlaces)` - returns Rational
  - **Action:** Rename to `toNearestDecimal` to match `toNearestHalf()`, `toNearestThird()`, etc.

- **Formatting method - Changed again in 0.4.2 so the below reflects that change:**
  - **Old:** `toDecimalPlaces(int places)` - returned String
  - **New:** `toDecimalString(int decimalPlaces)` - returns String
  - **Action:** Rename to `toDecimalString` to match `toPercentageString()` and `toCurrencyString()`

**New Features:**
- `isMultipleOf()` now throws `ArgumentError` when checking against zero (previously returned boolean)
- Added `RationalPercentageExtension` with `percentageOf()`, `percentChangeOn()`, and `percentDifferenceFrom()`
- New constants: `twoFifths`, `threeFifths`, `fourFifths`, `onePercent`, `fivePercent`, `tenPercent`, `twentyFivePercent`, `fiftyPercent`

### Migrating to v0.3.0

**Breaking Change:** `toPercentageString` API changed
- **Old:** `value.toPercentageString(2, forcePlaces: true)`
- **New:** `value.toPercentageString(2, minDecimals: 2)`
- **Action:** Replace `forcePlaces` parameter with `minDecimals`

**New Feature:** `tryFromString` now accepts null
- Previously threw on null input
- Now returns `null` for null inputs (added in v0.3.1)

## API stability
As numeric_utils is still in its infancy, we may introduce breaking changes to the API at any time without notice.
We will attempt to keep backward compatibility as much as possible. Once we have a stable 1.0.0 version, breaking
changes will require a version bump.

## Contributing

We welcome contributions to the `numeric_utils` library!  Whether you're fixing a bug, adding a new feature, improving documentation, or suggesting ideas, your help is appreciated.

### How to Contribute

Here are the general steps for contributing to this project:

1.  **Fork the repository** on GitHub.
2.  **Clone your forked repository** to your local machine.
    ```bash
    git clone https://github.com/fredspizza/numeric_utils.git
    cd numeric_utils
    ```
3.  **Create a new branch** for your contribution.  Choose a descriptive branch name, like `fix-rounding-bug` or `add-percentage-formatting`.
    ```bash
    git checkout -b feature/your-feature-name
    ```
4.  **Make your changes** in your branch.
5.  **Write tests** for your changes (if applicable).  Ensure existing tests still pass.
6.  **Ensure the code is well-formatted** (run `dart format .` in the project root).
7.  **Commit your changes** with clear and concise commit messages.
    ```bash
    git commit -m "feat: Add new percentage formatting extension"
    ```
8.  **Push your branch** to your forked repository on GitHub.
    ```bash
    git push origin feature/your-feature-name
    ```
9.  **Create a Pull Request (PR)** on GitHub against the `main` branch of the original `numeric_utils` repository.
10. **Describe your changes** clearly in the pull request description, referencing any related issues if applicable.

### Types of Contributions We Welcome

We appreciate contributions in many forms, including:

*   **Bug Reports:**  If you find a bug, please [open an issue](https://github.com/fredpizza/numeric_utils/issues) with clear steps to reproduce it.
*   **Feature Requests:**  Have an idea for a new feature or enhancement?  [Open an issue](https://github.com/fredspizza/numeric_utils/issues) to discuss it!
*   **Code Contributions:**  Fixes, new features, improvements to existing code - all welcome. Please follow the "How to Contribute" steps above.
*   **Documentation Improvements:**  Help us make the documentation clearer, more comprehensive, or fix any errors.
*   **Examples:**  Adding more examples to the `example/` directory to showcase different use cases.
*   **Tests:**  Improving test coverage and adding new test cases, especially for edge cases.

### Code Style and Conventions

Please ensure your code adheres to the following:

*   **Dart Style Guide:** Follow the [official Dart style guide](https://dart.dev/effective-dart/style).
*   **Formatting:**  Use `dart format .` to format your code.
*   **Write clear and concise code** with meaningful names.
*   **Include documentation comments** for new classes, methods, and functions.

### Code of Conduct

We believe in keeping things straightforward and positive.  Our Code of Conduct is simply:

**Be excellent to one another.**

We aim to foster a friendly and welcoming space for everyone who wants to contribute.  We trust that all participants 
will naturally embrace this principle in their interactions within the project.

### Questions and Discussions

If you have questions, want to discuss features, or need help, please [open an issue](https://github.com/fredspizza/numeric_utils/issues) or start a discussion 
in the [Discussions](https://github.com/fredspizza/numeric_utils/discussions) section of the repository.

Thank you for your contributions!

## License

`numeric_utils` is open-source software licensed under the [MIT License](LICENSE).  You are free to use, modify, and 
distribute it according to the terms of the license. Please refer to the [LICENSE](LICENSE) file for the complete 
license text.