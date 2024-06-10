import 'package:flutter/material.dart';

class NuevaPagina extends StatelessWidget {
  final String name;

  NuevaPagina({required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '¡Bienvenido, $name!',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Puedes realizar acciones adicionales aquí
                Navigator.pop(context); // Volver a la pantalla de inicio de sesión (Login)
              },
              child: Text('Cerrar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
