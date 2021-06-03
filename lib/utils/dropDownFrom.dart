

import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';

class MyDropDownFrom extends StatefulWidget {
  final List items;
  final String hint;
  final String name;
  final String myValue;
  final Function onSave;
  final Function onChange;

  const MyDropDownFrom({Key key, this.items, this.hint, this.name, this.myValue, this.onSave, this.onChange}) : super(key: key);
  @override
  _MyDropDownFromState createState() => _MyDropDownFromState();
}

class _MyDropDownFromState extends State<MyDropDownFrom> {

  
  final formKey = new GlobalKey<FormState>();

 
  @override
  Widget build(BuildContext context) {
    return Container(child: DropDownFormField(
                  titleText: widget.name,
                  hintText: widget.hint,
                  value: widget.myValue,
                  onSaved: widget.onSave,
                  onChanged:widget.onChange,
                 
                  dataSource: widget.items,
                  textField: 'display',
                  valueField: 'value',
                ),
      
    );
  }
}
