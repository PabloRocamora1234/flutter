import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../configurador.dart';

class Procesador {
  final int alimentacion;
  final String gama;
  final String marca;
  final String nombre;
  final int potencia;
  final String socked;

  Procesador({
    required this.alimentacion,
    required this.gama,
    required this.marca,
    required this.nombre,
    required this.potencia,
    required this.socked,
  });

  static Procesador fromMap(Map<dynamic, dynamic> map) {
    return Procesador(
      alimentacion: int.tryParse(map['Alimentacion'].replaceAll('W', '')) ?? 0,
      gama: map['Gama'] ?? '',
      marca: map['Marca'] ?? '',
      nombre: map['Nombre'] ?? '',
      potencia: map['Potencia'] ?? 0,
      socked: map['socked'] ?? '',
    );
  }
}

class ProcesadoresPage extends StatefulWidget {
  final Function(Procesador) onProcesadorSelected;

  ProcesadoresPage({required this.onProcesadorSelected});

  @override
  _ProcesadoresPageState createState() => _ProcesadoresPageState();
}

class _ProcesadoresPageState extends State<ProcesadoresPage> {
  final DatabaseReference _procesadoresRef = FirebaseDatabase(
    databaseURL: 'https://login-be8a2-default-rtdb.europe-west1.firebasedatabase.app',
  ).reference().child('procesadores');

  List<Procesador> procesadores = [];
  List<Procesador> filteredProcesadores = [];
  bool _isLoading = true;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProcesadores();
    _searchController.addListener(_filterProcesadores);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadProcesadores() {
    _procesadoresRef.get().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        setState(() {
          procesadores.clear();
          if (snapshot.value is Map) {
            Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
            values.forEach((key, value) {
              procesadores.add(Procesador.fromMap(value));
            });
          } else if (snapshot.value is List) {
            List<dynamic> values = snapshot.value as List<dynamic>;
            for (var value in values) {
              if (value != null) {
                procesadores.add(Procesador.fromMap(value));
              }
            }
          }
          filteredProcesadores = List.from(procesadores);
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    }).catchError((error) {
      print("Error al cargar procesadores: $error");
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _filterProcesadores() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredProcesadores = procesadores.where((procesador) {
        return procesador.nombre.toLowerCase().contains(query);
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
                      'Procesadores',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredProcesadores.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: Icon(Icons.image, size: 40),
                          title: Text(
                            filteredProcesadores[index].nombre,
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                          ),
                          subtitle: Text(filteredProcesadores[index].marca),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            widget.onProcesadorSelected(filteredProcesadores[index]);
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