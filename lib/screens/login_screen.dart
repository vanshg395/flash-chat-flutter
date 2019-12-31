import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../constants.dart';
import '../widgets/submit_button.dart';
import './chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                onChanged: (value) {
                  password = value;
                },
                style: TextStyle(color: Colors.black),
                obscureText: true,
                decoration: kAuthenticationTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              Hero(
                tag: 'loginButton',
                child: SubmitButton(
                  'Log In',
                  Colors.lightBlueAccent,
                  () async {
                    if ((email == null) || (password == null)) {
                      return;
                    }
                    try {
                      setState(() {
                        _isLoading = true;
                      });
                      final response = await _auth.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      if (response != null) {
                        Navigator.of(context).pushNamed(ChatScreen.routeName);
                      }
                      setState(() {
                        _isLoading = false;
                      });
                    } catch (e) {
                      print(e.code);
                    }
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
