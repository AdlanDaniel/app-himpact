import 'package:app_himpact/Login.dart';
import 'package:app_himpact/cadastrar_dados.dart';
import 'package:app_himpact/cadastro.dart';
import 'package:app_himpact/listar_contatos.dart';
import 'package:app_himpact/paginaInicial.dart';
import 'package:flutter/material.dart';
import 'package:app_himpact/apresentacao.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    home: SplashPage(),
    debugShowCheckedModeBanner: false,
  ));
}
