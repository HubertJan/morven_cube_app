import "package:flutter/material.dart";

class HistoryTile extends StatelessWidget {
  final String time;
  final int steps;
  final String runTime;

  HistoryTile(this.runTime, this.steps, this.time);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: .5, color: Colors.black.withOpacity(0.2)),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 25),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              this.time,
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Schritte: ${this.runTime}',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                'Schritte: ${this.steps}',
                style: TextStyle(
                  fontSize: 20,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
