import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard(this.expense, {Key? key}) : super(key: key);

  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Row(
              children: [
                Text(expense.title , style: TextStyle().copyWith(fontSize: 16 , fontWeight: FontWeight.w700),),
              ],
            ),
            Row(
              children: [
                Text('\$ ${expense.amount.toStringAsFixed(2)}',style: TextStyle().copyWith(fontSize: 16 , ),),
                const Spacer(),
                Icon(categoryIcons[expense.category]),
                const SizedBox(
                  width: 5,
                ),
                Text(expense.formattedDate),
              ],
            )
          ],
        ),
      ),
    );
  }
}
