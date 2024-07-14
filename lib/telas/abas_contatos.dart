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
        "https://firebasestorage.googleapis.com/v0/b/whatsapp-b70ec.appspot.com/o/perfil%2Fperfil1.jpg?alt=media&token=d10201d8-bcdb-4344-88ce-d09dda5f4616"),
    Conversa("Maria", "Oi, tudo bem?",
        "https://firebasestorage.googleapis.com/v0/b/whatsapp-b70ec.appspot.com/o/perfil%2Fperfil3.jpg?alt=media&token=7de4ddb3-d73a-4415-b55c-8d87f1e9ec99"),
    Conversa("Pedro", "Olá, tudo bem?",
        "https://firebasestorage.googleapis.com/v0/b/whatsapp-b70ec.appspot.com/o/perfil%2Fperfil2.jpg?alt=media&token=d3096179-a541-47dd-b380-5f6c41d6b265"),
    Conversa("João", "Oi, tudo bem?",
        "https://firebasestorage.googleapis.com/v0/b/whatsapp-b70ec.appspot.com/o/perfil%2Fperfil4.jpg?alt=media&token=151320be-c564-4984-bd83-25137b0a6777"),
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
