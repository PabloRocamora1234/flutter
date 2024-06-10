import 'package:flutter/material.dart';
import 'signup.dart';
import 'nueva_pagina.dart';

class Login extends StatelessWidget {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String name = _nameController.text;
                String password = _passwordController.text;

                // Implementa la lógica de autenticación, por ejemplo, verificando con los datos registrados
                bool authenticationSuccess = true;

                if (authenticationSuccess) {
                  // Navegar a la nueva página de bienvenida
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => NuevaPagina(name: name)),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error de inicio de sesión'),
                        content: Text('Credenciales incorrectas.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Iniciar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
