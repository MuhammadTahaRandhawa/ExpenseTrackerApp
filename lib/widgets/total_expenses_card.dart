import 'package:expense_tracker/main.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';

class TotalExpensesCard extends StatelessWidget {
  const TotalExpensesCard({Key? key, required this.totalExpenses})
      : super(key: key);

  final List<Expense> totalExpenses;

  double get totalFinalExpense {
    double _totalExpenseAmount = 0;

    for (Expense expense in totalExpenses) {
      _totalExpenseAmount += expense.amount;
    }

    return _totalExpenseAmount;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Card(
      color: isDarkMode
          ? Theme.of(context).colorScheme.secondary
          : Theme.of(context).colorScheme.primary.withOpacity(0.65),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Total Expenses',
                style: TextStyle(
                  color: kColorScheme.onPrimaryContainer,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '\$ ${totalFinalExpense.toStringAsFixed(2)}',
                style: TextStyle(
                    color: isDarkMode
                        ? kColorScheme.onSecondary
                        : kDarkColorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 26),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
