import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status { Authenticated, Unauthenticated }

class AuthProvider with ChangeNotifier {
  bool isAuth=false;
  String userId="";
  User _user;
  Status _status = Status.Unauthenticated;

//  getter
  Status get status => _status;
  User get user => _user;

  // public variables
  final formkey = GlobalKey<FormState>();

  updateIsAuth(){
    isAuth=!isAuth;
    notifyListeners();
  }


  Future<bool> signIn(String email,String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      _status = Status.Unauthenticated;
      notifyListeners();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password)
          .then((value) async {
        await prefs.setString("id", value.user.uid);
      });
      _status=Status.Authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }
  Future<bool> signUp(String email,String password,String phoneNumber,String name) async {
    try {
      _status = Status.Unauthenticated;
      notifyListeners();
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: password)
          .then((result) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("id", result.user.uid);
        FirebaseFirestore.instance.collection('users').doc(result.user.uid).set({
          "id":result.user.uid,
          "name":name,
          "email":email,
          "password":password,
          "phone":phoneNumber,
        });
      });
      _status = Status.Authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future signOut() async {
    FirebaseAuth.instance.signOut();
    _status = Status.Unauthenticated;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  String validateEmail(String value) {
    value = value.trim();
    if (value != null) {
      if (value.isEmpty) {
        return 'Email can\'t be empty';
      } else if (!value.contains(RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
        return 'Enter a correct email address';
      }
    }
    return null;
  }
  authenticating()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('id')==null) {
      _status= Status.Unauthenticated;
      notifyListeners();
    } else {
      _status= Status.Authenticated;
      notifyListeners();
    }
  }

  getUuid()async{
    SharedPreferences  preferences=await SharedPreferences.getInstance();
    userId=preferences.getString("id");
    notifyListeners();
  }
}
