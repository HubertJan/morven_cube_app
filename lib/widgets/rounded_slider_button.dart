import "package:flutter/material.dart";

class RoundedSliderButton extends StatelessWidget {
  final String text;
  final Function() onClick;

  RoundedSliderButton(this.text, this.onClick);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: new BorderRadius.all(
          const Radius.circular(8.0),
        ),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: this.onClick,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20),
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
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Column(
              children: [
                Text(
                  "Zeit",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CustomSlider(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class CustomSlider extends StatefulWidget {
  CustomSlider({Key key}) : super(key: key);

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _CustomSliderState extends State<CustomSlider> {
  double _currentSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        valueIndicatorColor: Colors.black, // This is what you are asking for
        valueIndicatorTextStyle: TextStyle(color: Colors.white),
        inactiveTrackColor: Color(0xFF8D8E98), // Custom Gray Color
        activeTrackColor: Colors.white,
        thumbColor: Colors.black,
        overlayColor: Color(0x29EB1555), // Custom Thumb overlay Color
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
      ),
      child: Slider(
        value: _currentSliderValue,
        min: 0,
        max: 100,
        divisions: 5,
        label: _currentSliderValue.round() == 0
            ? "So schnell wie möglich"
            : _currentSliderValue.round().toString() + "s",
        onChanged: (double value) {
          setState(() {
            _currentSliderValue = value;
          });
        },
      ),
    );
  }
}
