import 'package:flutter/material.dart';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:sqflite/sqflite.dart' as sql;
import '../helpers/db_helper.dart';

class Transaction {
  final String id;
  final String orders;
  final String km;
  final String hours;
  final String consume;
  final String price;
  // final double sum;
  final DateTime dateTime;

  Transaction({
    @required this.id,
    @required this.orders,
    @required this.km,
    @required this.hours,
    @required this.consume,
    @required this.price,
    // this.sum,
    @required this.dateTime,
  });
}

class Transactions with ChangeNotifier {
  List<Transaction> _transactions = [];

  List<Transaction> get transactions {
    return [..._transactions].reversed.toList();
  }

  // List<Transaction> get sortedTransactions {
  //   List<Transaction> sortedList = _transactions.sort((a, b) {
  //     return a.dateTime.compareTo(b.dateTime);
  //   });
  //   return sortedList;
  // }

  List<Transaction> get monthTransaction {
    return _transactions
        .where((tx) => (tx.dateTime.year == DateTime.now().year &&
            tx.dateTime.month == (DateTime.now().month - 1)))
        .toList();
  }

  // var flButtonSwitch = true;

  double getTotalSum(bool prevMonth) {
    if (_transactions.isEmpty) {
      return 0.0;
    }
    List<Transaction> monthTx;
    if (prevMonth) {
      monthTx = _transactions
          .where((tx) => (tx.dateTime.year == DateTime.now().year &&
              tx.dateTime.month == (DateTime.now().month - 1)))
          .toList();
    } else {
      monthTx = _transactions
          .where((tx) => (tx.dateTime.year == DateTime.now().year &&
              tx.dateTime.month == (DateTime.now().month)))
          .toList();
    }

    var total = 0.0;
    for (var i = 0; i < monthTx.length; i++) {
      var costFuel = (double.parse(monthTx[i].consume) /
              100 *
              double.parse(monthTx[i].km)) *
          double.parse(monthTx[i].price);
      var ordersSum = double.parse(monthTx[i].orders) * 17;
      var kmSum = double.parse(monthTx[i].km) * 3.55;
      var hoursSum = double.parse(monthTx[i].hours) * 39;
      var sumOfDay = (ordersSum + kmSum + hoursSum) - costFuel;

      total += sumOfDay;
    }
    return total;
  }

  Transaction getTransaction(String id) {
    return _transactions.firstWhere((tx) => tx.id == id);
  }

  void updateTransaction(String txId, Transaction tx) {
    final txIndex = _transactions.indexWhere((tx) => tx.id == txId);
    if (txIndex >= 0) {
      _transactions[txIndex] = tx;

      notifyListeners();
      DBHelper.update('courier', tx);
    } else {
      print('...');
    }
  }

  void addTx(
    String orders,
    String km,
    String hours,
    String consume,
    String price,
    DateTime date,
  ) {
    if (orders == null ||
        km == null ||
        hours == null ||
        consume == null ||
        price == null ||
        date == null) {
      return;
    }
    var newTx = Transaction(
      id: UniqueKey().toString(),
      orders: orders,
      km: km,
      hours: hours,
      consume: consume,
      price: price,
      dateTime: date,
    );
    _transactions.add(newTx);
    notifyListeners();
    DBHelper.insert('courier', {
      'id': newTx.id,
      'orders': newTx.orders,
      'km': newTx.km,
      'hours': newTx.hours,
      'consume': newTx.consume,
      'price': newTx.price,
      'date': date.toIso8601String(),
    });
  }

  Future<void> fetchAndSetData() async {
    final dataList = await DBHelper.getData('courier');
    var newTxList = dataList
        .map(
          (tx) => Transaction(
            id: tx['id'],
            orders: tx['orders'],
            km: tx['km'],
            hours: tx['hours'],
            consume: tx['consume'],
            price: tx['price'],
            dateTime: DateTime.parse(tx['date']),
          ),
        )
        .toList();
    _transactions = newTxList;
    notifyListeners();
  }

  void removeTx(String id) {
    _transactions.removeWhere((tx) => tx.id == id);
    notifyListeners();
    DBHelper.delete('courier', id);
  }
}
