import 'package:ejemplo_provider/paginas/principal.dart';
import 'package:ejemplo_provider/paginas/login_o_registro_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          
          //El usuario esta logeado
          if(snapshot.hasData){
            return Principal();
          }
          //El usuario No esta logeado
          else{
            return LoginORegistroPage();
          }
        },
      ),
    );
  }
}