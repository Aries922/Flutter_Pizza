import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:pizza_app/api/api.dart';
import 'package:pizza_app/api/api_routes.dart';
import 'package:http/http.dart' as http;
import 'package:pizza_app/api/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  var MainUrl = Api.url;
  var LoginUrl = APIRoutes.LOGIN_API;
  var SignUpUrl = APIRoutes.SIGNIN_API;
  var MeUrl = APIRoutes.Me_API;

  String _token;
  String _name;
  String _email;
  int _id;
  DateTime _expiryDate;

  String get userToken {
    return _token;
  }

  String get userName {
    return _name;
  }

  String get userEmail {
    return _email;
  }

  int get userId {
    return _id;
  }

  Future<void> autoLogin() async {
    final pref = await SharedPreferences.getInstance();
  }

  Future<bool> autoLogout() async {
    final pref = await SharedPreferences.getInstance();
    if (!pref.containsKey("userData")) {
      return false;
    }
    final extractedUserData =
        json.decode(pref.getString("userData")) as Map<String, Object>;
    _token = extractedUserData["token"];    
    _name = extractedUserData["name"];    
    _email = extractedUserData["email"]; 
    notifyListeners();

    return true;   
  }

  Future<void> logout() async {
    _id = null;
    _token = null;
    _name = null;
    _email = null;
    notifyListeners();
  }

  Future<void> authentication(
      String email, String password, String urls) async {
    var urlCreate = Uri.parse("$MainUrl/$urls");
    var urlUser = Uri.parse("$MainUrl/$MeUrl");
    print("Sign API init -----");
    // print("Send Data in " + signup.toString());
    try {
      final responce = await http.post(urlCreate, body: {
        'email': email,
        'password': password,
      });

      print("SignUP Status Code :  ${responce.statusCode}");
      print("SignUP Response Body :  ${responce.body}");
      final responseToken = json.decode(responce.body);
      _token = responseToken["token"];
      var tok = _token.toString();
      final responceDetail =
          await http.get(urlUser, headers: {"Authorization": "Token $tok"});
      final responceData = json.decode(responceDetail.body);
      _name = responceData["name"];
      _email = responceData["email"];
      _id = responceData["id"];
      // _expiryDate= DateTime.now().add(responceData['expiresIn'])
      print(responceData);

      if (responseToken['non_field_errors'] != null) {
        throw HttpExceptions(responseToken['non_field_errors'][0]);
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      final userData = json
          .encode({"name": _name, "email": _email, "id": _id, "token": _token});
      prefs.setString('userData', userData);

      print("check " + userData.toString());

      notifyListeners();
    } catch (e) {
      print(e.toString());
      throw e;
    }
    print("SignIn API end");
  }

  Future<void> authenticationSignup(
      String email, String password, String name, String urls) async {
    // Dio dio = Dio();
    // dio.options.baseUrl = MainUrl;
    // var signup = ;
    var urlCreate =
        Uri.parse("https://pizza-api-django.herokuapp.com/core/api/create/");
    print("Sign API init -----");
    // print("Send Data in " + signup.toString());
    try {
      final responce = await http.post(urlCreate,
          body: {'email': email, 'password': password, 'name': name});
      print("SignUP Status Code :  ${responce.statusCode}");
      print("SignUP Response Body :  ${responce.body}");
      final responseData = json.decode(responce.body);

      if (responseData['email'] != null) {
        throw HttpExceptions(responseData['email'][0]);
      }

      notifyListeners();
    } catch (e) {
      print("Error " + e.toString());
      throw e;
    }
    print("Sign API end -----");
  }

  Future<void> login(String email, String password) {
    return authentication(email, password, APIRoutes.LOGIN_API);
  }

  Future<void> signin(String email, String password, String name) {
    return authenticationSignup(email, password, name, APIRoutes.SIGNIN_API);
  }
}
