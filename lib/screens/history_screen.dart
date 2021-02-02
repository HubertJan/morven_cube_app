import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../widgets/history_tile.dart';
import '../provider/historyEntries.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "Verlauf",
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.end,
          ),
        ),
      ),
      body: FutureBuilder(
        future: Provider.of<HistoryEntries>(context, listen: false)
            .fetchAndSetEntries(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Consumer<HistoryEntries>(
              builder: (ctx, history, _) {
                return Padding(
                  padding: new EdgeInsets.only(top: statusBarHeight),
                  child: Stack(
                    children: [
                      Container(),
                      Center(
                        child: ListView.builder(
                          itemBuilder: (ctx, i) {
                            final entry = history.entries[i];
                            return HistoryTile(
                                '${entry.time}s', entry.time, entry.date);
                          },
                          itemCount: history.entries.length,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
