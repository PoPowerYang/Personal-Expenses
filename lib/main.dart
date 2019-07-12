import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/trascation_list.dart';
import './models/trascation.dart';
import './widgets/pageBody.dart';


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
      _userTransactions.removeWhere((tx) => tx.id == id);
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
    final mediaQuery = MediaQuery.of(context);
    final isLandScape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS 
    ? CupertinoNavigationBar(
      middle: Text(
              'Personal Expenses',
              style: TextStyle(
                  fontFamily: 'Open Sans',
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  GestureDetector(
                    child: Icon(CupertinoIcons.add),
                    onTap: () => _startAddNewTransaction(context),
                  ),
                ],
              ),
    )
    : AppBar(
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
          );
    final txListWidge = Container(
                      height: (mediaQuery.size.height - appBar.preferredSize.height 
                              - mediaQuery.padding.top) * 1,
                      child: TransactionList(_userTransactions, _deleteTransaction)
                    );

    return Platform.isIOS 
        ? CupertinoPageScaffold(
            child: PageBody(isLandScape, mediaQuery, appBar, _userTransactions, txListWidge),
            navigationBar: appBar,
          )
        : Scaffold(
          appBar: appBar,
            body: PageBody(isLandScape, mediaQuery, appBar, _userTransactions, txListWidge),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, 
            floatingActionButton: Platform.isIOS ? 
            Container()
            : FloatingActionButton(
              child: Icon(Icons.assignment),
              backgroundColor: Colors.amber,
              onPressed: () => _startAddNewTransaction(context),
            ),
          );
  }
}
