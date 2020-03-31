import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './Strings.dart';
final FirebaseAuth _auth = FirebaseAuth.instance;
class SignUp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SignUpState();
  }
}
class _SignUpState extends State {

  String _userID, _email, _password, _errorMessage, _message, _confpassword;
  bool _isLoading;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confpasswordController = TextEditingController();
  bool _success;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: <Widget>[_showBody()]));
  }


  Widget _displayLogo() {
    return  Center(
            child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery
                        .of(context)
                        .size
                        .height / 10),
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 6,
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 1.5,
                child: Image.asset(Strings.Friends)));
  }

  Widget _displayLogoText() {
    return Center(
        child: Container(
            margin:
            EdgeInsets.only(top: MediaQuery
                .of(context)
                .size
                .height / 25),
            child: Text(
              Strings.OnBoardPageOneTitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 54, fontFamily: "Baloo"),
            )));
  }

  Widget _displayEmail() {
    return Center(
        child: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery
                    .of(context)
                    .size
                    .height / 30,
                left: MediaQuery
                    .of(context)
                    .size
                    .width / 15,
                right: MediaQuery
                    .of(context)
                    .size
                    .width / 15),
            child: TextFormField(
              textAlign: TextAlign.left,
              cursorColor: Colors.black,
              cursorRadius: Radius.circular(20.0),
              cursorWidth: 6.0,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                  fontFamily: "Baloo", color: Colors.black, fontSize: 24),
              decoration: InputDecoration(
                  prefixIcon: Container(
                    child: Image.asset(Strings.EmailIcon, width: 2, height: 2),
                    margin: EdgeInsets.only(right: 8.0),
                  ),
                  errorBorder:
                  UnderlineInputBorder(borderSide: BorderSide(width: 4.0)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 4.0)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.redAccent, width: 4.0)),
                  disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 4.0)),
                  labelText: Strings.Email,
                  labelStyle: TextStyle(
                      fontFamily: "Baloo",
                      color: Colors.redAccent,
                      fontSize: 32),
                  contentPadding: EdgeInsets.all(2.0)),
              controller: _emailController,
              validator: (value) =>
              value.isEmpty ? Strings.EmailCantBeEmpty : null,
              onSaved: (value) => _email = value,
            )));
  }

  Widget _displayPassword() {
    return Center(
        child: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery
                    .of(context)
                    .size
                    .height / 30,
                left: MediaQuery
                    .of(context)
                    .size
                    .width / 15,
                right: MediaQuery
                    .of(context)
                    .size
                    .width / 15,
                bottom: MediaQuery
                    .of(context)
                    .size
                    .width / 30),
            child: TextFormField(
              textAlign: TextAlign.left,
              cursorColor: Colors.black,
              cursorRadius: Radius.circular(20.0),
              cursorWidth: 6.0,
              keyboardType: TextInputType.text,
              obscureText: true,
              style: TextStyle(
                  fontFamily: "Baloo", color: Colors.black, fontSize: 24),
              decoration: InputDecoration(
                  prefixIcon: Container(
                    child: Image.asset(Strings.KeyIcon, width: 2, height: 2),
                    margin: EdgeInsets.only(right: 8.0),
                  ),
                  errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 4.0)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 4.0)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.redAccent, width: 4.0)),
                  disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 4.0)),
                  labelText: Strings.Password,
                  labelStyle: TextStyle(
                      fontFamily: "Baloo",
                      color: Colors.redAccent,
                      fontSize: 32),
                  contentPadding: EdgeInsets.all(2.0)),
              controller: _passwordController,
              validator: (value) =>
              value.isEmpty ? Strings.PassCantBeEmpty : null,
              onSaved: (value) => _password = value,
            )));
  }

  Widget _displayConfPassword() {
    return Center(
        child: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery
                    .of(context)
                    .size
                    .height / 30,
                left: MediaQuery
                    .of(context)
                    .size
                    .width / 15,
                right: MediaQuery
                    .of(context)
                    .size
                    .width / 15,
                bottom: MediaQuery
                    .of(context)
                    .size
                    .width / 30),
            child: TextFormField(
              textAlign: TextAlign.left,
              cursorColor: Colors.black,
              cursorRadius: Radius.circular(20.0),
              cursorWidth: 6.0,
              keyboardType: TextInputType.text,
              obscureText: true,
              style: TextStyle(
                  fontFamily: "Baloo", color: Colors.black, fontSize: 24),
              decoration: InputDecoration(
                  prefixIcon: Container(
                    child: Image.asset(Strings.KeyIcon, width: 2, height: 2),
                    margin: EdgeInsets.only(right: 8.0),
                  ),
                  errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 4.0)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 4.0)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.redAccent, width: 4.0)),
                  disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 4.0)),
                  labelText: Strings.ConfirmPassword,
                  labelStyle: TextStyle(
                      fontFamily: "Baloo",
                      color: Colors.redAccent,
                      fontSize: 32),
                  contentPadding: EdgeInsets.all(2.0)),
              controller: _confpasswordController,
              validator: (value) =>
              value.isEmpty ? Strings.PassCantBeEmpty : null,
              onSaved: (value) => _confpassword = value,
            )));
  }


  Widget _showBody() {
    return SingleChildScrollView(
      child: Container(
          child: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              _displayLogo(),
              _displayLogoText(),
              _displayEmail(),
              _displayPassword(),
              _displayConfPassword(),
              _showSignUpButton(),
            ]),
          )),
    );
  }
  Widget _showSignUpButton() {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery
          .of(context)
          .size
          .height / 16),
      child: RaisedButton(
          splashColor: Colors.white,
          shape:
          StadiumBorder(side: BorderSide(color: Colors.black, width: 2.0)),
          elevation: 5.0,
          child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 4,
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 18,
              child: Center(
                  child: Text(
                    Strings.SignUp,
                    style: TextStyle(
                        fontSize: 24, fontFamily: "Baloo", color: Colors.black),
                  ))),
          color: Colors.redAccent,
          onPressed: () async {
            if (_formKey.currentState.validate() &&
                _passwordController.text == _confpasswordController.text) {
              //_signInWithEmailAndPassword();
            }
          }),
    );
  }
  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Example code for registration.
  void _register() async {
    final FirebaseUser user = await _auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (user != null) {
      setState(() {
        _success = true;
        _email = user.email;
      });
    } else {
      _success = false;
    }
  }
}

