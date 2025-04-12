import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import '../components/RoundedButton.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String _Email;
  late String _Password;
  bool _obscureTextt = true;
  bool showspiner=false;

  @override
  Widget build(BuildContext context) {
    bool _obscureText = true;
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
                },
                decoration: kFeildProperty.copyWith(
                  hintText: 'Enter your password',
                  prefixIcon: Icon(Icons.password_sharp),
                  suffixIcon: IconButton(
                    icon: Icon(
                        _obscureTextt ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _obscureTextt = !_obscureTextt;
                      });
                    },
                  ),
                ),
                obscureText: _obscureTextt,
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                  buttonText: 'Log In',
                  buttonColor: Colors.lightBlueAccent,
                  onPressedCallback: () async {
                    setState(() {
                      showspiner=true;
                    });
                    try {
                      final _user = await _auth.signInWithEmailAndPassword(
                          email: _Email, password: _Password);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => ChatScreen()),
                        (Route<dynamic> route) => false,
                      );
                    } catch (e) {
                      Navigator.pushNamed(context, 'Welcome');
                    }
                    setState(() {
                      showspiner=false;
                    });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
