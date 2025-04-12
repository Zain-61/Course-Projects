import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import '../components/RoundedButton.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  late String _Email;
  late String _Password;
  bool _obscureText = true;
  String? _passwordError;
  bool showspiner=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showspiner,
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
                onChanged: (value) {
                  _Email = value;
                },
                decoration: kFeildProperty.copyWith(
                  hintText: 'Enter your email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                onChanged: (value) {
                  _Password = value;
                  setState(() {
                    _passwordError = _validatePassword(_Password);
                  });
                },
                decoration: kFeildProperty.copyWith(
                  hintText: 'Enter your password',
                  prefixIcon: Icon(Icons.password_sharp),
                  suffixIcon: IconButton(
                    icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  errorText: _passwordError,
                ),
                obscureText: _obscureText,
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                buttonText: 'Register',
                onPressedCallback: () async {
                  setState(() {
                    showspiner=true;
                  });
                  if (_passwordError == null) {
                    try {
                      final new_user = await _auth.createUserWithEmailAndPassword(
                          email: _Email, password: _Password);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => ChatScreen()),
                            (Route<dynamic> route) => false,
                      );
                      setState(() {
                        showspiner=false;
                      });
                    } catch (e) {
                      Navigator.pushNamed(context, 'Welcome');
                    }
                  }
                },
                buttonColor: Colors.blueAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _validatePassword(String password) {
    if (password.length < 6) {
      return 'Password should be at least 6 characters';
    } else if (password.length > 20) {
      return 'Password should not exceed 20 characters';
    } else {
      return null;
    }
  }
}
