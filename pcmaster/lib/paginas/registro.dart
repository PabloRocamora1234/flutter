import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Registro extends StatefulWidget {
  final Function()? onTap;
  const Registro({super.key, required this.onTap});

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  // Text Editing Controllers
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final nombreController = TextEditingController();
  final apellidosController = TextEditingController();

  // Método registrar Usuario
  void registrarUsuario() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // Intentar registrar
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, '/');
    } on FirebaseAuthException catch (e) {
      // Parar el círculo de cargar
      Navigator.pop(context);

      // Mostrar mensaje error
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
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 0,
                  child: Image.asset(
                    "assets/Logo.png",
                    height: 215,
                  ),
                ),

                // Recuadro TextFields

                Container(
                  width: 350,
                  padding: const EdgeInsets.all(16.0),
                  margin: EdgeInsets.only(top: 225),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(185, 84, 57, 141),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Regístrese ahora',
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
                      
                      //TextField Nombre

                      SizedBox(height: 16),
                      TextField(
                        controller: nombreController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFD9D9D9),
                          hintText: 'Nombre',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                        ),
                      ),

                      //TextField Apellidos

                      SizedBox(height: 16),
                      TextField(
                        controller: apellidosController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFD9D9D9),
                          hintText: 'Apellidos',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                        ),
                      ),

                      //Botón Crear Cuenta
                      
                      SizedBox(height: 32),
                      Center(
                        child: ElevatedButton(
                          onPressed: registrarUsuario,
                          style: buttonStyle,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.assignment ,
                                color: Colors.white,
                              ),
                              Text(
                                'Crear Cuenta',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                            //Redirección LogIn

                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '¿Ya tienes una cuenta?',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                                const SizedBox(width: 4),
                                GestureDetector(
                                  onTap: (){
                                      Navigator.pushNamed(context, '/login');
                                    },
                                  child: const Text(
                                    'Inicia Sesión Ahora',
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
            ),
          ),
        );
  }
}