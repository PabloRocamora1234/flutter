import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Main(title: 'Flutter Demo'),
    );
  }
}

class Main extends StatelessWidget {
  const Main({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("APPBAR"),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (value) {
              print("Pulsado");
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(child: Text('Opción 1')),
              const PopupMenuItem<String>(child: Text('Opción 2')),
            ],
          )
        ],
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          children: [
            _buildImageColumn(),
            _buildGrid(),
            _buildList(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageColumn() => Container(
        decoration: BoxDecoration(
          color: Colors.black54,
        ),
        child: Row(
          children: [
            Container(
              height: 100.0,
              width: 50.0,
              color: Colors.amber,
            ),
            Container(
              height: 100.0,
              width: 50.0,
              color: Colors.teal,
            ),
          ],
        ),
      );

  Widget _buildGrid() => GridView.extent(
        maxCrossAxisExtent: 150,
        padding: const EdgeInsets.all(4),
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: _buildGridTileList(10),
      );

  List<Container> _buildGridTileList(int count) => List.generate(
        count,
        (i) => Container(
          width: 100,
          height: 100,
          color: Colors.blue,
        ),
      );

  Widget _buildList() => ListView(
        children: [
          name('Isabel', 'Lafuente'),
          name('Mari Carmen', 'Ortuño'),
          name('Víctor', 'Sarabia'),
          Divider(),
          name('Jesús', "José"),
          name('Miguel', 'Soriano'),
        ],
      );

  ListTile name(String firstName, String lastName) => ListTile(
        title: Text(
          firstName,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        subtitle: Text(lastName),
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.blue[500],
        ),
      );
}