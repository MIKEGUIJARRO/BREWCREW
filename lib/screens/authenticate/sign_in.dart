import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toogleView;
  SignIn({this.toogleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;


  // TextFieldState
  String email = "";
  String password = "";

  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Sign in to Brew Crew"),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text("Register"),
            onPressed: () {
              widget.toogleView();
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Email"),
                validator: (val)=> val.isEmpty ? "Enter an email" : null,
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Password"),
                validator: (val)=> val.length > 6 ? "Enter a password 6+ chars long" : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  "Sign in",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      loading = true;
                    });
                    print(email);
                    print(password);
                    dynamic result = await _authService.logInWithEmailAndPassword(
                      email: email, password: password);
                    if (result == null) { //Email Invalido, aun no se registra
                      setState((){
                        error = "The email or password are incorrect";
                        loading = false;
                      });
                    }
                  }
                },
              ),
              Text(error, style: TextStyle(color: Colors.red),),
            ],
          ),
        ),
      ),
    );
  }
}
