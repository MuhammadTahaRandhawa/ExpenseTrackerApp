import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
DateFormat dateFormatter = DateFormat.yMd();

enum Category {
  travel,
  work,
  entertainment,
  food,
}

Map<Category, IconData> categoryIcons = {
  Category.travel: Icons.flight_takeoff,
  Category.work: Icons.work,
  Category.entertainment: Icons.movie,
  Category.food: Icons.lunch_dining_sharp,
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return dateFormatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
      .where((expense) => expense.category == category)
      .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpense {
    double sum = 0;
    for (Expense expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}

// class ExpenseBucket {
//   ExpenseBucket({required this.listOfExpense, required this.category});
//
//   ExpenseBucket.forCategory(this.category, List<Expense> expenseList)
//       : listOfExpense = expenseList
//             .where((expense) => expense.category == category)
//             .toList();
//   List<Expense> listOfExpense;
//   Category category;
//
//   double get totalExpense{
//     double sum = 0;
//     for(final expense in listOfExpense)
//       {
//         sum += expense.amount;
//       }
//     return sum;
//   }
// }
