import 'package:flutter/material.dart';
import 'package:pizza_app/providers/auth.dart';
import 'package:pizza_app/providers/pizza.dart';
import 'package:pizza_app/screens/loginpage.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context)=>Auth(),),
            ChangeNotifierProvider(create: (context)=>Pizza(),),
          ],
          child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
          
            primarySwatch: Colors.teal,
          ),
          home: LoginPage(),
        ),
    );
    
  }
}

