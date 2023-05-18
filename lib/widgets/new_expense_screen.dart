import 'package:expense_tracker/widgets/add_close_button.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class AddNewExpenseScreen extends StatefulWidget {
  const AddNewExpenseScreen({Key? key, required this.addExpenseFunction})
      : super(key: key);

  final Function(Expense expense) addExpenseFunction;
  @override
  State<AddNewExpenseScreen> createState() => _AddNewExpenseScreenState();
}

class _AddNewExpenseScreenState extends State<AddNewExpenseScreen> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  var _selectedCategory = Category.work;
  DateTime? _selectedDate;
  void _openCalenderDialog() async {
    var _firstDate = DateTime(DateTime.now().year - 1);
    var selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: _firstDate,
        lastDate: DateTime.now());
    setState(() {
      _selectedDate = selectedDate;
    });
  }

  void onPressedSaveExpense() {
    if (_titleController.text.trim().toString().isEmpty ||
        double.tryParse(_amountController.text) == null ||
        double.tryParse(_amountController.text)! <= 0 ||
        _selectedDate == null) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Invalid Input'),
                content: const Text('Please Select All values correctly'),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Okay'))
                ],
              ));
      return;
    } else {
      widget.addExpenseFunction(Expense(
          title: _titleController.text,
          amount: double.parse(_amountController.text),
          date: _selectedDate!,
          category: _selectedCategory));
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyBoardSpace = MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + keyBoardSpace),
          child: Column(
            children: [
              TextField(
                maxLength: 50,
                controller: _titleController,
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        label: Text('Amount'),
                        prefixText: '\$ ',
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(_selectedDate == null
                            ? 'no date selected'
                            : dateFormatter.format(_selectedDate!).toString()),
                        IconButton(
                          onPressed: _openCalenderDialog,
                          icon: const Icon(Icons.calendar_month),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  DropdownButton(
                      value: _selectedCategory,
                      items: Category.values.map((category) {
                        return DropdownMenuItem(
                            value: category,
                            child: Text(category.name.toUpperCase()));
                      }).toList(),
                      onChanged: (category) {
                        if (category != null) {
                          setState(() {
                            _selectedCategory = category;
                          });
                        }
                      }),
                  const Spacer(),
                  AddCloseButton(
                      text: 'Cancel',
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  AddCloseButton(
                      text: 'Save Expense', onPressed: onPressedSaveExpense),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
