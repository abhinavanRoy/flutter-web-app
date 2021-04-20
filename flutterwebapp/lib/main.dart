import 'package:flutter/material.dart';
import 'package:flutterwebapp/Screens/RootScreen.dart';
import 'package:flutterwebapp/Screens/UserThoughts.dart';
import 'package:flutterwebapp/provider/app.dart';
import 'package:flutterwebapp/provider/auth.dart';
import 'package:provider/provider.dart';

import 'helper/constants.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization;
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: AppProvider()),
    ChangeNotifierProvider.value(value: AuthProvider.init()),
  ], child: MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(

      primarySwatch: Colors.deepPurple,
    ),
    home: AppScreenController(),

  ),
  ));
}

class AppScreenController extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    switch(authProvider.status){
      case Status.Unauthenticated:
        return RootScreen();
      case Status.Authenticating:
        return RootScreen();
      case Status.Authenticated:
        return UserThoughts();
      default:
        return RootScreen();
    }
  }
}
  /*runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.deepPurple,
      ),
      home: UserThoughts(),
    );
  }
}*/
