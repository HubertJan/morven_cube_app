import 'package:flutter/material.dart';

import '../widgets/custom_tile_list.dart';
import '../widgets//slider_list_tile.dart';

class CustomSolveScreen extends StatelessWidget {
  static const routeName = '/customSolveScreen';

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "Benutzerdefiniertes Lösen",
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.left,
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 50,
          ),
          CustomTileList(
            title: "Prozesseinstellungen",
            tiles: [
              Ink(
                color: Colors.white,
                child: ListTile(
                  title: const Text("Algorithmus"),
                  trailing: Container(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "Mowen",
                      style: TextStyle(
                          fontSize: 16, color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ),
              Ink(
                color: Colors.white,
                child: SwitchListTile(
                  title: const Text('Lights'),
                  value: true,
                  onChanged: (bool value) {},
                ),
              ),
              SliderListTile(),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          CustomTileList(title: "Muster", tiles: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Startmuster", style: TextStyle(fontSize: 16)),
                  Container(
                    margin: EdgeInsets.all(10),
                    color: Colors.yellow,
                    width: 100,
                    height: 100,
                  ),
                ],
              ),
            )
          ])
        ],
      ),
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
      floatingActionButton:
          FloatingActionButton(child: Icon(Icons.add), onPressed: () {}),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
