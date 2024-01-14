// import 'package:expense_app/data/data_expense.dart';
// import 'package:expense_app/widgets/expenses.dart';
import 'package:expense_app/models/model_expense.dart';
import 'package:expense_app/widgets/expenses_item.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ExpensesList extends StatelessWidget {
  ExpensesList(
      {required this.expenseData, required this.removeExpense, super.key});
  List<Expense> expenseData;
  void Function(Expense exp) removeExpense;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenseData.length,
        itemBuilder: (context, index) => Dismissible(
              key: ValueKey(expenseData[index]),
              child: ExpensesItem(
                expenseData[index],
              ),
              onDismissed: (direction) => removeExpense(expenseData[index]),
            ));
  }
}
