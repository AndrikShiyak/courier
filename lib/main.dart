import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/home/components/new_transaction.dart';
import 'screens/home/components/body.dart';
import 'providers/transaction.dart';
import 'screens/details/transaction_detail_screen.dart';
import './screens/home/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Transactions(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Кур\'єр Про',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomeScreen(),
        routes: {
          TransactionDetailScreen.routeName: (ctx) => TransactionDetailScreen(),
        },
      ),
    );
  }
}
