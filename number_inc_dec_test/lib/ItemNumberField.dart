import 'package:flutter/material.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

class ItemNumberField extends StatefulWidget {
  final String text;
  final String hint;
  final TextEditingController controler;
  final double min;
  final double max;
  final num step;
  final num fraction;
  final String unit;
  final double headerWidth;
  final Color color;
  final bool enabled;

  ItemNumberField({
    @required this.text,
    @required this.hint,
    @required this.headerWidth,
    @required this.controler,
    @required this.min,
    @required this.max,
    @required this.step,
    @required this.fraction,
    @required this.unit,
    this.color = Colors.black,
    this.enabled = true,
  });

  @override
  State createState() {
    return _ItemNumberFieldState(
      this.text,
      this.hint,
      this.headerWidth,
      this.controler,
      this.min,
      this.max,
      this.step,
      this.fraction,
      this.unit,
      this.color,
      this.enabled,
    );
  }
}

class _ItemNumberFieldState extends State<ItemNumberField> {
  final String text;
  final String hint;
  final TextEditingController controler;
  final double min;
  final double max;
  final num step;
  final num fraction;
  final String unit;
  final double headerWidth;
  final Color color;
  final bool enabled;

  _ItemNumberFieldState(
    this.text,
    this.hint,
    this.headerWidth,
    this.controler,
    this.min,
    this.max,
    this.step,
    this.fraction,
    this.unit,
    this.color,
    this.enabled,
  );

  @override
  Widget build(BuildContext context) {
    Widget _main = Container(
      width: 100,
      child: NumberInputPrefabbed.squaredButtons(
        separateIcons: true,
        buttonArrangement: ButtonArrangement.incRightDecLeft,
        incIcon: Icons.add,
        decIcon: Icons.remove,
        incDecBgColor: Colors.transparent,
        incDecFactor: widget.step,
        min: widget.min,
        max: widget.max,
        isInt: false,
        fractionDigits: widget.fraction,
        initialValue: num.parse(controler.text),
        controller: controler,
        enabled: this.enabled,
        style: TextStyle(
          fontSize: 20,
          color: widget.color,
          backgroundColor: this.enabled ? Colors.white : Colors.grey,
        ),
        widgetContainerDecoration: BoxDecoration(
          border: Border.all(
            color: Colors.transparent,
          ),
        ),
        numberFieldDecoration: InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );

    return Container(
      padding: EdgeInsets.only(bottom: 3),
      child: Row(
        children: <Widget>[
          Container(
            width: widget.headerWidth,
            padding: EdgeInsets.only(left: 5, right: 10),
            child: Text(
              text,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            child: _main,
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 5),
            child: Text(
              widget.unit,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
