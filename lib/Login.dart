import 'package:flutter/material.dart';
import './Strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginState();
  }
}

class _LoginState extends State {
  String _userID, _email, _password, _errorMessage, _message;
  bool _isLoading;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _success;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: <Widget>[_showBody()]));
  }


  // Phone Sign-In

  // E-mail and Password Sign In
  void _signInWithEmailAndPassword() async {
    final FirebaseUser user = await _auth
        .signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text)
        .catchError((error) {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    side: BorderSide(color: Colors.redAccent)),
                content: Text(_message),
                title: Text("Error"));
          });
    });
    if (user != null) {
      setState(() {
        _success = true;
        _email = user.email;
        Navigator.pushNamed(context, 'onboard');
      });
    } else {
      _success = false;
    }
  }

  // Google Sign In
  void _signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final FirebaseUser user = await _auth.signInWithCredential(credential);
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    currentUser.sendEmailVerification();
    setState(() {
      if (user != null) {
        _success = true;
      } else {
        _success = false;
      }
    });
  }

  Widget _displayLogo() {
    return Hero(
        tag: 'logohero',
        child: Center(
            child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 10),
                height: MediaQuery.of(context).size.height / 6,
                width: MediaQuery.of(context).size.width / 1.5,
                child: Image.asset(Strings.LoginScreen))));
  }

  Widget _displayLogoText() {
    return Center(
        child: Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 25),
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
                top: MediaQuery.of(context).size.height / 30,
                left: MediaQuery.of(context).size.width / 15,
                right: MediaQuery.of(context).size.width / 15),
            child: TextFormField(
              textAlign: TextAlign.left,
              cursorColor: Colors.black,
              cursorRadius: Radius.circular(20.0),
              cursorWidth: 6.0,
              textInputAction: TextInputAction.next,
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
                top: MediaQuery.of(context).size.height / 30,
                left: MediaQuery.of(context).size.width / 15,
                right: MediaQuery.of(context).size.width / 15,
                bottom: MediaQuery.of(context).size.width / 30),
            child: TextFormField(
              textInputAction: TextInputAction.done,
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

  Widget _showLoginButton() {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 16),
      child: RaisedButton(
          splashColor: Colors.white,
          shape:
              StadiumBorder(side: BorderSide(color: Colors.black, width: 2.0)),
          elevation: 5.0,
          child: Container(
              width: MediaQuery.of(context).size.width / 4,
              height: MediaQuery.of(context).size.height / 18,
              child: Center(
                  child: Text(
                Strings.SignIn,
                style: TextStyle(
                    fontSize: 24, fontFamily: "Baloo", color: Colors.black),
              ))),
          color: Colors.redAccent,
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              _signInWithEmailAndPassword();
            }
          }),
    );
  }

  Widget _showSignupButton() {
    return Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(Strings.DontHaveAnAccount,
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 16, color: Colors.black)),
            Container(
                height: MediaQuery.of(context).size.height / 35,
                width: MediaQuery.of(context).size.width / 4.2,
                child: RaisedButton(
                    onPressed: () {Navigator.pushNamed(context,'signup');},
                    splashColor: Colors.redAccent,
                    color: Colors.white,
                    elevation: 0.0,
                    shape: StadiumBorder(),
                    child:Text(Strings.SignUp,
                        textAlign: TextAlign.left,
                        style:
                        TextStyle(fontSize: 18, color: Colors.redAccent))))]));


  }

  Widget _showOtherMethods() {
    return Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(Strings.SignInUsing,
                style: TextStyle(fontSize: 18, color: Colors.black)),
            Hero(
                tag: 'phonetag',
                child: Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Material(
                      elevation: 0.0,
                      color: Colors.white,
                      child: IconButton(
                        tooltip: Strings.PhoneName,
                        iconSize: 5,
                        onPressed: () {
                          Navigator.pushNamed(context, 'phonelogin');
                        },
                        icon: Image.asset(
                          Strings.Phone,
                        ),
                      ),
                    ))),
            Container(
                margin: EdgeInsets.only(left: 5),
                child: Material(
                    elevation: 0.0,
                    color: Colors.white,
                    child: IconButton(
                      tooltip: Strings.GoogleName,
                      iconSize: 5,
                      onPressed: () {
                        _signInWithGoogle();
                      },
                      icon: Image.asset(
                        Strings.Google,
                      ),
                    ))),
            Container(
                margin: EdgeInsets.only(left: 5),
                child: IconButton(
                  tooltip: Strings.FacebookName,
                  iconSize: 5,
                  onPressed: () {},
                  icon: Image.asset(
                    Strings.Facebook,
                  ),
                ))
          ],
        ));
  }

  Widget _showErrorMessage() {
    if (_errorMessage != null) {
      return Text(_errorMessage,
          style: TextStyle(
            color: Colors.redAccent,
            fontFamily: "Baloo",
          ));
    } else {
      return Container(height: 0.0, width: 0.0);
    }
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
          _showLoginButton(),
          _showSignupButton(),
          _showOtherMethods(),
          _showErrorMessage()
        ]),
      )),
    );
  }

  Widget _showCircularIndicator() {
    if (_isLoading) {
      return CircularProgressIndicator();
    }
    return Container(height: 0.0, width: 0.0);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
