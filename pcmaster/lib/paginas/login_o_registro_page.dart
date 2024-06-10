import 'package:ejemplo_provider/paginas/login.dart';
import 'package:ejemplo_provider/paginas/registro.dart';
import 'package:flutter/material.dart';

class LoginORegistroPage extends StatefulWidget {
  const LoginORegistroPage({super.key});

  @override
  State<LoginORegistroPage> createState() => _LoginORegistroPageState();
}

class _LoginORegistroPageState extends State<LoginORegistroPage> {

  //Mostrar principalmente pagina login

  bool showLoginPage = true;

  //Cambiar entre pagina de login y registro
  void cambiarPaginas (){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return Login(
        onTap: cambiarPaginas,
      );
    }else{
      return Registro(
        onTap: cambiarPaginas,
      );
    }
  }
}