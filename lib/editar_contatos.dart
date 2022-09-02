import 'package:app_himpact/models/contato.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditarContatos extends StatefulWidget {
  final Contato contato;
  const EditarContatos({Key? key, required this.contato}) : super(key: key);

  @override
  State<EditarContatos> createState() => _EditarContatosState();
}

class _EditarContatosState extends State<EditarContatos> {
  TextEditingController nomeEC = TextEditingController();
  TextEditingController idadeEC = TextEditingController();
  TextEditingController cpfEC = TextEditingController();
  TextEditingController idEC = TextEditingController();

  

  salvarEdicao() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;

    Contato contact = Contato(
        nome: nomeEC.text,
        idade: int.parse(idadeEC.text),
        cpf: cpfEC.text,
        id: idEC.text);
    db
        .collection("Usuarios")
        .doc(auth.currentUser!.uid)
        .collection("Contatos")
        .doc(widget.contato.id)
        .update(contact.toMap());
  }

  @override
  void initState() {
    nomeEC.text = widget.contato.nome!;
    idadeEC.text = widget.contato.idade.toString();
    cpfEC.text = widget.contato.cpf!;
    idEC.text = widget.contato.id!;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Contatos'), ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 80,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: TextFormField(
                    controller: nomeEC,
                    decoration: InputDecoration(
                      label: Text("Nome"),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: TextFormField(
                    controller: idadeEC,
                    decoration: InputDecoration(
                      label: Text("Idade"),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: TextFormField(
                    controller: cpfEC,
                    decoration: InputDecoration(
                      label: Text("CPF"),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: TextFormField(
                    controller: idEC,
                    decoration: InputDecoration(
                      label: Text("ID"),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: ElevatedButton(
                      onPressed: () {
                        salvarEdicao();
                      },
                      child: Text("Salvar")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
