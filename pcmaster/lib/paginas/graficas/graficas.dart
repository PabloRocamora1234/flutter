import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../configurador.dart';

class Grafica {
  final int id;
  final String nombre;
  final String marca;
  final String conector;
  final String alimentacion;
  final int potencia;
  final String gama;

  Grafica({
    required this.id,
    required this.nombre,
    required this.marca,
    required this.conector,
    required this.alimentacion,
    required this.potencia,
    required this.gama,
  });

  static Grafica fromMap(Map<dynamic, dynamic> map) {
    return Grafica(
      id: map['ID'] ?? 0,
      nombre: map['Nombre'] ?? '',
      marca: map['Marca'] ?? '',
      conector: map['Conector'] ?? '',
      alimentacion: map['Alimentacion'] ?? '',
      potencia: map['Potencia'] ?? 0,
      gama: map['Gama'] ?? '',
    );
  }
}

class GraficasPage extends StatefulWidget {
  final Function(Grafica) onGraficaSelected;

  GraficasPage({required this.onGraficaSelected});

  @override
  _GraficasPageState createState() => _GraficasPageState();
}

class _GraficasPageState extends State<GraficasPage> {
  final DatabaseReference _graficasRef = FirebaseDatabase(
    databaseURL: 'https://login-be8a2-default-rtdb.europe-west1.firebasedatabase.app',
  ).reference().child('graficas');

  List<Grafica> graficas = [];
  List<Grafica> filteredGraficas = [];
  bool _isLoading = true;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadGraficas();
    _searchController.addListener(_filterGraficas);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadGraficas() {
    _graficasRef.get().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        setState(() {
          graficas.clear();
          if (snapshot.value is Map) {
            Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
            values.forEach((key, value) {
              graficas.add(Grafica.fromMap(value));
            });
          } else if (snapshot.value is List) {
            List<dynamic> values = snapshot.value as List<dynamic>;
            for (var value in values) {
              if (value != null) {
                graficas.add(Grafica.fromMap(value));
              }
            }
          }
          filteredGraficas = List.from(graficas);
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    }).catchError((error) {
      print("Error al cargar graficas: $error");
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _filterGraficas() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredGraficas = graficas.where((grafica) {
        return grafica.nombre.toLowerCase().contains(query);
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
                child: Icon(Icons.exit_to_app, color: Colors.black),
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
                      'Gráficas',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredGraficas.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: Icon(Icons.image, size: 40),
                          title: Text(
                            filteredGraficas[index].nombre,
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                          ),
                          subtitle: Text(filteredGraficas[index].marca),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            widget.onGraficaSelected(filteredGraficas[index]);
                            Navigator.pop(context);
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