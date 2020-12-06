import "package:flutter/material.dart";

class RoundedButton extends StatelessWidget {
  final String text;
  final Function() onClick;

  RoundedButton(this.text, this.onClick);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onClick,
      child: Container(
        width: 300,
        height: 100,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              color: Colors.grey.withAlpha(30),
            )
          ],
          color: Colors.white,
          borderRadius: new BorderRadius.all(
            const Radius.circular(8.0),
          ),
        ),
        child: Center(
          child: Text(
            this.text,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
