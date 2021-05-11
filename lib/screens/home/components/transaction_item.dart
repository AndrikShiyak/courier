import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../providers/transaction.dart';
import '../../details/transaction_detail_screen.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;

  TransactionItem({
    Key key,
    @required this.transaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double km = double.parse(transaction.km);
    final double orders = double.parse(transaction.orders);
    final double hours = double.parse(transaction.hours);
    final double costFuel = (double.parse(transaction.consume) / 100 * km) *
        double.parse(transaction.price);
    final sum = (((orders * 17) + (km * 3.55) + (hours * 39)) - costFuel);
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Ви впевнені?'),
            content: Text('Ви дійсно хочете видалити?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('Ні'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('Так'),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Transactions>(context, listen: false)
            .removeTx(transaction.id);
      },
      background: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Theme.of(context).errorColor,
        ),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(
          right: 20,
        ),
        margin: EdgeInsets.all(10),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            TransactionDetailScreen.routeName,
            arguments: transaction.id,
          );
        },
        child: Card(
          elevation: 8,
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                buildPadding(
                    title: 'Дата:',
                    value:
                        DateFormat('dd/MM/yyyy').format(transaction.dateTime),
                    fontSize: 18,
                    isBold: true),
                buildPadding(title: 'Замовлень:', value: transaction.orders),
                buildPadding(title: 'Кілометраж:', value: transaction.km),
                buildPadding(title: 'Годин:', value: transaction.hours),
                buildPadding(title: 'Розхід:', value: transaction.consume),
                buildPadding(title: 'Ціна пального:', value: transaction.price),
                buildPadding(
                    title: 'Сума:',
                    value: sum.toStringAsFixed(2),
                    fontSize: 18,
                    isBold: true),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildPadding(
      {@required String title,
      @required String value,
      double fontSize = 14,
      bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: fontSize,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
          Text(
            value,
            style: TextStyle(
                fontSize: fontSize,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
