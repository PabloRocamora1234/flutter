import 'package:flutter/material.dart';
import 'package:ejemplo_provider/paginas/graficas/detalles_grafica.dart';
import 'package:ejemplo_provider/paginas/placabase/detalles_placa.dart';
import 'package:ejemplo_provider/paginas/placabase/placa.dart';
import 'package:ejemplo_provider/paginas/procesador/componentes.dart';
import 'package:ejemplo_provider/paginas/procesador/detalles_procesador.dart';
import 'package:ejemplo_provider/paginas/graficas/graficas.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ejemplo_provider/paginas/graficas/graficas.dart';

class Configurador extends StatefulWidget {
  @override
  _ConfiguradorState createState() => _ConfiguradorState();
}

class _ConfiguradorState extends State<Configurador> {
  final List<String> componentes = [
    'Procesador',
    'Tarjeta Gráfica',
    'Placa Base',
    'Caja/Torre',
    'Memoria RAM',
    'Refrigeración'
  ];

  Procesador? procesadorSeleccionado; // Almacena el procesador seleccionado
  Grafica? graficaSeleccionada; // Almacena la tarjeta gráfica seleccionada
  Placa? placaSeleccionada; // Almacena la placa base seleccionada

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
            Text(
              'TOTAL',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(width: 10),
            Icon(Icons.shopping_cart, color: Colors.black),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'COMPONENTES',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: componentes.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.image, size: 40),
                      title: Row(
                        children: [
                          Text(
                            componentes[index],
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                          ),
                          if (componentes[index] == 'Tarjeta Gráfica')
                            Text('*', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                      subtitle: _getSubtitle(componentes[index]),
                      trailing: IconButton(
                        icon: Icon(Icons.more_vert),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                switch (componentes[index]) {
                                  case 'Procesador':
                                    return procesadorSeleccionado != null
                                        ? DetallesProcesador(procesador: procesadorSeleccionado!)
                                        : Container(); // Maneja la situación en la que no se ha seleccionado un procesador
                                  case 'Tarjeta Gráfica':
                                    return graficaSeleccionada != null
                                        ? DetallesGrafica(grafica: graficaSeleccionada!)
                                        : Container(); // Maneja la situación en la que no se ha seleccionado una gráfica
                                  case 'Placa Base':
                                    return placaSeleccionada != null
                                        ? DetallesPlaca(placa: placaSeleccionada!)
                                        : Container(); // Maneja la situación en la que no se ha seleccionado una placa
                                  default:
                                    return Container();
                                }
                              },
                            ),
                          );
                        },
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              switch (componentes[index]) {
                                case 'Procesador':
                                  return ProcesadoresPage(
                                    onProcesadorSelected: (procesador) {
                                      setState(() {
                                        procesadorSeleccionado = procesador;
                                      });
                                    },
                                  );
                                case 'Tarjeta Gráfica':
                                  return GraficasPage(
                                    onGraficaSelected: (grafica) {
                                      setState(() {
                                        graficaSeleccionada = grafica;
                                      });
                                    },
                                  );
                                case 'Placa Base':
                                  return PlacasPage(
                                    onPlacaSelected: (placa) {
                                      setState(() {
                                        placaSeleccionada = placa;
                                      });
                                    },
                                  );
                                default:
                                  return Configurador();
                              }
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
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

  Widget _getSubtitle(String componentName) {
    switch (componentName) {
      case 'Procesador':
        return procesadorSeleccionado != null
            ? Text(procesadorSeleccionado!.nombre, style: TextStyle(color: Colors.green))
            : Text('Producto');
      case 'Tarjeta Gráfica':
        return graficaSeleccionada != null
            ? Text(graficaSeleccionada!.nombre, style: TextStyle(color: Colors.green))
            : Text('Producto');
      case 'Placa Base':
        return placaSeleccionada != null
            ? Text(placaSeleccionada!.nombre, style: TextStyle(color: Colors.green))
            : Text('Producto');
      default:
        return Text('Producto');
    }
  }
}