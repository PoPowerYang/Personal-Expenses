import 'package:flutter/material.dart';

import './transaction_item.dart';
import '../models/trascation.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _listOfTx;
  final Function deleteTx;
  TransactionList(this._listOfTx, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return _listOfTx.isEmpty ? LayoutBuilder(
      builder: (context, constraints){
        return Column(children: <Widget>[
          Text(
            'No transaction added yet!',
            style: Theme.of(context).textTheme.title,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 200,
            child: Image.asset(
              'assets/image/waiting.png',
              fit: BoxFit.cover,
            ),
          ),
        ],);
      },
    ) 
      :ListView(
        children: 
          _listOfTx.map((tx) => Transactionitem(
            key: ValueKey(tx.id),
            transaction: tx, 
            deleteTx: deleteTx
        )).toList()
      );
  }
}