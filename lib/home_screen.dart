import 'package:expense_tracker/list_of_expenses.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/listview_expenses.dart';
import 'package:expense_tracker/widgets/new_expense_screen.dart';
import 'package:expense_tracker/widgets/total_expenses_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _openOverLay() {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (context) =>
          AddNewExpenseScreen(addExpenseFunction: addNewExpense),
    );
  }

  void addNewExpense(Expense expense) {
    setState(() {
      expensesList.add(expense);
      Navigator.pop(context);
    });
  }

  void _deleteExpense(Expense expense) {
    final expenseIndex = expensesList.indexOf(expense);
    setState(() {
      expensesList.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('item deleted'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                expensesList.insert(expenseIndex, expense);
              });
            })));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _openOverLay,
          )
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: expensesList),
                //Chart(expenses: expensesList),
                TotalExpensesCard(totalExpenses: expensesList),
                expensesList.isEmpty
                    ? const Text('no expense found')
                    : ListViewExpenses(
                        expenses: expensesList,
                        deleteExpensesFunction: _deleteExpense),
              ],
            )
          : Row(
            children: [
              Expanded(child: Chart(expenses: expensesList)),
              Expanded(child: TotalExpensesCard(totalExpenses: expensesList)),
              expensesList.isEmpty
                  ? const Expanded(child: Text('no expense found'))
                  : ListViewExpenses(
                      expenses: expensesList,
                      deleteExpensesFunction: _deleteExpense),
            ],
          ),
    );
  }
}
