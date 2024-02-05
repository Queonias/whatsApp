import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _emailUsuario = "";

  Future _verificarUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    // auth.signOut();
    User? usuarioLogado = auth.currentUser;
    if (usuarioLogado != null) {
      final User? usuarioLogado = auth.currentUser;
      setState(() {
        _emailUsuario = usuarioLogado!.email!;
      });
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Login()));
    }
  }

  @override
  void initState() {
    _verificarUsuarioLogado();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff075e54),
        title: const Text('WhatsApp', style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        child: Column(
          children: [
            Text(
              _emailUsuario,
            ),
            TextButton(
              onPressed: () {
                FirebaseAuth auth = FirebaseAuth.instance;
                auth.signOut().then((_) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                });
              },
              child: const Text("Deslogar"),
            ),
          ],
        ),
      ),
    );
  }
}
