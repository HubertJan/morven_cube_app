import 'package:flutter/material.dart';
import 'package:morven_cube_app/models/pattern.dart';
import 'package:morven_cube_app/provider/auth.dart';
import 'package:morven_cube_app/provider/historyEntry.dart';
import 'package:morven_cube_app/widgets/rubiks_side_container.dart';
import 'package:provider/provider.dart';
import '../../provider/process.dart';
import '../../services/fetch_runthrough_by_id.dart';
import '../../widgets/custom_tile_list.dart';

import '../../widgets/rubiks_side_container.dart';
import '../pattern_screens/pattern_viewer_screen.dart';

class ResultSolveScreen extends StatelessWidget {
  static const routeName = '/resultSolveScreen';

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final String historyId =
        ModalRoute.of(context).settings.arguments as String;
    final url = Provider.of<Auth>(context, listen: false).url;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "Auswertung",
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.left,
          ),
        ),
      ),
      body: FutureBuilder(
          future: Provider.of<Process>(context, listen: false)
              .fetchUntilIsNotRunningAndSetData(),
          builder: (ctx, dataSnapshot) {
            var process = Provider.of<Process>(context, listen: false);

            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              if (!process.isRunning) {
                return Center(child: CircularProgressIndicator());
              }
            }
            return FutureBuilder<HistoryEntry>(
                future: fetchRunthroughById(url: url, id: historyId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final data = snapshot.data;
                  return ListView(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      CustomTileList(
                        title: "Statistik",
                        tiles: [
                          Ink(
                            color: Colors.white,
                            child: ListTile(
                              title: const Text("Zeit"),
                              trailing: Container(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  '${data.time.toString()}ms',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context).primaryColor),
                                ),
                              ),
                            ),
                          ),
                          Ink(
                            color: Colors.white,
                            child: ListTile(
                              title: const Text("Schritte"),
                              trailing: Container(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  '${data.instructions.length.toString()}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context).primaryColor),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTileList(
                        title: "Muster",
                        tiles: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: GestureDetector(
                              onTap: () => Navigator.of(context).pushNamed(
                                PatternViewerScreen.routeName,
                                arguments: data.startPattern,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Startmuster",
                                      style: TextStyle(fontSize: 16)),
                                  RubiksSideContainer(
                                      pattern: data.startPattern,
                                      side: Side.front)
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: GestureDetector(
                              onTap: () => Navigator.of(context).pushNamed(
                                PatternViewerScreen.routeName,
                                arguments: data.endPattern,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Endmuster",
                                      style: TextStyle(fontSize: 16)),
                                  RubiksSideContainer(
                                      pattern: data.endPattern,
                                      side: Side.front)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
                });
          }),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop()),
            Spacer(),
          ],
        ),
      ),
      /* floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Theme.of(context).primaryColor,
          label: Text("Wiederholen"),
          onPressed: () {}),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,*/
    );
  }
}
