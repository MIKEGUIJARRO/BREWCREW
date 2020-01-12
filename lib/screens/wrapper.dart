import 'package:brew_crew/screens/authenticate/authenticate.dart';
import 'package:brew_crew/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //Usamos provider para acceder de manera hereditaria a este valor. 
    final user = Provider.of<User>(context);
    print(user);

    //Return either Home or Authenticate Widget
    if(user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}