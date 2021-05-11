import 'package:courier/screens/home/components/new_transaction.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './components/body.dart';
import '../../providers/transaction.dart';

class MyHomeScreen extends StatelessWidget {
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Кур\'єр Про'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _startAddNewTransaction(context);
              }),
        ],
      ),
      body: Body(),
    );
  }
}
