import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/transaction.dart';

class TransactionDetailScreen extends StatelessWidget {
  static const routeName = '/transaction-detail';

  @override
  Widget build(BuildContext context) {
    final txId = ModalRoute.of(context).settings.arguments as String;
    var transaction =
        Provider.of<Transactions>(context, listen: false).getTransaction(txId);
    var form = GlobalKey<FormState>();

    void save() {
      final isValid = form.currentState.validate();
      if (!isValid) {
        return;
      }
      form.currentState.save();

      Provider.of<Transactions>(context, listen: false).updateTransaction(
        txId,
        transaction,
      );
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Редагування'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: form,
          child: Container(
            margin: EdgeInsets.all(15),
            child: Column(
              children: [
                TextFormField(
                  initialValue: transaction.orders,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Введіть значення.';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Введіть правильне значення.';
                    }
                    if (double.parse(value) <= 0) {
                      return 'Значення повинно бути більшим за 0.';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Замовлення'),
                  onSaved: (value) {
                    transaction = Transaction(
                      id: transaction.id,
                      orders: value,
                      km: transaction.km,
                      hours: transaction.hours,
                      consume: transaction.consume,
                      price: transaction.price,
                      dateTime: transaction.dateTime,
                    );
                  },
                ),
                TextFormField(
                  initialValue: transaction.km,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Введіть значення.';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Введіть правильне значення.';
                    }
                    if (double.parse(value) <= 0) {
                      return 'Значення повинно бути більшим за 0.';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Кілометраж'),
                  onSaved: (value) {
                    transaction = Transaction(
                      id: transaction.id,
                      orders: transaction.orders,
                      km: value,
                      hours: transaction.hours,
                      consume: transaction.consume,
                      price: transaction.price,
                      dateTime: transaction.dateTime,
                    );
                  },
                ),
                TextFormField(
                  initialValue: transaction.hours,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Введіть значення.';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Введіть правильне значення.';
                    }
                    if (double.parse(value) <= 0) {
                      return 'Значення повинно бути більшим за 0.';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Години'),
                  onSaved: (value) {
                    transaction = Transaction(
                      id: transaction.id,
                      orders: transaction.orders,
                      km: transaction.km,
                      hours: value,
                      consume: transaction.consume,
                      price: transaction.price,
                      dateTime: transaction.dateTime,
                    );
                  },
                ),
                TextFormField(
                  initialValue: transaction.consume,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Введіть значення.';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Введіть правильне значення.';
                    }
                    if (double.parse(value) <= 0) {
                      return 'Значення повинно бути більшим за 0.';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Розхід'),
                  onSaved: (value) {
                    transaction = Transaction(
                      id: transaction.id,
                      orders: transaction.orders,
                      km: transaction.km,
                      hours: transaction.hours,
                      consume: value,
                      price: transaction.price,
                      dateTime: transaction.dateTime,
                    );
                  },
                ),
                TextFormField(
                  initialValue: transaction.price,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Введіть значення.';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Введіть правильне значення.';
                    }
                    if (double.parse(value) <= 0) {
                      return 'Значення повинно бути більшим за 0.';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Ціна пального'),
                  onSaved: (value) {
                    transaction = Transaction(
                      id: transaction.id,
                      orders: transaction.orders,
                      km: transaction.km,
                      hours: transaction.hours,
                      consume: transaction.consume,
                      price: value,
                      dateTime: transaction.dateTime,
                    );
                  },
                ),
                ElevatedButton(
                  onPressed: save,
                  child: Text('Підтвердити'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
