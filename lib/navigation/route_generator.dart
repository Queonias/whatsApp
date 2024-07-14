import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:whatsapp/home.dart';
import 'package:whatsapp/login.dart';

List<Route<dynamic>> onGenerateInitialRoutes(String initialRouteName) {
  bool isLoggedIn = checkUserLoggedIn();

  if (isLoggedIn) {
    return [
      MaterialPageRoute(
        builder: (context) => const Home(),
        settings: const RouteSettings(name: '/home'),
      ),
    ];
  } else {
    return [
      MaterialPageRoute(
        builder: (context) => const Login(),
        settings: const RouteSettings(name: '/login'),
      ),
    ];
  }
}

bool checkUserLoggedIn() {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? usuarioLogado = auth.currentUser;
  if (usuarioLogado != null) return true;
  return false;
}
