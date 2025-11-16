// Copyright 2025 Brian Erst
// SPDX-License-Identifier: MIT

import 'package:rational/rational.dart';
import 'package:numeric_utils/extensions/numeric_extensions.dart';
import 'package:numeric_utils/constants/numeric_constants.dart';

void main() {
  print('=== Financial Calculations with numeric_utils ===\n');

  // Example 1: Compound Interest Calculation
  print('--- Compound Interest ---');
  final principal = Rational.parse('10000'); // $10,000 initial investment
  final annualRate = RationalConstants.fivePercent; // 5% annual interest rate
  final years = 10;

  var balance = principal;
  for (var year = 1; year <= years; year++) {
    final interest = balance * annualRate;
    balance = balance + interest;

    if (year == 1 || year == 5 || year == 10) {
      print('Year $year: ${balance.toCurrency(locale: 'en_US')} '
            '(${interest.toCurrency(locale: 'en_US')} interest)');
    }
  }

  final totalGain = balance - principal;
  final percentGain = totalGain.percentageOf(principal);
  print('Total gain: ${totalGain.toCurrency(locale: 'en_US')} '
        '(${percentGain.toPercentage(2)} return)\n');

  // Example 2: Tax Calculations with Multiple Brackets
  print('--- Income Tax Calculation ---');
  final income = Rational.parse('75000'); // $75,000 income

  // Progressive tax brackets (simplified example)
  final taxBrackets = [
    {'limit': Rational.parse('10000'), 'rate': RationalConstants.tenPercent},
    {'limit': Rational.parse('40000'), 'rate': Rational.parse('0.15')},
    {'limit': Rational.parse('100000'), 'rate': Rational.parse('0.22')},
  ];

  var remainingIncome = income;
  var totalTax = Rational.zero;
  var previousLimit = Rational.zero;

  for (final bracket in taxBrackets) {
    final limit = bracket['limit'] as Rational;
    final rate = bracket['rate'] as Rational;

    if (remainingIncome <= Rational.zero) break;

    final bracketSize = limit - previousLimit;
    final taxableInBracket = remainingIncome.clamp(Rational.zero, bracketSize);
    final tax = taxableInBracket * rate;

    totalTax = totalTax + tax;
    remainingIncome = remainingIncome - taxableInBracket;
    previousLimit = limit;

    print('Bracket ${rate.toPercentage(0, asRatio: true)}: '
          '${taxableInBracket.toCurrency(locale: 'en_US')} → '
          '${tax.toCurrency(locale: 'en_US')} tax');
  }

  final effectiveRate = totalTax.percentageOf(income);
  final netIncome = income - totalTax;
  print('Total tax: ${totalTax.toCurrency(locale: 'en_US')} '
        '(${effectiveRate.toPercentage(2)} effective rate)');
  print('Net income: ${netIncome.toCurrency(locale: 'en_US')}\n');

  // Example 3: Discount and Sales Price Calculations
  print('--- Retail Pricing ---');
  final originalPrice = Rational.parse('149.99');
  final discountPercent = Rational.parse('20'); // 20% off

  final discountAmount = originalPrice * (discountPercent / Rational.fromInt(100));
  final salePrice = originalPrice - discountAmount;

  print('Original price: ${originalPrice.toCurrency(locale: 'en_US')}');
  print('Discount (${discountPercent.toPercentage(0, asRatio: false)}): '
        '-${discountAmount.toCurrency(locale: 'en_US')}');
  print('Sale price: ${salePrice.toCurrency(locale: 'en_US')}');

  // Using the new percentChangeOn helper
  final negativeTwenty = Rational.parse('-20');
  final salePriceHelper = negativeTwenty.percentChangeOn(originalPrice);
  print('(Verified with percentChangeOn: ${salePriceHelper.toCurrency(locale: 'en_US')})\n');

  // Example 4: Loan Amortization (Monthly Payment)
  print('--- Loan Payment Calculation ---');
  final loanAmount = Rational.parse('250000'); // $250,000 mortgage
  final annualInterestRate = Rational.parse('0.065'); // 6.5% APR
  final loanTermYears = 30;

  final monthlyRate = annualInterestRate / Rational.fromInt(12);
  final numberOfPayments = loanTermYears * 12;

  // Monthly payment formula: P * [r(1+r)^n] / [(1+r)^n - 1]
  // Note: Full calculation would require exponential functions which aren't
  // available for Rational. In practice, convert to double for this calculation
  // or use a specialized financial library.

  print('Loan amount: ${loanAmount.toCurrency(locale: 'en_US')}');
  print('Interest rate: ${annualInterestRate.toPercentage(2, asRatio: true)} APR');
  print('Monthly rate: ${monthlyRate.toPercentage(4, asRatio: true)}');
  print('Term: $loanTermYears years ($numberOfPayments payments)');
  print('Note: Full amortization calculation requires exponential functions.\n');

  // Example 5: Investment Portfolio Allocation
  print('--- Portfolio Allocation ---');
  final portfolioValue = Rational.parse('100000'); // $100,000 portfolio

  final allocations = {
    'Stocks': RationalConstants.fiftyPercent,
    'Bonds': RationalConstants.twentyFivePercent,
    'Real Estate': RationalConstants.tenPercent,
    'Cash': Rational.parse('0.15'), // 15%
  };

  allocations.forEach((asset, allocation) {
    final amount = portfolioValue * allocation;
    print('$asset: ${amount.toCurrency(locale: 'en_US')} '
          '(${allocation.toPercentage(0, asRatio: true)})');
  });

  final totalAllocation = allocations.values.reduce((a, b) => a + b);
  print('Total allocation: ${totalAllocation.toPercentage(0, asRatio: true)}\n');

  // Example 6: Currency Conversion with Rounding
  print('--- Currency Conversion ---');
  final usdAmount = Rational.parse('1000.00');
  final exchangeRate = Rational.parse('0.85'); // USD to EUR

  final eurAmount = usdAmount * exchangeRate;
  print('${usdAmount.toCurrency(locale: 'en_US')} → '
        '${eurAmount.toCurrency(locale: 'de_DE', currencyName: 'EUR')}');

  // With bank fees (2.5%)
  final feePercent = Rational.parse('2.5');
  final feeAmount = eurAmount * (feePercent / Rational.fromInt(100));
  final finalAmount = eurAmount - feeAmount;

  print('Conversion fee (${feePercent.toPercentage(1, asRatio: false)}): '
        '-${feeAmount.toCurrency(locale: 'de_DE', currencyName: 'EUR')}');
  print('Final amount: ${finalAmount.toCurrency(locale: 'de_DE', currencyName: 'EUR')}\n');

  // Example 7: Percentage Difference Between Periods
  print('--- Year-over-Year Growth ---');
  final lastYearRevenue = Rational.parse('850000');
  final thisYearRevenue = Rational.parse('935000');

  final growthPercent = thisYearRevenue.percentDifferenceFrom(lastYearRevenue);
  final growthAmount = thisYearRevenue - lastYearRevenue;

  print('Last year: ${lastYearRevenue.toCurrency(locale: 'en_US')}');
  print('This year: ${thisYearRevenue.toCurrency(locale: 'en_US')}');
  print('Growth: ${growthAmount.toCurrency(locale: 'en_US')} '
        '(${growthPercent.toPercentage(2, asRatio: true)} increase)\n');

  // Example 8: Precise Decimal Calculations (avoiding float errors)
  print('--- Why Rational Matters for Finance ---');

  // Demonstrate precision advantage
  final price1 = Rational.parse('0.1');
  final price2 = Rational.parse('0.2');
  final rationalSum = price1 + price2;

  final doubleSum = 0.1 + 0.2; // Infamous floating-point error

  print('Rational: 0.1 + 0.2 = $rationalSum (exact: ${rationalSum == Rational.parse("0.3")})');
  print('Double:   0.1 + 0.2 = $doubleSum (exact: ${doubleSum == 0.3})');
  print('This precision is critical for financial calculations!\n');

  print('=== Examples Complete ===');
}
