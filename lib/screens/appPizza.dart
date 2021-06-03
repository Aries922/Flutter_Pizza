import 'package:flutter/material.dart';
import 'package:pizza_app/constants/colors.dart';
import 'package:pizza_app/constants/decorations.dart';
import 'package:pizza_app/constants/strings.dart';
import 'package:pizza_app/constants/styles.dart';
import 'package:pizza_app/providers/auth.dart';
import 'package:pizza_app/providers/pizza.dart';
import 'package:pizza_app/utils/buttons.dart';
import 'package:pizza_app/utils/dropDownFrom.dart';
import 'package:pizza_app/utils/multiselectForm.dart';
import 'package:provider/provider.dart';

import 'myHomePage.dart';

class AddPizza extends StatefulWidget {
  @override
  _AddPizzaState createState() => _AddPizzaState();
}

class _AddPizzaState extends State<AddPizza> {
  String _pizzaType;
  String _pizzaTypeResult;
  List _pizzaSize;
  List _pizzaSizeResult;
  List _pizzaToppings;
  List _pizzaToppingsResult;

  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _pizzaToppings = [];
    _pizzaType = '';
    _pizzaSize = [];
    _pizzaSizeResult = [];
    _pizzaToppingsResult = [];
    _pizzaTypeResult = '';
  }

  // Map<String,dynamic> _addPizza = {
  //   "pizza_type":"",
  //   "pizza_size":[],
  //   "pizza_topping":[],
  // };

  bool _saveForm() {
    var form = formKey.currentState;
    // if (form.validate()) {
    // form.save();
    setState(() {
      _pizzaTypeResult = _pizzaType;
      _pizzaToppingsResult = _pizzaToppings;
      _pizzaSizeResult = _pizzaSize;
      print(_pizzaSizeResult);
      print(_pizzaToppingsResult);
      print(_pizzaTypeResult);
    });

    form.save();
    return true;
  }

  Future _submit() async {
    formKey.currentState.save();
    Auth auth = Provider.of<Auth>(context, listen: false);
    int id = auth.userId;
    try {
// print();
      await Provider.of<Pizza>(context, listen: false)
          .add(_pizzaTypeResult, _pizzaSizeResult, _pizzaToppingsResult)
          .then((_) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => MyHomePage()));
      });
    } catch (e) {
      print(e.toString());
      // var errorMessage = "Please Try Again";
      // showErrorDilog(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: MyDecoration.backGroundGradiant(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: TEXTCOL,
          title: Text(
            ADDPIZZS,
            style: TextStyles.headingStyleHome(),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: double.infinity,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(padding: EdgeInsets.all(10)),
                    MyDropDownFrom(
                      name: "Type",
                      hint: "Select One Type",
                      items: [
                        {"value": "Regular", "display": "Regular"},
                        {"value": "Square", "display": "Square"},
                      ],
                      myValue: _pizzaType,
                      onChange: (value) {
                        setState(() {
                          _pizzaType = value;
                        });
                      },
                      onSave: (value) {
                        setState(() {
                          _pizzaType = value;
                        });
                      },
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    MyMultiSelect(
                      items: [
                        {"value": "Small", "display": "Small"},
                        {"value": "Large", "display": "Large"},
                        {"value": "Medium", "display": "Medium"}
                      ],
                      name: "Size",
                      hint: "Please Select Sizes",
                      myValue: _pizzaSize,
                      onSave: (value) {
                        if (value == null) return "Please Select Sizes";
                        setState(() {
                          _pizzaSize = value;
                        });
                      },
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    MyMultiSelect(
                      items: [
                        {"value": "Corn", "display": "Corn"},
                        {"value": "Capsicum", "display": "Capsicum"},
                        {"value": "Onion", "display": "Onion"}
                      ],
                      name: "Topping",
                      hint: "Select Toppings",
                      myValue: _pizzaToppings,
                      onSave: (value) {
                        setState(() {
                          if (value == null) return;
                          _pizzaToppings = value;
                          print(_pizzaToppings);
                        });
                      },
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    MyButton(
                        onClick: () {
                          if (_saveForm()) _submit();
                          // print("$_addPizza");
                          // Navigator.pushAndRemoveUntil(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => MyHomePage()),(context)=> false);
                        },
                        name: "ADD")
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
