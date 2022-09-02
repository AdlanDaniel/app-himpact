import 'package:app_himpact/models/contato.dart';
import 'package:flutter/material.dart';

class DetalhesContatos extends StatefulWidget {
  final Contato contato;
  // const DetalhesContatos({Key? key, required this.contato}) : super(key: key);
  DetalhesContatos(this.contato);
  @override
  State<DetalhesContatos> createState() => _DetalhesContatosState();
}

class _DetalhesContatosState extends State<DetalhesContatos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhe Contatos'),
      ),
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
                    padding: const EdgeInsets.only(top: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "NOME :",
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                        Text(" ${widget.contato.nome}")
                      ],
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "IDADE :",
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                        Text("${widget.contato.idade.toString()}")
                      ],
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "CPF :",
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                        Text("${widget.contato.cpf!}")
                      ],
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "ID :",
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                        Text("${widget.contato.id!}")
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
