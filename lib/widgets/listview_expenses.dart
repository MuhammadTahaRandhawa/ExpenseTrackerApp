import 'package:expense_tracker/main.dart';
import 'package:expense_tracker/widgets/expense_card.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';

class ListViewExpenses extends StatelessWidget {
  const ListViewExpenses(
      {Key? key, required this.expenses, required this.deleteExpensesFunction})
      : super(key: key);

  final List<Expense> expenses;
  final Function(Expense expense) deleteExpensesFunction;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) => Dismissible(
            background: Container(
                decoration: BoxDecoration(
                  color: kColorScheme.error.withOpacity(0.7),
                ),
                margin: const EdgeInsetsDirectional.symmetric(
                    horizontal: 16, vertical: 8),
                alignment: Alignment.centerRight,
                child:  Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Icon(Icons.delete , color: kColorScheme.onError,),
                )),
            onDismissed: (direction) {
              deleteExpensesFunction(expenses[index]);
            },
            key: ValueKey(expenses[index]),
            child: ExpenseCard(expenses[index])),
      ),
    );
  }
}
