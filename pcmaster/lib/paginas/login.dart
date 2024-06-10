import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ejemplo_provider/servicios/auth_service.dart';

class Login extends StatefulWidget {
  final Function()? onTap;
  const Login({super.key, required this.onTap});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Texto Editing Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Método LogIn Usuario
  void logearUsuario() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // Intentar logear
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      mensajeErrorUsuario(e.code);
    }
  }

  // Mensaje error Usuario
  void mensajeErrorUsuario(String mensaje) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.purple,
          title: Center(
            child: Text(
              mensaje,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: Color.fromARGB(255, 175, 104, 232),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset:
          false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color.fromARGB(255, 141, 141, 141)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 350,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/Logo.png",
                    height: 215,
                  ),
                  SizedBox(height: 50),
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(185, 84, 57, 141),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Inicie Sesión',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),

                        //TextField Correo

                        SizedBox(height: 16),
                        TextField(
                          controller: emailController,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFD9D9D9),
                            hintText: 'Correo',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15.0),
                          ),
                        ),

                        //TextField Contraseña

                        SizedBox(height: 16),
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFD9D9D9),
                            hintText: 'Contraseña',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15.0),
                          ),
                        ),

                        //Boton Iniciar Sesión

                        SizedBox(height: 32),
                        Center(
                          child: ElevatedButton(
                            onPressed: logearUsuario,
                            style: buttonStyle,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Inicio Sesión',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                Icon(
                                  Icons.login,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Center(
                          child: Column(
                            children: [
                              // Icono de Google
                              GestureDetector(
                                onTap: () {
                                  AuthService()
                                      .signInWithGoogle()
                                      .then((userCredential) {
                                        Navigator.pushNamed(context, '/home');
                                  }).catchError((error) {
                                  });
                                },
                                child: Image.asset(
                                  'assets/logoGoogle.png',
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '¿No estás Registrado?',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                  const SizedBox(width: 4),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/register');
                                    },
                                    child: const Text(
                                      'Regístrate Ahora',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
