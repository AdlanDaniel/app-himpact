import 'dart:convert';

import 'package:app_himpact/detalhes_contatos.dart';
import 'package:app_himpact/editar_contatos.dart';
import 'package:app_himpact/models/contato.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ListarContatos extends StatefulWidget {
  const ListarContatos({Key? key}) : super(key: key);

  @override
  State<ListarContatos> createState() => _ListarContatosState();
}

class _ListarContatosState extends State<ListarContatos> {
  @override
  void initState() {
    super.initState();
    xy = recuperarContatos();
  }

  var xy;

  atualizarEdicao() async {}

  editContact(Contato contato) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => EditarContatos(
                  contato: contato,
                ))));
  }

  deletarContatos(Contato contato) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      db
          .collection("Usuarios")
          .doc(auth.currentUser!.uid)
          .collection("Contatos")
          .doc(contato.id)
          .delete();

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Contato deletado")));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Erro ao deletar")));
    }
  }

  Future<QuerySnapshot> recuperarContatos() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;

    QuerySnapshot dadosMap = await db
        .collection("Usuarios")
        .doc(auth.currentUser!.uid)
        .collection("Contatos")
        .get();

    // for (QueryDocumentSnapshot item in dadosMap.docs) {
    //   var dados = item.data() as Map<String, dynamic>;

    //   Contato contatos = Contato.fromMap(dados);
    //   listContat.add(contatos);
    // }
    return dadosMap;
  }

  // // List<Contato> listaContatos = [
  // //   Contato(nome: "Enio", idade: 29, cpf: "0000", id: "1234"),
  // //   Contato(nome: "Daniel", idade: 31, cpf: "1111", id: "4321"),
  // //   Contato(nome: "Levi", idade: 30, cpf: "2222", id: "1423"),
  // //   Contato(nome: "Lucia", idade: 65, cpf: "33333", id: "555555")
  // ];

  List<Contato> listContat = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Lista de Contatos"), actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  xy = recuperarContatos();
                });
              },
              icon: Icon(Icons.refresh))
        ]),
        body: FutureBuilder<QuerySnapshot>(
          future: xy,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              List<QueryDocumentSnapshot<Object?>>? queryDocuments =
                  snapshot.data?.docs;

              if (!snapshot.hasData) {
                return Center(
                  child: Text('Nenhum usuario'),
                );
              } else {
                return ListView.builder(
                  itemCount: queryDocuments!.length,
                  itemBuilder: (context, index) {
                    List<Map<String, dynamic>> a = queryDocuments
                        .map((e) => e.data() as Map<String, dynamic>)
                        .toList();
                    Map<String, dynamic> b = a[index];

                    Contato contatos = Contato.fromMap(b);

                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetalhesContatos(
                                        contatos,
                                      )));
                        },
                        child: Dismissible(
                          confirmDismiss: (direction) async {
                            if (direction == DismissDirection.endToStart) {
                              deletarContatos(contatos);
                              return true;
                            } else {
                              editContact(contatos);

                              return false;
                            }
                          },
                          secondaryBackground: Container(
                            padding: EdgeInsets.all(16),
                            color: Colors.red,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                          background: Container(
                            padding: EdgeInsets.all(16),
                            color: Colors.green,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                          direction: DismissDirection.horizontal,
                          key: Key(contatos.nome!),
                          child: Card(
                            child: ListTile(
                              title: Text(contatos.nome!),
                              subtitle: Text(contatos.cpf!),
                              leading: Icon(
                                Icons.person,
                                size: 50,
                              ),
                              trailing: Icon(Icons.keyboard_arrow_right),
                            ),
                          ),
                        ));
                  },
                );
              }
            }

            return Container(
              child: Text("arrombado"),
            );
          },
        )
        // ListView.builder(
        //   itemCount: listContat.length,
        //   itemBuilder: (context, index) {
        //     Contato contact = listContat[index];
        //     return ListTile(
        //         title: Text(contact.nome!),
        //         subtitle: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text(contact.idade.toString()),
        //             Text(contact.cpf!),
        //             Text(contact.id!)
        //           ],
        //         ));
        //   },
        // ),
        );
  }
}
