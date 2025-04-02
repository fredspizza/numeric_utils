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
  print('Rounded to 2 decimal places: ${value.toDecimalPlace(2)}');
  print('Rounded to nearest quarter: ${value.toNearestQuarter()}');
}
```

**Example - Currency Formatting:**

```Dart
import 'package:numeric_utils/extensions/numeric_extensions.dart';
import 'package:rational/rational.dart';

void main() {
  final price = Rational.parse("19.995");
  print('Price in USD: ${price.toCurrency(locale: 'en_US')}');
  print('Price in EUR: ${price.toCurrency(locale: 'fr_FR')}');
}
```

**Example - Rational Parsing:**

```Dart
import 'package:numeric_utils/numeric_utils.dart';
import 'package:rational/rational.dart';

void main() {
  final mixedNumber = RationalParsing.fromString(" 1 3/4 ");
  print('Mixed number: $mixedNumber'); // Outputs: 7/4

  final fraction = RationalParsing.fromString(" - 3/4 ");
  print('Fraction: $fraction'); // Outputs: -3/4

  final decimal = RationalParsing.fromString("0.75");
  print('Decimal: $decimal'); // Outputs: 3/4
  
  // Round-trip support for toString()
  final roundTrip = RationalParsing.fromString(Rational.parse("0.75").toString());
  print('Round trip: $roundTrip'); // Outputs: 3/4

  // This causes a FormatException - Rational cannot parse its own output
  Rational.parse(Rational.parse("0.75").toString());
}
```

## Examples Directory

For more detailed examples, please refer to the example/ directory in the repository. It includes examples demonstrating:

- **basic_usage.dart:** Core features of the library.
- **common_use_case.dart:** Practical examples like rounding prices and measurements.
- **edge_cases.dart:** Handling edge cases and potential errors.
- **advanced_features.dart:** Showcasing advanced formatting and halfEven rounding (where applicable).

To run the examples, navigate to the `example/` directory and follow the instructions in its `README.md`.

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

We aim to foster a friendly and welcoming space for everyone who wants to contribute.  We trust that all participants will naturally embrace this principle in their interactions within the project.

### Questions and Discussions

If you have questions, want to discuss features, or need help, please [open an issue](https://github.com/fredspizza/numeric_utils/issues) or start a discussion in the [Discussions](https://github.com/fredspizza/numeric_utils/discussions) section of the repository.

Thank you for your contributions!

## License

`numeric_utils` is open-source software licensed under the [MIT License](LICENSE).  You are free to use, modify, and distribute it according to the terms of the license. Please refer to the [LICENSE](LICENSE) file for the complete license text.