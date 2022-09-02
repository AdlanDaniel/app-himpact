import 'package:app_himpact/Login.dart';
import 'package:app_himpact/cadastrar_dados.dart';
import 'package:app_himpact/listar_contatos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PagInicial extends StatefulWidget {
  const PagInicial({Key? key}) : super(key: key);

  @override
  State<PagInicial> createState() => _PagInicialState();
}

class _PagInicialState extends State<PagInicial> {
  

  dialogoDeslogado() async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Usuario deslogado"),
          );
        });
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => Login()), (route) => false);
  }

  deslogar() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await auth.signOut();
      User? usuarioAtual = auth.currentUser;
      if (usuarioAtual == null) {
        dialogoDeslogado();
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Usuario nao deslogado"),
              );
            });
      }
    } catch (error) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Erro ao deslogar"),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                deslogar();
              },
              icon: Icon(Icons.logout)),
        ],
        title: Text("Pagina Inicial"),
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CadastrarDados()));
                    },
                    child: Text("Cadastrar Contatos"))
              ],
            ),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListarContatos()));
                    },
                    child: Text("Listar Contatos"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
