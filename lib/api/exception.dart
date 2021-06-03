import 'package:flutter/cupertino.dart';

class HttpExceptions  implements Exception{
  final message;

  HttpExceptions(this.message);

  

  @override
  String toString() {
    // TODO: implement toString
    print("Exception "+message);
    return message;

  }
}