import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:intl/intl.dart';

import '../../../providers/transaction.dart';

class NewTransaction extends StatefulWidget {
  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _orderController = TextEditingController();
  final _kmController = TextEditingController();
  final _hoursController = TextEditingController();
  final _consumeController = TextEditingController();
  final _priceController = TextEditingController();
  DateTime _selectedDate;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  void dispose() {
    _orderController.dispose();
    _kmController.dispose();
    _hoursController.dispose();
    _consumeController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final transactionsData = Provider.of<Transactions>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Замовлення'),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              controller: _orderController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'KM'),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              controller: _kmController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Години'),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              controller: _hoursController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Розхід'),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              controller: _consumeController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Ціна пального'),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) {
                if (_orderController.text.trim().isEmpty ||
                    _kmController.text.trim().isEmpty ||
                    _hoursController.text.trim().isEmpty ||
                    _consumeController.text.trim().isEmpty ||
                    _priceController.text.trim().isEmpty ||
                    _selectedDate == null) {
                  return;
                }
                transactionsData.addTx(
                  _orderController.text,
                  _kmController.text,
                  _hoursController.text,
                  _consumeController.text,
                  _priceController.text,
                  _selectedDate,
                );
                Navigator.of(context).pop();
              },
              controller: _priceController,
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Text(_selectedDate == null
                        ? 'Дата не вибрана!'
                        : 'Вибрана дата: ${DateFormat("dd/MM/yyyy").format(_selectedDate)}'),
                  ),
                  TextButton(
                    onPressed: _presentDatePicker,
                    child: Text(
                      'Вибрати дату',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 10,
              ),
              width: double.infinity,
              child: ElevatedButton(
                child: Text('Підтвердити'),
                onPressed: () {
                  if (_orderController.text.trim().isEmpty ||
                      _kmController.text.trim().isEmpty ||
                      _hoursController.text.trim().isEmpty ||
                      _consumeController.text.trim().isEmpty ||
                      _priceController.text.trim().isEmpty ||
                      _selectedDate == null) {
                    return;
                  }
                  transactionsData.addTx(
                    _orderController.text,
                    _kmController.text,
                    _hoursController.text,
                    _consumeController.text,
                    _priceController.text,
                    _selectedDate,
                  );
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
