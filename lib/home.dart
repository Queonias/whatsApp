import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/login.dart';
import 'package:whatsapp/telas/abas_contatos.dart';
import 'package:whatsapp/telas/abas_conversas.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<String> itensMenu = ['Configuracoes', 'Deslogar'];
  Future _verificarUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? usuarioLogado = auth.currentUser;
    if (usuarioLogado != null) {
      setState(() {});
    } else {
      Navigator.pushNamed(context, '/login');
    }
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    _verificarUsuarioLogado();
  }

  _escolhaMenuItem(String escolha, context) {
    switch (escolha) {
      case 'Configuracoes':
        print('Configuracoes');
        break;
      case 'Deslogar':
        _deslogarUsuario(context);
        break;
    }
  }

  _deslogarUsuario(context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushNamedAndRemoveUntil(
        context, '/', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff075e54),
        title: const Text('WhatsApp', style: TextStyle(color: Colors.white)),
        bottom: TabBar(
            indicatorWeight: 4,
            labelStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            controller: _tabController,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey[400],
            tabs: const [
              Tab(text: "Conversas"),
              Tab(text: "Contatos"),
            ]),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String escolha) {
              _escolhaMenuItem(escolha, context);
            },
            itemBuilder: (BuildContext context) {
              return itensMenu.map((String escolha) {
                return PopupMenuItem<String>(
                  value: escolha,
                  child: Text(escolha),
                );
              }).toList();
            },
          )
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [AbaConversas(), AbaContatos()],
      ),
    );
  }
}
