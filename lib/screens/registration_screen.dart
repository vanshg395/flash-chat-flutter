import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../constants.dart';
import '../widgets/submit_button.dart';
import './chat_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const routeName = '/register';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                style: TextStyle(color: Colors.black),
                decoration: kAuthenticationTextFieldDecoration.copyWith(
                    hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                obscureText: true,
                style: TextStyle(color: Colors.black),
                decoration: kAuthenticationTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              Hero(
                tag: 'registerButton',
                child: SubmitButton(
                  'Register',
                  Colors.blueAccent,
                  () async {
                    if ((email == null) || (password == null)) {
                      return;
                    }
                    // print(email);
                    // print(password);
                    setState(() {
                      _isLoading = true;
                    });
                    try {
                      final response =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                      if (response != null) {
                        Navigator.of(context).pushNamed(ChatScreen.routeName);
                      }
                      setState(() {
                        _isLoading = false;
                      });
                    } catch (e) {
                      print(e.code);
                    }
                    _isLoading = false;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
