import 'package:ejemplo_provider/paginas/carrito.dart';
import 'package:ejemplo_provider/paginas/procesador/componentes.dart';
import 'package:ejemplo_provider/paginas/configurador.dart';
import 'package:ejemplo_provider/paginas/login.dart';
import 'package:ejemplo_provider/paginas/pedidos.dart';
import 'package:ejemplo_provider/paginas/principal.dart';
import 'package:ejemplo_provider/paginas/registro.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthStateSwitcher(),
      routes: {
        '/home': (context) => Principal(),
        '/login': (context) => Login(onTap: () {
          Navigator.pushNamed(context, '/register');
        }),
        '/register': (context) => Registro(onTap: () {
          Navigator.pushNamed(context, '/login');     
        }),
        '/carrito': (context) => Carrito(),
        '/componentes':(context) => ProcesadoresPage(onProcesadorSelected: (Procesador ) {  },),
        '/configurador':(context) => Configurador(),
        '/pedidos':(context) => Pedidos()
      },
    );
  }
}

class AuthStateSwitcher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return Principal();
        } else {
          return Login(onTap: () {
            Navigator.pushNamed(context, '/login');
          });
        }
      },
    );
  }
}
