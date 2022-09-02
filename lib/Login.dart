import 'package:app_himpact/cadastro.dart';
import 'package:app_himpact/paginaInicial.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailEC = TextEditingController();
  TextEditingController senhaEC = TextEditingController();
  @override
  metodoEnio() async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User? usuarioLogado = auth.currentUser;
    if (usuarioLogado != null) {
      await Future.delayed(Duration(seconds: 3));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => PagInicial()));
    } else {}
  }

  void initState() {
    // TODO: implement initState
    metodoEnio();
  }

  String mensagemErro = "";
  /*bool loading = false;*/

  dialogoProgresso() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  dialogoConfirmacao() async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Sucesso"),
          );
        });
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: ((context) => PagInicial())),
        (route) => false);
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: ((context) => PagInicial())));
  }

  validarCampos() {
    //tenta de novo
    String email = emailEC.text;
    String senha = senhaEC.text;

    if (email.isNotEmpty) {
      if (senha.isNotEmpty) {
        dialogoProgresso();

        logar(email, senha);
      } else {
        setState(() {
          mensagemErro = "Preencha sua senha";
        });
      }
    } else {
      setState(() {
        mensagemErro = "Preencha o campo de login";
      });
    }
  }

  logar(String email, String senha) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      setState(() {
        /*loading = true;*/
      });

      await auth
          .signInWithEmailAndPassword(email: email, password: senha)
          .then((value) {
        Navigator.pop(context);
        dialogoConfirmacao();
      });

      setState(() {
        /*loading = false;*/
      });
      //push
    } on FirebaseAuthException catch (error) {
      setState(() {
        /*loading = false;*/
      });
      if (error.code == 'user-not-found') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Usuario nao encontrado")));
      } else if (error.code == "invalid-email") {
        //print(error.code);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Email inválido")));
      } else if (error.code == "wrong-password") {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Senha Invalida")));
      } else {
        print(error.code);
        setState(() {
          mensagemErro = 'aqui';
        });
      } //tentou? nao ta ativando quando clico no entrar
    } catch (e) {
      //tenta de novo!!!
      setState(() {
        mensagemErro = "Excecao desconhecida";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.fromLTRB(49, 67, 49, 0),
      child: Center(
        child: Container(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: CircleAvatar(
                      child: Image.asset("imagens/imagemlogin.png"),
                      backgroundColor: Color(0xFF02825B),
                      radius: 100,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 32, 0, 0),
                    child: Center(
                      child: Text(
                        "Himpact",
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF02825B)),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: Text(
                        "Hábitos que impactam",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF02825B)),
                      )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
                    child: TextFormField(
                      controller: emailEC,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          labelText: " Login",
                          labelStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(155, 155, 155, 0.5)),
                          prefixIconConstraints: BoxConstraints(maxHeight: 30),
                          prefixIcon: Icon(Icons.perm_identity_outlined)),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: TextFormField(
                        controller: senhaEC,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            labelText: " Senha",
                            labelStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(155, 155, 155, 0.5)),
                            prefixIconConstraints:
                                BoxConstraints(maxHeight: 30),
                            prefixIcon: Icon(Icons.lock_open_rounded)),
                      )),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        child: Text(
                          "Recuperar Senha?",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Color(0xFF02825B)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 0, right: 0, bottom: 16, top: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /*loading == false*/
                        /*?*/ Expanded(
                            child: ElevatedButton(
                          onPressed: () {
                            validarCampos();
                            // final snackBar = SnackBar(
                            //   content: const Text('Hi, I am a SnackBar!'),
                            //   backgroundColor: (Colors.black12),
                            //   action: SnackBarAction(
                            //     label: 'dismiss',
                            //     onPressed: () {},
                            //   ),
                            // );
                            // ScaffoldMessenger.of(context)
                            //     .showSnackBar(snackBar);
                            // final snack = SnackBar(content: Text('ola'));
                            // ScaffoldMessenger.of(context)
                            //     .showSnackBar(snack);
                            // Scaffold.of(context).showSnackBar(
                            //     SnackBar(
                            //         content: Text("Texto padrao")));
                            // validarCampos();
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xFF02825B))),
                          child: Text("Entrar"),
                        ))
                        /*: CircularProgressIndicator()*/
                      ],
                    ),
                  ),

                  //como que tu ia mostrar o erro se tu nao colocou o erro aqui.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: 10,
                          child: Divider(
                            endIndent: 9,
                            thickness: 2,
                            color: Color(0xFF02825B),
                          ),
                        ),
                      ),
                      Text(
                        "ou",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: Color(0xFF02825B)),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: 10,
                          child: Divider(
                              indent: 9,
                              thickness: 2,
                              color: Color(0xFF02825B)),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 0, right: 0, top: 28),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Cadastro()));
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white)),
                          child: Text(
                            "Cadastre-se",
                            style: TextStyle(color: Color(0xFF02825B)),
                          ),
                        ))
                      ],
                    ),
                  ),
                  Row(
                    children: [Text(mensagemErro)],
                  )
                ],
              ),
            )),
      ),
    ));
  }
}
