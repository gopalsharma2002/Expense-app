// import 'package:expense_app/data/data_expense.dart';
// import 'dart:math';

// import 'package:expense_app/data/data_expense.dart';
import 'package:expense_app/models/model_expense.dart';
import 'package:flutter/material.dart';

class ExpensesItem extends StatelessWidget {
  ExpensesItem(this.ex1, {super.key});
  final Expense ex1;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 82, 177, 221),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ex1.title,
              style: const TextStyle(
                fontFamily: 'FontsMain',
                color: Colors.black,
                fontSize: 20,
                // fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Rs. ${ex1.amount.toString()}',
                  style: const TextStyle(
                    fontFamily: 'FontsMain',
                    color: Colors.black,
                    fontSize: 20,
                    // fontWeight:  FontWeight.bold
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[ex1.category], color: Colors.black),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      ex1.formattedDate,
                      style: const TextStyle(color: Colors.black),
                    )
                  ],
                )
                // Icon(categoryIcons[Expense]),
              ],
            )
          ],
        ),
      ),
    );
  }
}
