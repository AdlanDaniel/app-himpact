import 'package:app_himpact/paginaInicial.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  TextEditingController nomeEC = TextEditingController();
  TextEditingController emailEC = TextEditingController();
  TextEditingController senhaEC = TextEditingController();
  String mensagemErro = "";

  validarCampos() {
    String nome = nomeEC.text;
    String email = emailEC.text;
    String senha = senhaEC.text;

    if (nome.isNotEmpty) {
      if (email.isNotEmpty && email.contains("@")) {
        if (senha.isNotEmpty && senha.length >= 6) {
          cadastrarUsuario(nome, email, senha);
        } else {
          setState(() {
            mensagemErro = "Digite a senha com no mínimo 6 caracteres";
          });
        }
      } else {
        setState(() {
          mensagemErro = "Digite o email com caracter @";
        });
      }
    } else {
      setState(() {
        mensagemErro = "Digite o nome";
      });
    }
  }

  cadastrarUsuario(String nome, String email, String senha) {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth
        .createUserWithEmailAndPassword(email: email, password: senha)
        .then((FirebaseUser) {
      FirebaseFirestore db = FirebaseFirestore.instance;
      db.collection("Usuarios").doc(FirebaseUser.user?.uid).set({
        "nome": nome,
        "email": email,
        "id": FirebaseUser.user?.uid,
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PagInicial()));
    }).catchError((error) {
      setState(() {
        mensagemErro = "Erro ao cadastrar usuario";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CADASTRO"),
      ),
      body: Container(
        child: Column(
          children: [
            TextFormField(
              controller: nomeEC,
              decoration: InputDecoration(
                labelText: "Nome",
              ),
            ),
            TextFormField(
              controller: emailEC,
              decoration: InputDecoration(
                labelText: "Email",
              ),
            ),
            TextFormField(
              controller: senhaEC,
              decoration: InputDecoration(
                labelText: "Senha",
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  validarCampos();
                },
                child: Text("Cadastrar")),
            Text(mensagemErro),
          ],
        ),
      ),
    );
  }
}
