import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/trascation.dart';

class Transactionitem extends StatelessWidget {

  const Transactionitem({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: FittedBox(
                child: Text('\$${transaction.amount}')
              ),
          ),
        ),
        title: Text(transaction.title, style: Theme.of(context).textTheme.title,),
        subtitle: Text(DateFormat.yMMMd().format(transaction.date)),
        trailing: MediaQuery.of(context).size.width > 460
        ? FlatButton.icon(
            icon: const Icon(Icons.delete), //const widget will not be rebuilt
            label: const Text("Delete"),
            onPressed: () => deleteTx(transaction.id),
          )
        : IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => deleteTx(transaction.id),
          ),
      ),
    );
  }
}