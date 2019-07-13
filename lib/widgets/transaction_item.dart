import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/trascation.dart';

class Transactionitem extends StatefulWidget {

  const Transactionitem({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  _TransactionitemState createState() => _TransactionitemState();
}

class _TransactionitemState extends State<Transactionitem> {
  
  Color _bgColor;

  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.black,
      Colors.blue,
      Colors.purple,
    ];

    print("Initstate()");

    _bgColor = availableColors[Random().nextInt(4)];
    super.initState();
  }

  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: _bgColor,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: FittedBox(
                child: Text('\$${widget.transaction.amount}')
              ),
          ),
        ),
        title: Text(widget.transaction.title, style: Theme.of(context).textTheme.title,),
        subtitle: Text(DateFormat.yMMMd().format(widget.transaction.date)),
        trailing: MediaQuery.of(context).size.width > 460
        ? FlatButton.icon(
            icon: const Icon(Icons.delete), //const widget will not be rebuilt
            label: const Text("Delete"),
            onPressed: () => widget.deleteTx(widget.transaction.id),
          )
        : IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => widget.deleteTx(widget.transaction.id),
          ),
      ),
    );
  }
}