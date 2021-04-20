import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterwebapp/Screens/UserThoughts.dart';
import 'package:flutterwebapp/provider/app.dart';
import 'package:flutterwebapp/provider/auth.dart';
import 'package:provider/provider.dart';
import 'package:nb_utils/nb_utils.dart';
class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    final AppProvider appProvider = Provider.of<AppProvider>(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool isSmall = width <356;
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: isSmall? Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              Container(
                height: 250,
                width:  400,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 15,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "WELCOME TO THOUGHT KEEPER",
                          style: TextStyle(
                            color: Colors.deepPurpleAccent,
                            fontSize: width / 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Your Thoughts in one place ",
                        style: TextStyle(
                          color: Colors.deepPurpleAccent,
                          fontSize: width/17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(_createRoute());
                        },
                        child: Text(
                          "Google sign in",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )
      
      
      
      
      
      :Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              Container(
                height: 250,
                width:  400,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 15,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "WELCOME TO THOUGHT KEEPER",
                          style: TextStyle(
                            color: Colors.deepPurpleAccent,
                            fontSize: 21.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Your Thoughts in one place ",
                        style: TextStyle(
                          color: Colors.deepPurpleAccent,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          appProvider.changeLoading();
                          Map result = await authProvider.signInWithGoogle();
                          bool success = result['success'];
                          String message = result['message'];
                          print(message);

                          if(!success){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Could not sign you in!")));
                            appProvider.changeLoading();
                          }
                          else{
                            appProvider.changeLoading();
                            Navigator.of(context).pushReplacement(_createRoute());
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully Signed in")));

                          }



                        },
                        child: Text(
                          "Google sign in",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => UserThoughts(),
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
