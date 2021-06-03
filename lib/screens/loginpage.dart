
import 'package:flutter/material.dart';
import 'package:pizza_app/api/exception.dart';
import 'package:pizza_app/constants/decorations.dart';
import 'package:pizza_app/constants/strings.dart';
import 'package:pizza_app/constants/styles.dart';
import 'package:pizza_app/providers/auth.dart';
import 'package:pizza_app/screens/myHomePage.dart';
import 'package:pizza_app/utils/buttons.dart';
import 'package:provider/provider.dart';

import 'createUserPAge.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
  }

  bool _validator(BuildContext context) {
    _isLoading = true;
    String error;
    if (_email.text.isEmpty || _password.text.isEmpty) {
      error = "Check Your Credentials";
    } else if (_password.text.length < 5) {
      error = "Password should be more then 5 alphabet";
    } else if (!_email.text.contains('@')) {
      error = "Invalid Email";
    }
    if (error != null) {
      setState(() {
      _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("$error"),
      ));
      setState(() {
      _isLoading = false;
        
      });
      return false;
    }

    return true;
  }

  Future _submit(BuildContext context) async {
    try {
      await Provider.of<Auth>(context, listen: false)
          .login(_email.text, _password.text)
          .then((_) {
            setState(() {
        _isLoading = false;
            });
        Navigator
            .pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx) => MyHomePage()), (context) => false);
      });
    } on HttpExceptions catch (e) {
      var errorMessage = 'Authentication failed';
      if (e.toString().contains('provided credentials')) {
        errorMessage = 'Invalid Credentials';
        showErrorDilog(errorMessage,context);
      }
      showErrorDilog(errorMessage,context);
    } catch (e) {
      var errorMessage = "Please Try Again";
      showErrorDilog(errorMessage,context);
    } finally {
      setState(() {
      _isLoading = false;
        
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: MyDecoration.backGroundGradiant(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.all(25),
          child: Container(
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
                          name: "Email",
                          hint: "Enter your Email here",
                          contr: _email,

                          // error: _validate ? 'Value Can\'t Be Empty' : null,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        MyPasswordField(
                          name: "Password",
                          hint: "Enter Your Password",
                          contr: _password,
                        ),
                        SizedBox(height: 20),
                       _isLoading ? Center(child: CircularProgressIndicator()):  MyButton(
                                onClick: () {
                                  if (_validator(context)) _submit(context);
                                    setState(() {
                                  _isLoading = true;
                                      
                                    });
                                  // showErrorDilog("hello");
                                },
                                name: "Login",
                              ) ,
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Signup(
                            onClick: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreatUser()));
                            },
                            textonly: "Create New Acoount ",
                            textforclick: "SignUp",
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

  void showErrorDilog(String message,BuildContext context) {
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
