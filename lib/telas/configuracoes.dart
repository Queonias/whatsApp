import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Configuracoes extends StatefulWidget {
  const Configuracoes({super.key});

  @override
  State<Configuracoes> createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {
  final TextEditingController _controllerNome = TextEditingController();
  late String _idUsuarioLogado;
  File? _imagem;
  bool _subindoImagem = false;
  String? urlImagemRecuperada;

  Future _recuperarImagem(String origemImagem) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? imagemSelecionada;
    switch (origemImagem) {
      case "camera":
        imagemSelecionada =
            await imagePicker.pickImage(source: ImageSource.camera);
        break;
      case "galeria":
        imagemSelecionada =
            await imagePicker.pickImage(source: ImageSource.gallery);
        break;
    }

    if (imagemSelecionada != null) {
      File file = File(imagemSelecionada.path);
      setState(() {
        _imagem = file;
      });
    }

    if (_imagem != null) {
      setState(() {
        _subindoImagem = true;
      });
      _uploadImagem(_imagem);
    }
  }

  Future _uploadImagem(imagem) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference pastaRaiz = storage.ref();
    Reference arquivo =
        pastaRaiz.child("perfil").child("$_idUsuarioLogado.jpg");

    UploadTask task = arquivo.putFile(imagem);
    task.snapshotEvents.listen((TaskSnapshot snapshot) {
      if (snapshot.state == TaskState.running) {
        setState(() {
          _subindoImagem = true;
        });
      } else if (snapshot.state == TaskState.success) {
        setState(() {
          _subindoImagem = false;
        });
      }
    });

    try {
      await task;
      String url = await arquivo.getDownloadURL();
      setState(() {
        urlImagemRecuperada = url;
      });
      // Agora você pode usar a URL da imagem, por exemplo, armazená-la no Firestore ou exibi-la no app.
    } catch (e) {
      print('Erro ao obter a URL da imagem: $e');
    }
  }

  _recuperarDadosUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? usuarioLogado = auth.currentUser;
    _idUsuarioLogado = usuarioLogado!.uid;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _recuperarDadosUsuario();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _subindoImagem ? const CircularProgressIndicator() : Container(),
              CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.grey,
                  backgroundImage: urlImagemRecuperada == null
                      ? null
                      : NetworkImage(urlImagemRecuperada!)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                      onPressed: () {
                        _recuperarImagem("camera");
                      },
                      child: Text("Câmera")),
                  TextButton(
                      onPressed: () {
                        _recuperarImagem("galeria");
                      },
                      child: Text("Galeria")),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextField(
                  controller: _controllerNome,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                    hintText: "Nome",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 10),
                child: ElevatedButton(
                  onPressed: () {
                    // _validarCampos();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff25d366),
                    padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                  child: const Text(
                    "Salvar",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
