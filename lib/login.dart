import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/cadastro.dart';
import 'package:whatsapp/home.dart';
import 'package:whatsapp/model/usuario.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerSenha = TextEditingController();

  void _validarCampos() {
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;
    if (email.isNotEmpty && email.contains("@")) {
      if (senha.isNotEmpty) {
        Usuario usuario = Usuario();
        usuario.email = email;
        usuario.senha = senha;
        _logarUsuario(usuario);
      } else {
        setState(() {
          const snackBar = SnackBar(
            content: Text("Preencha a senha!"),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      }
    } else {
      setState(() {
        const snackBar = SnackBar(
          content: Text("Preencha o e-mail utilizando @"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    }
  }

  _logarUsuario(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth
        .signInWithEmailAndPassword(
            email: usuario.email, password: usuario.senha)
        .then((firebaseUser) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Home()));
    }).catchError((error) {
      setState(() {
        const snackBar = SnackBar(
          content:
              Text("Erro ao autenticar usuário, verifique e-mail e senha!"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(color: Color(0xff075e54)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Image.asset("imagens/logo.png", height: 180),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerEmail,
                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "E-mail",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32)),
                    ),
                  ),
                ),
                TextField(
                  controller: _controllerSenha,
                  obscureText: true,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                    hintText: "Senha",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      _validarCampos();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff25d366),
                      padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    child: const Text(
                      "Entrar",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                Center(
                  child: GestureDetector(
                    child: const Text(
                      "Não tem conta? Cadastre-se!",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Cadastro()));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
