import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final IconData icon;
  final Color backgroundColor;

  const CustomCard({
    Key? key,
    required this.item,
    required this.icon,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Icon(icon),
          title: Text(
            'Nombre: ${item['nombre'] ?? 'N/A'}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (item['direccion'] != null)
                Text(
                  'Dirección: ${item['direccion']}',
                  style: TextStyle(color: Colors.white),
                ),
              if (item['telefono'] != null)
                Text(
                  'Teléfono: ${item['telefono']}',
                  style: TextStyle(color: Colors.white),
                ),
              if (item['correo'] != null)
                Text(
                  'Correo: ${item['correo']}',
                  style: TextStyle(color: Colors.white),
                ),
              if (item['descripcion'] != null)
                Text(
                  'Descripción: ${item['descripcion']}',
                  style: TextStyle(color: Colors.white),
                ),
              if (item['cantidad'] != null)
                Text(
                  'Cantidad: ${item['cantidad']}',
                  style: TextStyle(color: Colors.white),
                ),
              if (item['precio_unitario'] != null)
                Text(
                  'Precio Unitario: ${item['precio_unitario']}',
                  style: TextStyle(color: Colors.white),
                ),
            ],
          ),
        ),
      ),
    );
  }
}