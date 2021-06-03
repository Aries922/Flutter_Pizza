import 'package:flutter/material.dart';
import 'package:pizza_app/api/exception.dart';
import 'package:pizza_app/constants/decorations.dart';
import 'package:pizza_app/constants/strings.dart';
import 'package:pizza_app/constants/styles.dart';
import 'package:pizza_app/providers/auth.dart';
import 'package:pizza_app/screens/loginpage.dart';
import 'package:pizza_app/utils/buttons.dart';
import 'package:provider/provider.dart';

class CreatUser extends StatefulWidget {
  @override
  _CreatUserState createState() => _CreatUserState();
}

class _CreatUserState extends State<CreatUser> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _passwordAgain = TextEditingController();
  final _name = TextEditingController();

  Future _submit() async {
    try {
      await Provider.of<Auth>(context, listen: false)
          .signin(_email.text, _password.text, _name.text);
    }on HttpExceptions catch (e) {
      print(e.toString());
      var errorMessage = 'Authentication failed';
      if (e.toString().contains('email already exists')) {
        errorMessage = 'user with this email already exists.';
        showErrorDilog(errorMessage);
      }
      showErrorDilog(errorMessage);
    } catch (e) {
      var errorMessage = "Please try again";
      showErrorDilog(errorMessage);
    }
  }

  bool _validator(BuildContext context)  {
    if (_email.text.isEmpty ||
        _password.text.isEmpty ||
        _name.text.isEmpty ||
        _passwordAgain.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Check Your Credentials"),
      ));
      return false;
    }
    if (!_email.text.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Invalid Email"),
      ));
      return false;

    }
    if (_password.text.length < 5) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Password should be more then 5 alphabet"),
      ));
      return false;

    }

    if (_password.text != _passwordAgain.text) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Both Password Should be same"),
      ));
      return false;

    }
    return true;
  }

  Map<String, String> _authData = {'email': '', 'password': '', 'name': ''};
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: MyDecoration.backGroundGradiant(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.all(25),
          child: Container(
            width: double.infinity,
            // color: Colors.white,

            child: SingleChildScrollView(
              child: Container(
                height: 700,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(APPTITLE, style: TextStyles.headingStyle()),
                    SizedBox(
                      height: 50,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MyTextField(
                          contr: _email,
                          name: "Email",
                          hint: "Enter your Email here",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        MyTextField(
                          contr: _name,
                          name: "Name",
                          hint: "Enter your Name here",
                          onSub: (value) {
                            _authData['name'] = value;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        MyTextField(
                          contr: _password,
                          name: "Password",
                          hint: "Enter Your Password",
                          onSub: (value) {
                            _authData['password'] = value;
                          },
                        ),
                        SizedBox(height: 10),
                        MyTextField(
                          contr: _passwordAgain,
                          name: "Re-Type Password",
                          hint: "Again type password",
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        MyButton(
                          onClick: () {
                            
                            if(_validator(context))
                              _submit();
                            
                          },
                          name: "SignUp",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Signup(
                            onClick: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                            textonly: "Already have an Account ",
                            textforclick: "SignIn",
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showErrorDilog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("An error Occured"),
        titleTextStyle: TextStyle(color: Colors.orange),
        content: Text(message),
        actions: [
          ElevatedButton(
              onPressed: () => Navigator.of(context).pop(), child: Text("Okay"))
        ],
      ),
    );
  }
}
