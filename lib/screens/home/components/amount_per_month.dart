import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/transaction.dart';

enum MonthOptions {
  ThisMonth,
  PreviousMonth,
}

class AmountPerMonth extends StatefulWidget {
  @override
  _AmountPerMonthState createState() => _AmountPerMonthState();
}

class _AmountPerMonthState extends State<AmountPerMonth> {
  var _showPrevMonth = false;

  @override
  Widget build(BuildContext context) {
    final thisMonthTotalSum =
        Provider.of<Transactions>(context).getTotalSum(_showPrevMonth);
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: 240,
            ),
            child: Text(
              _showPrevMonth
                  ? 'Сума за минулий місяць:'
                  : 'Сума за цей місяць:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Spacer(),
          Container(
            constraints: BoxConstraints(
              maxWidth: 100,
            ),
            child: Text(
              '${thisMonthTotalSum.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          PopupMenuButton(
            onSelected: (MonthOptions selectedValue) {
              if (selectedValue == MonthOptions.PreviousMonth) {
                setState(() {
                  _showPrevMonth = true;
                });
              } else {
                setState(() {
                  _showPrevMonth = false;
                });
              }
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Цей місяць'),
                value: MonthOptions.ThisMonth,
              ),
              PopupMenuItem(
                child: Text('Минулий місяць'),
                value: MonthOptions.PreviousMonth,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
