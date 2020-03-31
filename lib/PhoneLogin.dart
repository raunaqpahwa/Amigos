import 'package:flutter/material.dart';
import './Strings.dart';
import 'package:firebase_auth/firebase_auth.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;

class PhoneLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PhoneLoginState();
  }
}

class _PhoneLoginState extends State {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();
  String _message = '';
  String _verificationId;
  String _phone, _verification;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: <Widget>[_showBody()]));
    ;
  }


  Widget _displayLogo() {
    return Hero(
        tag: 'phonetag',
        child: Center(
            child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 10),
                height: MediaQuery.of(context).size.height / 6,
                width: MediaQuery.of(context).size.width / 1.5,
                child: Image.asset(Strings.PhoneLarge))));
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

  Widget _displayPhone() {
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
              keyboardType: TextInputType.phone,
              style: TextStyle(
                  fontFamily: "Baloo", color: Colors.black, fontSize: 24),
              decoration: InputDecoration(
                  prefixIcon: Container(
                    child: Image.asset(Strings.SimplePhone, width: 2, height: 2),
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
                  labelText: Strings.PhoneNumber,
                  labelStyle: TextStyle(
                      fontFamily: "Baloo",
                      color: Colors.redAccent,
                      fontSize: 32),
                  contentPadding: EdgeInsets.all(2.0)),
              controller: _phoneNumberController,
              validator: (value) =>
              value.isEmpty ? Strings.EmailCantBeEmpty : null,
              onSaved: (value) => _phone = value,
            )));
  }

  Widget _showVerifyButton() {
    return Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 16),
        child: RaisedButton(
            splashColor: Colors.white,
            shape: StadiumBorder(
                side: BorderSide(color: Colors.black, width: 2.0)),
            elevation: 5.0,
            child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 18,
                child: Center(
                    child: Text(
                  Strings.GetVerification,
                  style: TextStyle(
                      fontSize: 24, fontFamily: "Baloo", color: Colors.black),
                ))),
            color: Colors.redAccent,
            onPressed: () async {
              if(_formKey.currentState.validate())
              _verifyPhoneNumber();
            }));
  }

  Widget _displayVerification() {
    return Center(
        child: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 30,
                left: MediaQuery.of(context).size.width / 15,
                right: MediaQuery.of(context).size.width / 15,
                bottom: MediaQuery.of(context).size.width / 30),
            child: TextFormField(
              textAlign: TextAlign.left,
              cursorColor: Colors.black,
              cursorRadius: Radius.circular(20.0),
              cursorWidth: 6.0,
              keyboardType: TextInputType.number,
              obscureText: true,
              controller: _smsController,
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
                  labelText: Strings.VerificationCode,
                  labelStyle: TextStyle(
                      fontFamily: "Baloo",
                      color: Colors.redAccent,
                      fontSize: 32),
                  contentPadding: EdgeInsets.all(2.0)),
              validator: (value) =>
                  value.isEmpty ? Strings.VerificationCantBeEmpty : null,
              onSaved: (value) => _verification = value,
            )));
  }

  Widget _showLoginButton() {
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
                .height / 16,
            child: Center(
                child: Text(
                  Strings.SignIn,
                  style: TextStyle(
                      fontSize: 24, fontFamily: "Baloo", color: Colors.black),
                ))),
        color: Colors.redAccent,
        onPressed: () async {
          if(_formKey.currentState.validate())
          _signInWithPhoneNumber();
        },
      ),
    );
  }

  void _verifyPhoneNumber() async {
    setState(() {
      _message = '';
    });
    final PhoneVerificationCompleted verificationCompleted =
        (FirebaseUser user) {
      setState(() {
        _message = 'signInWithPhoneNumber auto succeeded: $user';
      });
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      setState(() {
        _message =
            'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}';
      });
    };
    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      Scaffold.of(context).showSnackBar(SnackBar(
        content:
            const Text('Please check your phone for the verification code.'),
      ));
      _verificationId = verificationId;
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
    };
    await _auth.verifyPhoneNumber(
        phoneNumber: _phoneNumberController.text,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  // Example code of how to sign in with phone.
  void _signInWithPhoneNumber() async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: _verificationId,
      smsCode: _smsController.text,
    );
    final FirebaseUser user = await _auth.signInWithCredential(credential);
    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    setState(() {
      if (user != null) {
        _message = 'Successfully signed in, uid: ' + user.uid;
      } else {
        _message = 'Sign in failed';
      }

    });

  }

  Widget _showBody() {
    return SingleChildScrollView(
        child: Container(
            child: Form(
              key: _formKey,
                child: Column(children: <Widget>[
                  _displayLogo(),
                  _displayLogoText(),
                  _displayPhone(),
                  _showVerifyButton(),
                  _displayVerification(),
                  _showLoginButton()
                ]))));
  }
  @override
  void dispose(){
    _smsController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }
}
