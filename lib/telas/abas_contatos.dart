import 'package:flutter/material.dart';
import 'package:whatsapp/model/conversa.dart';

class AbaContatos extends StatefulWidget {
  const AbaContatos({super.key});

  @override
  State<AbaContatos> createState() => _AbaContatosState();
}

class _AbaContatosState extends State<AbaContatos> {
  List<Conversa> listaConversas = [
    Conversa("Ana Clara", "Olá, tudo bem?",
        "https://firebasestorage.googleapis.com/v0/b/peaceful-garden-352712.appspot.com/o/perfil%2Fperfil1.jpg?alt=media&token=949409ba-2503-4843-803d-31e8d2124e51"),
    Conversa("Maria", "Oi, tudo bem?",
        "https://firebasestorage.googleapis.com/v0/b/peaceful-garden-352712.appspot.com/o/perfil%2Fperfil3.jpg?alt=media&token=c12c89ef-bbf7-4530-bad1-66702d828c56"),
    Conversa("Pedro", "Olá, tudo bem?",
        "https://firebasestorage.googleapis.com/v0/b/peaceful-garden-352712.appspot.com/o/perfil%2Fperfil2.jpg?alt=media&token=92906c7d-e278-4c70-bf6c-11ddf66080b1"),
    Conversa("João", "Oi, tudo bem?",
        "https://firebasestorage.googleapis.com/v0/b/peaceful-garden-352712.appspot.com/o/perfil%2Fperfil4.jpg?alt=media&token=4cd2d8f4-4aaa-4223-9276-bd487a0b74fb"),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listaConversas.length,
        itemBuilder: (contex, index) {
          Conversa conversa = listaConversas[index];
          return ListTile(
            contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            leading: CircleAvatar(
              maxRadius: 30,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(conversa.caminhoFoto),
            ),
            title: Text(
              conversa.nome,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          );
        });
  }
}
