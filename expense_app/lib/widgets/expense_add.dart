// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:expense_app/models/model_expense.dart';
import 'package:flutter/rendering.dart';

class ExpenseAdd extends StatefulWidget {
  ExpenseAdd({super.key, required this.addingExpense});
  final void Function(Expense exp) addingExpense;
  @override
  State<ExpenseAdd> createState() => _ExpenseAddState();
}

class _ExpenseAddState extends State<ExpenseAdd> {
  final _titleController = TextEditingController();
  final _amoutController = TextEditingController();
  DateTime? pickedDate;
  Category _selectedcategory = Category.Food;

  void _submitForm() {
    final fillAmount = double.tryParse(_amoutController.text);
    final checkAmount = fillAmount == null || fillAmount <= 0;

    if (_titleController.text.trim().isEmpty == true ||
        checkAmount == true ||
        pickedDate == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid Output'),
          content: const Text('Please Fill All Details'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Okay"))
          ],
        ),
      );

      return;
    }
    widget.addingExpense(Expense(
        amount: fillAmount!,
        title: _titleController.text,
        date: pickedDate!,
        category: _selectedcategory));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController;
    _amoutController;
    super.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstdate = DateTime.now();

    final _pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstdate,
        lastDate: DateTime(2024));
    setState(() {
      pickedDate = _pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                label: Text(
                  'Title',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.deepPurple),
                ),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple)),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: TextField(
                    controller: _amoutController,
                    decoration: const InputDecoration(
                      prefix: Text('Rs.'),
                      label: Text(
                        'Amount',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple),
                      ),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple)),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Text(pickedDate == null
                  ? "no date selected"
                  : formatter.format(pickedDate!).toString()),
              IconButton(
                  onPressed: _presentDatePicker,
                  icon: const Icon(Icons.calendar_month)),
              // const SizedBox(
              //   width: 20,
              // ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(children: [
            Padding(
              padding: const EdgeInsets.only(left: 22),
              child: DropdownButton(
                  value: _selectedcategory,
                  items: Category.values
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(
                              category.name.toString().toUpperCase(),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      if (value != null) _selectedcategory = value;
                    });
                  }),
            ),
            Spacer(),
            Row(
              children: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel")),
                ElevatedButton(
                    onPressed: () {
                      _submitForm();
                      // print(_titleController.text +
                      //     " " +
                      //     _amountController.text);
                    },
                    child: const Text("Save Expenses")),
              ],
            )
          ]),
        ],
      ),
    );
  }
}
