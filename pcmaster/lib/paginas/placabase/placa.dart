import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'detalles_placa.dart';
import '../configurador.dart';

class Placa {
  final int id;
  final String nombre;
  final String marca;
  final String socked;
  final String alimentacion;
  final int potencia;
  final String gama;
  final String conexiones;
  final String ram;

  Placa({
    required this.id,
    required this.nombre,
    required this.marca,
    required this.socked,
    required this.alimentacion,
    required this.potencia,
    required this.gama,
    required this.conexiones,
    required this.ram,
  });

  static Placa fromMap(Map<dynamic, dynamic> map) {
    return Placa(
      id: map['ID'] ?? 0,
      nombre: map['Nombre'] ?? '',
      marca: map['Marca'] ?? '',
      socked: map['socked'] ?? '',
      alimentacion: map['Alimentacion'] ?? '',
      potencia: map['Potencia'] ?? 0,
      gama: map['Gama'] ?? '',
      conexiones: map['Conecxiones'] ?? '',
      ram: map['Ram'] ?? '',
    );
  }
}

class PlacasPage extends StatefulWidget {
  final Function(Placa) onPlacaSelected;

  PlacasPage({required this.onPlacaSelected});

  @override
  _PlacasPageState createState() => _PlacasPageState();
}

class _PlacasPageState extends State<PlacasPage> {
  final DatabaseReference _placasRef = FirebaseDatabase(
    databaseURL: 'https://login-be8a2-default-rtdb.europe-west1.firebasedatabase.app',
  ).reference().child('placa');

  List<Placa> placas = [];
  List<Placa> filteredPlacas = [];
  bool _isLoading = true;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPlacas();
    _searchController.addListener(_filterPlacas);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadPlacas() {
    _placasRef.get().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        setState(() {
          placas.clear();
          if (snapshot.value is Map) {
            Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
            values.forEach((key, value) {
              placas.add(Placa.fromMap(value));
            });
          } else if (snapshot.value is List) {
            List<dynamic> values = snapshot.value as List<dynamic>;
            for (var value in values) {
              if (value != null) {
                placas.add(Placa.fromMap(value));
              }
            }
          }
          filteredPlacas = List.from(placas);
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    }).catchError((error) {
      print("Error al cargar placas: $error");
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _filterPlacas() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredPlacas = placas.where((placa) {
        return placa.nombre.toLowerCase().contains(query);
      }).toList();
    });
  }

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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Configurador()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Icon(Icons.exit_to_app, color: Colors.black), // Icono de la puerta
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Buscar en PC Máster',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Placas Madre',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredPlacas.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: Icon(Icons.image, size: 40),
                          title: Text(
                            filteredPlacas[index].nombre,
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                          ),
                          subtitle: Text(filteredPlacas[index].marca),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            // Llama a la función onPlacaSelected y pasa la placa madre seleccionada
                            widget.onPlacaSelected(filteredPlacas[index]);
                            Navigator.pop(context); // Cierra la página de placas madre
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
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