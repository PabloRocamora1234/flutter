import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/pantallados.dart';

class pantallauno extends StatelessWidget {
  const pantallauno({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PRIMERA'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Coloca aquí la ruta relativa de tu imagen dentro de la carpeta del proyecto
            Image.asset(
              'C:/Flutter/flutter/flutter_application_1/lib/screens/imagen.png',
              height: 100,
              width: 100,
            ),
            SizedBox(height: 10),

            // Texto "dronetech"
            Text(
              'Dronetech',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20), // Espaciador vertical

            // Botón de login
            ElevatedButton(
              child: Text('LOGIN'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const pantallados()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
