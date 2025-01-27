import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

@immutable
class GetUserInformation {
  GetUserInformation._();

  static String getUserUid() {
    FirebaseAuth auth;
    User? user;
    auth = FirebaseAuth.instance;
    user = auth.currentUser;
    return user!.uid.toString();
  }
}
