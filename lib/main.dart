import 'package:flutter/material.dart';

import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/trascation_list.dart';
import './models/trascation.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',

      theme: ThemeData(
        primarySwatch: Colors.red, //automatically fix color for different widgets
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              )
            ),
          )
        ),

      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    final List<Transaction> _userTransactions = [
  
    ];


  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7)
          ),
        );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime choesnDate) {
    final newTx = Transaction(
        title: txTitle, 
        amount: txAmount,
        date: choesnDate,
        id: DateTime.now().toString(),
      );

      setState(() {
        _userTransactions.add(newTx); 
      });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.retainWhere((tx) => tx.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx, 
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text(
              'Personal Expenses',
              style: TextStyle(
                fontFamily: 'Open Sans',
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.view_headline),
                onPressed:() => _startAddNewTransaction(context),
              ),
            ],
          ),
            body: SingleChildScrollView(
              child: 
                Column(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Chart(_recentTransactions),
                  // Expanded(
                    // child: 
                    TransactionList(_userTransactions, _deleteTransaction)
                  // ),
                ],
              ),
            ),

            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, 
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.assignment),
              backgroundColor: Colors.amber,
              onPressed: () => _startAddNewTransaction(context),
            ),
          );
  }
}
