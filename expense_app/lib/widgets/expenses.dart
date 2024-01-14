// import 'dart:math';

import 'package:expense_app/widgets/expense_add.dart';
import 'package:expense_app/models/model_expense.dart';
import 'package:expense_app/widgets/expenses_list.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  List<Expense> expenseData = [
    Expense(
        title: 'Momos',
        amount: 200,
        date: DateTime.now(),
        category: Category.Food),
    Expense(
        title: 'Berger',
        amount: 500,
        date: DateTime.now(),
        category: Category.Food),
    Expense(
        title: 'Movie',
        amount: 800,
        date: DateTime.now(),
        category: Category.Liesure),
    Expense(
        title: 'Site-Visiting  ',
        amount: 2600,
        date: DateTime.now(),
        category: Category.Work),
    Expense(
        title: 'Flight',
        amount: 3700,
        date: DateTime.now(),
        category: Category.Travel),
  ];

  void addingExpense(Expense exp) {
    setState(() {
      expenseData.add(exp);
    });
  }

  void _addExpense() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return ExpenseAdd(
            addingExpense: addingExpense,
          );
        });
  }

  void onRemoveExpense(Expense exp) {
    int index = expenseData.indexOf(exp);
    setState(() {
      expenseData.remove(exp);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Expense deleted'),
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              expenseData.insert(index, exp);
            });
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No Data is Added , Add Some Expense'),
    );

    if (expenseData.isNotEmpty) {
      mainContent = Expanded(
          child: ExpensesList(
        expenseData: expenseData,
        removeExpense: onRemoveExpense,
      ));
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              _addExpense();
            },
            icon: const Icon(
              Icons.add,
              size: 25,
            ),
            color: const Color.fromARGB(255, 223, 216, 216),
          )
        ],
        title: const Text(
          "Expense Tracker",
          style: TextStyle(fontSize: 25, fontFamily: 'FontsMain'),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 1, 8, 102),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [mainContent],
        ),
      ),
    );
  }
}
