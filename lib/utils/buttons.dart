// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:pizza_app/constants/colors.dart';
import 'package:pizza_app/constants/styles.dart';

class MyButton extends StatelessWidget {
  final Function onClick;
  final String name;

  const MyButton({Key key, this.onClick, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.teal[900],
      child: MaterialButton(
        minWidth: double.infinity,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: onClick,
        child: Text(name,
            textAlign: TextAlign.center,
            style: TextStyle(color: SCREENCOLC, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class Signup extends StatelessWidget {
  final Function onClick;
  final String textforclick;
  final String textonly;

  const Signup({Key key, this.onClick, this.textforclick, this.textonly})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(text: '$textonly', style: TextStyles.createTextStyle()),
            TextSpan(
                text: '$textforclick', style: TextStyles.createTextStyleBold()),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class DropDownList extends StatefulWidget {
  final List<String> dropdownItems;
  final String hint;
  String chosenValue;

  DropDownList({Key key, this.dropdownItems, this.hint, this.chosenValue})
      : super(key: key);

  @override
  _DropDownListState createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.chosenValue,
      elevation: 5,
      style: TextStyle(fontSize: 20, color: TEXTCOL),
      iconEnabledColor: TEXTCOL,
      items: widget.dropdownItems.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(color: TEXTCOL),
          ),
        );
      }).toList(),
      hint: Text(
        "${widget.hint}",
        style: TextStyle(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
      ),
      onChanged: (String value) {
        setState(() {
          widget.chosenValue = value;
          print(value);
        });
      },
    );
  }
}
