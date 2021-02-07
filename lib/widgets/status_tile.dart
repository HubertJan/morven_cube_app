import 'package:flutter/material.dart';

class StatusTile extends StatelessWidget {
  final String status;

  static const statusMap = {
    "IDLE": ["Idle", Colors.grey],
    "RUN": ["Arbeitet", Colors.orange],
    "FINISHED": ["Fertig", Colors.green],
  };

  StatusTile(this.status);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Status",
          style: TextStyle(fontSize: 20),
        ),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
          ),
          child: Text(
            StatusTile.statusMap[this.status][0],
            style: TextStyle(
              fontSize: 20,
              color: StatusTile.statusMap[this.status][1],
            ),
          ),
        ),
      ],
    );
  }
}
