import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/trascation.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _listOfTx;
  final Function deleteTx;
  TransactionList(this._listOfTx, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
        child: 
        _listOfTx.isEmpty ? Column(children: <Widget>[
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
        ],) 
        :ListView.builder(
          itemBuilder: (ctx, index) {
            return Card(
                elevation: 10,
                child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: FittedBox(
                        child: Text('\$${_listOfTx[index].amount}')
                      ),
                  ),
                ),
                title: Text(_listOfTx[index].title, style: Theme.of(context).textTheme.title,),
                subtitle: Text(DateFormat.yMMMd().format(_listOfTx[index].date)),
                trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => deleteTx(_listOfTx[index].id),
                  ),
              ),
            );
          },
          itemCount: _listOfTx.length,
          ),
    );
  }
}