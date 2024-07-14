import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:whatsapp/navigation/route_generator.dart';
import 'package:whatsapp/navigation/on_generate_initial_routes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    title: 'Flutter Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xff075e54),
        primary: const Color(0xff075e54),
      ),
      useMaterial3: true,
    ),
    onGenerateInitialRoutes: onGenerateInitialRoutes,
    onGenerateRoute: RouteGenerator.generateRoute,
  ));
}
