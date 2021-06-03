import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:pizza_app/api/api.dart';
import 'package:http/http.dart' as http;
import 'package:pizza_app/models/pizzaData.dart';

class Pizza with ChangeNotifier {
  var MainUrl = Api.url;
  PizzaList data;

  PizzaList get pizzaList {
    return data;
  }

  set pizzaList(PizzaList pizza) {
    this.data = pizza;
  }

  Future<void> createPizza(String type, List size, List topping) async {
    var pizzaCreate = Uri.parse("$MainUrl/listpizza/");
    print("init pizza add");
    Map<String, dynamic> data = {
      "pizza_type": type,
      "pizza_topping": [],
      "pizza_size": []
    };

    topping.forEach((element) {
      data['pizza_topping'].add({"topping": element});
    });

    size.forEach((element) {
      data['pizza_size'].add({"size": element});
    });
    try {
      final responcePizza = await http.post(pizzaCreate,
          body: jsonEncode(data),
          headers: {"Content-Type": "application/json; charset=UTF-8"});
      print("responce body" + responcePizza.body);
      final responceData = json.decode(responcePizza.body);
      notifyListeners();
    } catch (e) {
      print("error  " + e.toString());
    }
    print("Pizza Added");
  }

  Future<PizzaList> listPizza(context) async {
    var url = Uri.parse("$MainUrl/listpizza/");
    print("Pizza List API init");
    print(url);
    try {
      final response = await http.get(url,
          headers: {"Content-Type": "application/json; charset=UTF-8"});
      print(response.body);
      // final items = ;
      data = PizzaList.fromJson(jsonDecode(response.body));
    print(data.pizzaList.length);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
    return data;
  }

  addTemp(){
    data.pizzaList.add(PizzaData(id: 343,pizzaType: "ram +"));
    notifyListeners();
  }

  Future<void> add(String type, List size, List topping) {
    return createPizza(type, size, topping);
  }
}
