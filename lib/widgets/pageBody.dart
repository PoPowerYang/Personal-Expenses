import 'package:flutter/material.dart';

import '../models/trascation.dart';
import './chart.dart';

class PageBody extends StatefulWidget {
  final isLandScape;
  final mediaQuery;
  final appBar;
  final List<Transaction> userTransactions;
  final Container txListWidge;

  PageBody(this.isLandScape, this.mediaQuery, this.appBar, this.userTransactions, this.txListWidge);

  @override
  _PageBodyState createState() => _PageBodyState(appBar, userTransactions, txListWidge);
}

class _PageBodyState extends State<PageBody> {
  bool _showChart = false;

  final appBar;
  final List<Transaction> _userTransactions;
  final Container txListWidge;

  _PageBodyState(this.appBar, this._userTransactions, this.txListWidge);

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7)
          ),
        );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
        return SafeArea(child: SingleChildScrollView(
                  child: 
                    Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      if(widget.isLandScape) Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                              'Show Chart', 
                              style: Theme.of(context).textTheme.title,
                          ),
                          Switch.adaptive(
                            activeColor: Theme.of(context).accentColor,
                            value: _showChart,
                            onChanged: (val) {
                              setState(() {
                                _showChart = val;
                              });
                            },
                          ),
                        ],
                      ),
                      if(!widget.isLandScape) Container(
                        height: (widget.mediaQuery.size.height - appBar.preferredSize.height
                             - widget.mediaQuery.padding.top) * 0.3,
                    child: Chart(_recentTransactions)
                  ),

                  if(!widget.isLandScape) txListWidge,

                  if(widget.isLandScape)
                    _showChart 
                    ? Container(
                      height: (widget.mediaQuery.size.height 
                              - appBar.preferredSize.height 
                              - widget.mediaQuery.padding.top) * 0.7,
                      child: Chart(_recentTransactions)
                    )
                  // Expanded(
                    // child: 
                    : txListWidge
                  // ),
                ],
              ),
            ),);
  }
}