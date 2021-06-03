import 'package:flutter/material.dart';
import 'package:pizza_app/constants/colors.dart';
import 'package:pizza_app/constants/decorations.dart';
import 'package:pizza_app/constants/strings.dart';
import 'package:pizza_app/constants/styles.dart';
import 'package:pizza_app/models/pizzaData.dart';
import 'package:pizza_app/providers/auth.dart';
import 'package:pizza_app/providers/pizza.dart';
import 'package:pizza_app/screens/appPizza.dart';
import 'package:pizza_app/screens/loginpage.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final as = Provider.of<Pizza>(context, listen: false);
    as.listPizza(context);

    // log();
  }

  String toppings(List<PizzaTopping> list) {
    String str = '';
    list.forEach((element) {
      str += (element.topping + ", ");
    });
    return str;
  }

  String size(List<PizzaSize> list) {
    String str = '';
    list.forEach((element) {
      str += (element.size + ", ");
    });
    return str;
  }

  @override
  Widget build(BuildContext context) {
    final Pizza get = Provider.of<Pizza>(context);

    return Container(
      decoration: MyDecoration.backGroundGradiant(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: TEXTCOL,
          title: Text(
            APPTITLE,
            style: TextStyles.headingStyleHome(),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage()));
                Provider.of<Auth>(context).logout();
              },
              child: Icon(
                Icons.logout_outlined,
                color: SCREENCOLC,
              ),
              style: ElevatedButton.styleFrom(primary: TEXTCOL),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: TEXTCOL,
          onPressed: () {
            // final Pizza get = Provider.of<Pizza>(context, listen: false);
            //  get.addTemp();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddPizza()));
          },
          tooltip: 'Increment',
          child: Icon(
            Icons.add_box,
            color: SCREENCOLC,
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: get.data.pizzaList.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.teal[900],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                            leading: Icon(
                              Icons.food_bank,
                              color: SCREENCOLC,
                            ),
                            title: Text(
                              "${get.data.pizzaList[index].pizzaType}",
                              style: TextStyle(color: SCREENCOLC,fontSize: 20),
                            ),
                            subtitle: Text(
                              "Toppings = ${toppings(get.data.pizzaList[index].pizzaTopping)} Size = ${size(get.data.pizzaList[index].pizzaSize)}",
                              style: TextStyle(color: SCREENCOLA),
                            ))
                      ],
                    ),
                  );
                })),
      ),
    );
  }
}
