import 'package:flutter/material.dart';

class SolveViewerScreen extends StatelessWidget {
  static const routeName = '/solveViewerScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: Container(
            color: Colors.white,
            height: double.infinity,
            padding: EdgeInsets.only(top: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Der Würfel wird gelöst",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: LinearProgressIndicator(
                    minHeight: 30,
                    value: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20),
                color: Theme.of(context).primaryColor,
                height: 30,
                width: 30,
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.only(right: 20),
                  padding: EdgeInsets.all(20),
                  color: Colors.white,
                  child: Text("Schritt 1: Oben drehen",
                      style: TextStyle(fontSize: 20)),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20),
                color: Colors.transparent,
                height: 30,
                width: 30,
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.only(right: 20),
                  padding: EdgeInsets.all(20),
                  color: Colors.white,
                  child: Text("Schritt 2: Oben drehen",
                      style: TextStyle(fontSize: 20)),
                ),
              ),
            ],
          ),
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
    );
  }
}
