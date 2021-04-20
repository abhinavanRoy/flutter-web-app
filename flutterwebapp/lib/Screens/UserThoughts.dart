

import 'package:flutter/material.dart';
import 'package:flutterwebapp/Screens/RootScreen.dart';

class UserThoughts extends StatefulWidget {
  @override
  _UserThoughtsState createState() => _UserThoughtsState();
}

class _UserThoughtsState extends State<UserThoughts> {
  var now = DateTime.now();
  String day = "";

  void addItem() {
    setState(() {
      listItem.add(textEditingController.text);
      day = "Created on " +
          now.day.toString() +
          "." +
          now.month.toString() +
          "." +
          now.year.toString();



    });
  }

  TextEditingController textEditingController = TextEditingController();
  List<String> listItem = List<String>.empty(growable: true);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
        centerTitle: true,


        actions:<Widget> [

          Padding(
            padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: (){
                  Navigator.of(context).pushReplacement(_createRoutetoroot());
                },
                icon: const Icon(Icons.login_outlined),
                tooltip: 'Logout',
              ),
            ),

        ],
      ),
      backgroundColor: Colors.deepPurpleAccent,
      body: Center(
        child: Container(
          height: height,
          width: width,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              SizedBox(
                width: width / 3.5,
                child: TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: "Write your thought",
                    hoverColor: Colors.white10,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  addItem();
                },
                child: Text("Add"),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                color: Colors.deepPurpleAccent,
                height: height / 1.79,
                width: width / 2,
                child: Card(
                  elevation: 10,
                  color: Colors.indigo,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: listItem.length,
                        itemBuilder: (context, int index) {
                          return Container(
                          height: 50,
                          width: 70,
                          child: ListTile(
                            title: Text(listItem[index]),
                            trailing: Text("$day"),

                          )
                            );
                        }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Route _createRoutetoroot() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => RootScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
        Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
