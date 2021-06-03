class PizzaList {
  List<PizzaData> pizzaList = [];
  PizzaList({this.pizzaList});

  PizzaList.fromJson(List data) {
    print(data);

    List<PizzaData> pizzaListTemp = [];
    data.forEach((pizza) {pizzaListTemp.add(PizzaData.fromJson(pizza));});
    this.pizzaList = pizzaListTemp;
  }
  
}

class PizzaData {
  int id;
  List<PizzaTopping> pizzaTopping;
  List<PizzaSize> pizzaSize;
  String pizzaType;

  PizzaData({this.id, this.pizzaTopping, this.pizzaSize, this.pizzaType});

  PizzaData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['pizza_topping'] != null) {
      pizzaTopping = List.from(<PizzaTopping>[], growable: true);

      json['pizza_topping'].forEach((v) {
        pizzaTopping.add(new PizzaTopping.fromJson(v));
      });
    }
    if (json['pizza_size'] != null) {
      pizzaSize = new List.from(<PizzaSize>[], growable: true);
      json['pizza_size'].forEach((v) {
        pizzaSize.add(new PizzaSize.fromJson(v));
      });
    }
    pizzaType = json['pizza_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.pizzaTopping != null) {
      data['pizza_topping'] = this.pizzaTopping.map((v) => v.toJson()).toList();
    }
    if (this.pizzaSize != null) {
      data['pizza_size'] = this.pizzaSize.map((v) => v.toJson()).toList();
    }
    data['pizza_type'] = this.pizzaType;
    return data;
  }
}

class PizzaTopping {
  int id;
  String topping;

  PizzaTopping({this.id, this.topping});

  PizzaTopping.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    topping = json['topping'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['topping'] = this.topping;
    return data;
  }
}

class PizzaSize {
  int id;
  String size;

  PizzaSize({this.id, this.size});

  PizzaSize.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['size'] = this.size;
    return data;
  }
}
