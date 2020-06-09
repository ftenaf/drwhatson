import 'package:covid_buster_lite/logic/models/quiz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NumberSlider extends StatefulWidget {
  final Answer answer;
  final VoidCallback onNumberSelected;
  final Function(int) onNumberChange;

  NumberSlider({@required this.answer, @required this.onNumberChange, this.onNumberSelected});

  @override
  _NumberSliderState createState() => _NumberSliderState();
}

class _NumberSliderState extends State<NumberSlider> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Expanded(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
                widget.answer.max,
                (index) => Text(
                      "$index",
                      style: TextStyle(fontSize: 25),
                    )),
          ),
        ),
        Slider(
          value: double.tryParse(widget.answer.value),
          onChanged: (double newValue) {
            widget.onNumberChange(newValue.toInt());
            setState(() {
              widget.answer.value = newValue.toString();
            });
          },
          divisions: widget.answer.max - 1,
          min: widget.answer.min.toDouble(),
          max: widget.answer.max.toDouble(),
          label: '${double.tryParse(widget.answer.value).round()}',
          /*activeColor: Colors.green,
          inactiveColor: Colors.grey,*/
          semanticFormatterCallback: (double newValue) {
            return '${newValue.round()}';
          },
        ),
      ],
    )));
  }
}
