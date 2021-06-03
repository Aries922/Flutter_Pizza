import 'package:flutter/material.dart';
import 'package:pizza_app/constants/colors.dart';

class TextStyles {
  static labelStyle() => TextStyle(
        color: TEXTCOL,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );
  static hintStyle() => TextStyle(
        color: HINTTEXTCOL,
        fontSize: 14,
      );
  static headingStyle() => TextStyle(
        color: TEXTCOL,
        fontSize: 40,
        fontWeight: FontWeight.bold,
      );
  static headingStyleHome() => TextStyle(
        color: SCREENCOLB,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      );
  static normalText() => TextStyle(color: SCREENCOLC, fontSize: 16);
  static createTextStyle() => TextStyle(color: TEXTCOL, fontSize: 14);
  static createTextStyleBold() =>
      TextStyle(color: TEXTCOL, fontSize: 14, fontWeight: FontWeight.bold);
}

class MyTextField extends StatelessWidget {
  final TextEditingController contr;
  final Function onSub;
  final String name;
  final String hint;
  final String error;

  const MyTextField(
      {Key key, this.name, this.hint, this.contr, this.onSub, this.error})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: contr,
      onSubmitted: onSub,
      decoration: InputDecoration(
          errorText: error,
          labelStyle: TextStyles.labelStyle(),
          hintStyle: TextStyles.hintStyle(),
          labelText: '$name',
          hintText: '$hint'),
    );
  }
}

class MyPasswordField extends StatefulWidget {
  final TextEditingController contr;
  final Function onSub;
  final String name;
  final String hint;
  final String error;

  const MyPasswordField(
      {Key key, this.name, this.hint, this.contr, this.onSub, this.error})
      : super(key: key);

  @override
  _MyPasswordFieldState createState() => _MyPasswordFieldState();
}

class _MyPasswordFieldState extends State<MyPasswordField> {
  bool _showPassword = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _showPassword,
      controller: widget.contr,
      onSubmitted: widget.onSub,
      decoration: InputDecoration(
          suffixIcon: GestureDetector(
              onTap: _togglePasswordVisibility,
              child: _showPassword
                  ? Icon(Icons.visibility_off_outlined)
                  : Icon(Icons.visibility_outlined)),
          errorText: widget.error,
          labelStyle: TextStyles.labelStyle(),
          hintStyle: TextStyles.hintStyle(),
          labelText: '${widget.name}',
          hintText: '${widget.hint}'),
    );
  }

  _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }
}
