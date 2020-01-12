import 'dart:math';

import 'package:brew_crew/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Create user object based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //Auth change user stream
  //Escuchamos cuando nuestro usuario cambia
  //Y envia la informacion resultante a nuestro
  //provider
  Stream<User> get user {
    return _auth.onAuthStateChanged.map((FirebaseUser user) =>
        _userFromFirebaseUser(user)); //Pendiente como usar map
    //.map(_userFromFirebaseUser) es lo mismo que lo de arriba
  }

  //Sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      //print("El resultado de autenticacion es: ${ result.user}");
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign in with email & password
  Future<User> logInWithEmailAndPassword({email, password}) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print("Error Login: ${e.toString()}");
      return null;
    }
  }
  //Register with email & password
  Future registerWithEmailAndPassword({String email, String password}) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);    
    } catch (e) {
      print("Error AuthService: ${e.toString()}");
      return null;
    }
  }

  //Sign out
  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
