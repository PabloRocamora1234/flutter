import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Principal extends StatelessWidget {
  Principal({Key? key}) : super(key: key);

  final user = FirebaseAuth.instance.currentUser;

  // Método para desloguear al usuario
  void deslogearUsuario(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/LetrasLogo.png',
          ),
        actions: [
          // Botón de logout en la AppBar
          IconButton(
            onPressed: () {
              deslogearUsuario(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar en PC Máster',
                  suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      //Navigator.pushNamed(context, '/placas');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 24.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      minimumSize: const Size(150, 60),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Placa Base',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Image.asset(
                          'assets/fotosgen/placa.png',
                          height: 75,
                          ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //Navigator.pushNamed(context, '/procesadores');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 24.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      minimumSize: const Size(150, 60),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Procesador',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Image.asset(
                          'assets/fotosgen/procesador.png',
                          height: 75,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      //Navigator.pushNamed(context, '/graficas');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 24.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      minimumSize: const Size(150, 60),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Tarjeta Gráfica',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Image.asset(
                          'assets/fotosgen/grafica.png',
                          height: 75,
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //Navigator.pushNamed(context, '/ram');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 24.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      minimumSize: const Size(150, 60),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'RAM',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Image.asset(
                          'assets/fotosgen/ram.png',
                          height: 75,
                          width: 75,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      //Navigator.pushNamed(context, '/almacenamiento');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 24.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      minimumSize: const Size(150, 60),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Almacenamiento',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Image.asset(
                          'assets/fotosgen/ssd.png',
                          height: 75,
                          ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //Navigator.pushNamed(context, '/refrigeracion');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 24.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      minimumSize: const Size(150, 60),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Refrigeración',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Image.asset(
                          'assets/fotosgen/refrigeracion.png',
                          height: 75,
                          width: 75,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
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
                  //Navigator.pushNamed(context, '/perfil');
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
