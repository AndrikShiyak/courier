import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'transaction_item.dart';
import '../../../providers/transaction.dart';
import './amount_per_month.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
    Provider.of<Transactions>(context, listen: false).fetchAndSetData();
  }

  @override
  Widget build(BuildContext context) {
    final transactionsData = Provider.of<Transactions>(context);
    var transactions = transactionsData.transactions;
    transactions.sort((a, b) => b.dateTime.compareTo(a.dateTime));

    return Column(
      children: [
        AmountPerMonth(),
        if (transactions != null)
          Expanded(
            child: ListView(
              children: transactions
                  .map((tx) => TransactionItem(
                        key: UniqueKey(),
                        transaction: tx,
                      ))
                  .toList(),
            ),
          ),
      ],
    );
  }
}
