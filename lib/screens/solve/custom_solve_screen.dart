import 'package:flutter/material.dart';
import 'package:morven_cube_app/screens/solve/result_solve_screen.dart';

import 'package:provider/provider.dart';

import '../../widgets/custom_tile_list.dart';
import '../../widgets/slider_list_tile.dart';

import '../../provider/status.dart';
import '../../models/solveSetting.dart';

enum Algorithmus { mowen, kociemba }

class CustomSolveScreen extends StatefulWidget {
  static const routeName = '/customSolveScreen';

  @override
  _CustomSolveScreenState createState() => _CustomSolveScreenState();
}

class _CustomSolveScreenState extends State<CustomSolveScreen> {
  final _form = new GlobalKey<FormState>();
  final _accelerationFocusNode = new FocusNode();
  final SolveSetting setting = SolveSetting();
  Algorithmus _algorithmus = Algorithmus.mowen;

  Future<void> _selectAlgorithmus() async {
    switch (await showDialog<Algorithmus>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select assignment'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, Algorithmus.mowen);
                },
                child: const Text('Mowen'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, Algorithmus.kociemba);
                  ;
                },
                child: const Text('Kociemba'),
              ),
            ],
          );
        })) {
      case Algorithmus.mowen:
        _algorithmus = Algorithmus.mowen;
        setState(() {});
        break;
      case Algorithmus.kociemba:
        _algorithmus = Algorithmus.kociemba;
        setState(() {});
        break;
    }
  }

  void _submit() async {
    if (!_form.currentState.validate()) {
      // Invalid!
      return;
    }
    _form.currentState.save();
    Provider.of<Status>(context, listen: false)
        .postPattern("DRLUUBFBRBLURRLRUBLRDDFDLFUFUFFDBRDUBRUFLLFDDBFLUBLRBD",
            setting: setting)
        .then((_) => Navigator.of(context).popAndPushNamed(
              ResultSolveScreen.routeName,
            ));
  }

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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: _form,
          child: ListView(
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
                      title: Text("Algorithmus"),
                      onTap: () => {_selectAlgorithmus()},
                      trailing: Container(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          _algorithmus == Algorithmus.kociemba
                              ? "Kociemba"
                              : "Mowen",
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  ),
                  /*    Ink(
                    color: Colors.white,
                    child: SwitchListTile(
                      title: const Text('Lights'),
                      value: true,
                      onChanged: (bool value) {},
                    ),
                  ),*/
                  Ink(
                    color: Colors.white,
                    child: ListTile(
                      title: const Text("Beschleunigung"),
                      trailing: Container(
                        width: 100,
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          onSaved: (value) {
                            setting.acc50 = int.parse(value);
                          },
                          validator: (value) {
                            if (int.tryParse(value) == null) {
                              return "Keine Zahl";
                            }
                            return null;
                          },
                          textAlign: TextAlign.center,
                          decoration: new InputDecoration(
                            hintText: "Wert",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          keyboardType: TextInputType.number,
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
                      title: const Text("Beschleunigung bei 50"),
                      trailing: Container(
                        width: 100,
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          onSaved: (value) {
                            setting.acc50 = int.parse(value);
                          },
                          validator: (value) {
                            if (int.tryParse(value) == null) {
                              return "Keine Zahl";
                            }
                            return null;
                          },
                          textAlign: TextAlign.center,
                          decoration: new InputDecoration(
                            hintText: "Wert",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          keyboardType: TextInputType.number,
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
                      title: const Text("Beschleunigung bei 100"),
                      trailing: Container(
                        width: 100,
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          onSaved: (value) {
                            setting.acc100 = int.parse(value);
                          },
                          validator: (value) {
                            if (int.tryParse(value) == null) {
                              return "Keine Zahl";
                            }
                            return null;
                          },
                          textAlign: TextAlign.center,
                          decoration: new InputDecoration(
                            hintText: "Wert",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          keyboardType: TextInputType.number,
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
                      title: const Text("Höchste Geschwindigkeit"),
                      trailing: Container(
                        width: 100,
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          onSaved: (value) {
                            setting.maxSp = int.parse(value);
                          },
                          validator: (value) {
                            if (int.tryParse(value) == null) {
                              return "Keine Zahl";
                            }
                            return null;
                          },
                          textAlign: TextAlign.center,
                          decoration: new InputDecoration(
                            hintText: "Wert",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          keyboardType: TextInputType.number,
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
                      title: const Text("CornerCutting bei 50"),
                      trailing: Container(
                        width: 100,
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          onSaved: (value) {
                            setting.cc50 = int.parse(value);
                          },
                          validator: (value) {
                            if (int.tryParse(value) == null) {
                              return "Keine Zahl";
                            }
                            return null;
                          },
                          textAlign: TextAlign.center,
                          decoration: new InputDecoration(
                            hintText: "Wert",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          keyboardType: TextInputType.number,
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
                      title: const Text("CornerCutting bei 100"),
                      trailing: Container(
                        width: 100,
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          onSaved: (value) {
                            setting.cc100 = int.parse(value);
                          },
                          validator: (value) {
                            if (int.tryParse(value) == null) {
                              return "Keine Zahl";
                            }
                            return null;
                          },
                          textAlign: TextAlign.center,
                          decoration: new InputDecoration(
                            hintText: "Wert",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          keyboardType: TextInputType.number,
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
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  Navigator.of(context).pop();
                }),
            Spacer(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FocusScope.of(context).unfocus();
          _submit();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
