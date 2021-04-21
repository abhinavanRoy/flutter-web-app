import 'package:flutter/material.dart';
import 'package:flutterwebapp/Screens/RootScreen.dart';
import 'package:flutterwebapp/helper/constants.dart';


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
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    bool isSmall = width < 490;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
        centerTitle: true,


        actions: <Widget>[

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                auth.signOut();
                Navigator.of(context).pushReplacement(_createRoutetoroot());
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Successfully Signed out")));
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
                height: 80,
              ),
              SizedBox(
                width: 400,
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
                height: 30,
              ),
              SizedBox(
                width: 230,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if(textEditingController.text.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Field cannot be empty!")));

                    }
                    else {
                      addItem();
                    }
                  },
                  child: Text("Add",
                  style: TextStyle(
                    fontSize: 18,
                  ),),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              isSmall ?
              Container(
                color: Colors.deepPurpleAccent,
                height: height / 1.79,
                width: height / 0.9,
                child: Card(
                  elevation: 10,
                  color: Colors.indigo,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: listItem.length,
                        itemBuilder: (context, int index) {
                          return Container(
                              height: height / 8,
                              width: 70,


                              child: Column(
                                children: [
                                  Text(listItem[index],
                                    style: TextStyle(
                                      fontSize: 19.0,
                                    ),),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text("$day",
                                    style: TextStyle(
                                      fontSize: 19.0,
                                    ),
                                  ),
                                ],
                              )
                          );
                        }),
                  ),
                ),
              )


                  : Container(
                color: Colors.deepPurpleAccent,
                height: height / 1.79,
                width: 700,
                child: Card(
                  elevation: 10,
                  color: Colors.indigo,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: listItem.length,
                        itemBuilder: (context, int index) {
                          return Container(
                              height: height/8,
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


Widget _buildCheckBoxPopupDialog(BuildContext context) {
  return new AlertDialog(
    title: const Text('Entry error!'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Fields cannot be empty"),
      ],
    ),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Close'),
      ),
    ],
  );
}
