import 'package:flutter/material.dart';
import './OnBoarding.dart';
import './Login.dart';
import './PhoneLogin.dart';
import './SignUp.dart';
void main() => runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/':(context)=>MainApp(),
        'onboard':(context)=>OnBoarding(),
        'login':(context)=> Login(),
        'signup':(context)=>SignUp(),
        'phonelogin':(context)=>PhoneLogin()
      },
      debugShowCheckedModeBanner: false,
    ));
class MainApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return OnBoarding();
  }
}


