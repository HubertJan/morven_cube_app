import "package:flutter/material.dart";

class VerticalVariableTile extends StatelessWidget {
  final title;
  final variableText;

  VerticalVariableTile({
    @required this.title,
    @required this.variableText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(this.title,
                textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
            SizedBox(
              height: 10,
            ),
            Text(this.variableText,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20, color: Theme.of(context).primaryColor)),
          ],
        ),
      ],
    ));
  }
}
