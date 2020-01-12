import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

import 'package:brew_crew/services/auth.dart';
import '../../shared/constants.dart';

class Register extends StatefulWidget {
  
  final Function toogleView;
  Register({this.toogleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //Text field state
  String email;
  String password;

  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() :Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Sign up to Brew Crew"),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text("Sign in"),
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
                //Regresar el valor null significa que esta bien
                validator: (val) => val.isEmpty ? "Enter an email" : null,
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
                //Regresar el valor null significa que esta bien
                validator: (val) =>
                    val.length < 6 ? "Enter a password 6+ chars long" : null,
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
                  "Register",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      loading = true;
                    });
                    print(email);
                    print(password);
                    dynamic result =
                        await _authService.registerWithEmailAndPassword(
                            email: email, password: password);
                     if (result == null) {
                       setState(()=> error = "Please supply a valid email");
                        loading = false;
                     }       
                  }
                },
              ),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
            ],
          ),
        ),
        //Codigo registro anonimo
        /* RaisedButton(
          onPressed: () async {
            dynamic result = await _authService.signInAnon();
            if (result == null){
              print("Error sign in");
            } else {
              print("signed in");
              print(result.uid);
            }
          },
          child: Text("Sign in anon"),
        ), */
      ),
    );
  }
}
