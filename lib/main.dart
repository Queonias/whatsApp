import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:whatsapp/login.dart';
import 'package:whatsapp/home.dart'; // Importe a tela Home
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Realiza a verificação de login antes de construir o widget MyApp
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? usuarioLogado = auth.currentUser;
  Widget initialWidget;
  if (usuarioLogado != null) {
    initialWidget =
        const Home(); // Redireciona para a tela Home se o usuário estiver logado
  } else {
    initialWidget =
        const Login(); // Exibe a tela de login se o usuário não estiver logado
  }

  runApp(MyApp(initialWidget: initialWidget));
}

class MyApp extends StatelessWidget {
  final Widget initialWidget;

  const MyApp({Key? key, required this.initialWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff075e54),
          primary: const Color(0xff075e54),
          // secondary: const Color(0xff25d366),
        ),
        useMaterial3: true,
      ),
      home:
          initialWidget, // Utiliza o widget inicial determinado durante a verificação de login
    );
  }
}
