import 'package:ejemplo_provider/paginas/graficas/graficas.dart';
import 'package:flutter/material.dart';
import 'package:ejemplo_provider/paginas/graficas/graficas.dart';

class DetallesGrafica extends StatelessWidget {
  final Grafica grafica;

  DetallesGrafica({required this.grafica});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'PC MÁSTER',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.pop(context); // Cambio realizado aquí
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Icon(Icons.exit_to_app, color: Colors.black), // Door icon
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Buscar en PC Máster',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Image.network('url_o_path_de_la_imagen', height: 100), // Puedes cambiar a Image.asset si usas imágenes locales
                  SizedBox(height: 30), // Espacio entre la imagen y el nombre
                  Text(
                    grafica.nombre,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 20), // Espacio entre el nombre y el precio
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Precio',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(width: 5), // Espacio pequeño entre "Precio" y el valor
                              Text(
                                '\$199.99', // Cambia esto por el precio real si está disponible
                                style: TextStyle(fontSize: 16, color: Colors.black54),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(width: 40), // Espacio entre el precio y los íconos
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.favorite_border),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 60), // Espacio entre el precio con los íconos y las especificaciones
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'ESPECIFICACIONES',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), // Tamaño de letra más grande
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Marca: ${grafica.marca}\nConector: ${grafica.conector}\nAlimentación: ${grafica.alimentacion}\nPotencia: ${grafica.potencia}W\nGama: ${grafica.gama}',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.purple,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
                icon: const Icon(Icons.home, color: Colors.white),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/pedidos');
                },
                icon: const Icon(Icons.mail, color: Colors.white),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/configurador');
                },
                icon: const Icon(Icons.settings, color: Colors.white),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/carrito');
                },
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/perfil');
                },
                icon: const Icon(Icons.person, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
