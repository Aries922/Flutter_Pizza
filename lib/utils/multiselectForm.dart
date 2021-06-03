import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:pizza_app/constants/colors.dart';

class MyMultiSelect extends StatefulWidget {
  final List items;
  final String hint;
  final String name;
  final List myValue;
  final Function onSave;

  const MyMultiSelect({Key key, this.items, this.hint, this.name, this.myValue, this.onSave})
      : super(key: key);
  @override
  _MyMultiSelectState createState() => _MyMultiSelectState();
}

class _MyMultiSelectState extends State<MyMultiSelect> {
  List items;
  String hint;
  String name;


  final formKey = new GlobalKey<FormState>();


  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: formKey,
        child: MultiSelectFormField(
          autovalidate: false,
          chipBackGroundColor: TEXTCOL,
          fillColor: SCREENCOLB,
          chipLabelStyle:
              TextStyle(fontWeight: FontWeight.bold, color: SCREENCOLC),
          dialogTextStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          checkBoxActiveColor: TEXTCOL,
          checkBoxCheckColor: Colors.white,
          dialogShapeBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          title: Text(
            widget.name,
            style: TextStyle(fontSize: 16),
          ),
          validator: (value) {
            if (value == null || value.length == 0) {
              return widget.hint;
            }
            return null;
          },
          dataSource: widget.items,
          textField: 'display',
          valueField: 'value',
          okButtonLabel: 'OK',
          cancelButtonLabel: 'CANCEL',
          hintWidget: Text(widget.hint),
          initialValue: widget.myValue,
          onSaved: widget.onSave,
        ),
      ),
    );
  }
}
