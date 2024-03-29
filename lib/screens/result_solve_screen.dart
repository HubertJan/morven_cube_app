import 'package:flutter/material.dart';
import 'package:morven_cube_app/models/pattern.dart';
import 'package:morven_cube_app/widgets/rubiks_side_container.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_tile_list.dart';
import '../widgets//slider_list_tile.dart';

import '../provider/status.dart';
import '../provider/process.dart';
import '../widgets/rubiks_side_container.dart';
import '../screens/pattern_viewer_screen.dart';

class ResultSolveScreen extends StatelessWidget {
  static const routeName = '/resultSolveScreen';

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

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
          future:
              Provider.of<Process>(context, listen: false).fetchAndSetData(),
          builder: (ctx, dataSnapshot) {
            var process = Provider.of<Process>(context, listen: false);

            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              if (process.status == "") {
                return Center(child: CircularProgressIndicator());
              }
            }
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
                            '${process.time.toString()}ms',
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
                            '${process.instructions.length.toString()}',
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed(
                          PatternViewerScreen.routeName,
                          arguments: process.pattern,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Startmuster", style: TextStyle(fontSize: 16)),
                            RubiksSideContainer(
                                pattern: process.pattern, side: Side.front)
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed(
                          PatternViewerScreen.routeName,
                          arguments: process.endPattern,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Endmuster", style: TextStyle(fontSize: 16)),
                            RubiksSideContainer(
                                pattern: process.endPattern, side: Side.front)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            );
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
