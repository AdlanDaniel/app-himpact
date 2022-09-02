import 'package:app_himpact/models/contato.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CadastrarDados extends StatefulWidget {
  const CadastrarDados({Key? key}) : super(key: key);

  @override
  State<CadastrarDados> createState() => _CadastrarDadosState();
}

class _CadastrarDadosState extends State<CadastrarDados> {
  TextEditingController nomeEC = TextEditingController();
  TextEditingController cpfEC = TextEditingController();
  TextEditingController idadeEC = TextEditingController();

  String mensagemErro = "erro";
  bool loading = false;

  String getIDdocument() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference contatos = db.collection("Contatos");
    String idContatos = contatos.doc().id;
    return idContatos;
  }

  ValidarCampos() {
    String nome = nomeEC.text;
    String cpf = cpfEC.text;
    int idade = int.parse(idadeEC.text);
    Contato contato =
        Contato(nome: nome, cpf: cpf, idade: idade, id: getIDdocument());

    if (nome.isNotEmpty) {
      if (idadeEC.text.isNotEmpty) {
        if (cpf.isNotEmpty) {
          salvarDados(contato);
        } else {
          mensagemErro = "Preencha o CPF";
        }
      } else {
        mensagemErro = "Preencha a idade";
      }
    } else {
      mensagemErro = "Preencha o  nome";
    }
  }

  salvarDados(Contato contato) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore bd = FirebaseFirestore.instance;
    try {
      setState(() {
        loading = true;
      });

      await bd
          .collection("Usuarios")
          .doc(auth.currentUser!.uid)
          .collection("Contatos")
          .doc(contato.id)
          .set({
        "nome": contato.nome,
        "idade": contato.idade,
        "cpf": contato.cpf,
        "id": contato.id,
      });
      setState(() {
        loading = false;
      });
      setState(() {
        mensagemErro = "Dados Cadastrados";
      });
      nomeEC.clear();
      idadeEC.clear();
      cpfEC.clear();
    } on FirebaseException catch (error) {
      setState(() {
        mensagemErro = "Erro no firebase";
      });
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar Dados "),
      ),
      body: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: TextFormField(
                    controller: nomeEC,
                    decoration: InputDecoration(labelText: "NOME COMPLETO"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: TextFormField(
                    controller: idadeEC,
                    decoration: InputDecoration(labelText: "IDADE"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: TextFormField(
                    controller: cpfEC,
                    decoration: InputDecoration(labelText: "CPF"),
                  ),
                ),
                loading == false
                    ? ElevatedButton(
                        onPressed: () {
                          ValidarCampos();
                        },
                        child: Text("Salvar"))
                    : CircularProgressIndicator(),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text(mensagemErro)],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
