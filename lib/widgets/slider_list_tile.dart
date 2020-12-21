import 'package:flutter/material.dart';

class SliderListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Ink(
      color: Colors.white,
      child: ListTile(
        title: const Text("Zeit"),
        trailing: Container(width: 200, child: CustomSlider()),
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
      data: SliderTheme.of(context).copyWith(),
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
