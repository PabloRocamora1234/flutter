
import 'package:flutter/material.dart';
import 'package:flutter_application_1/post/post.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('EJEMPLO FUTURE CON API'),
          elevation: 1.0,
          backgroundColor: Colors.black12,
        ),
        body: Center(
          /**
           * El FutureBuilder es un widget que toma un Future
           *  y construye la interfaz de usuario basándose en los diferentes estados del Future. 
           */
          child: FutureBuilder<Post>(
            future: fetchPost(),
            //El builder es una función que se ejecuta cada vez que el estado del Future cambia.
            /* snapshot:
             El parámetro snapshot es un objeto de tipo AsyncSnapshot<T>, donde T es el tipo de datos que el FutureBuilder está esperando.
              AsyncSnapshot contiene el estado actual del Future y, si se ha completado con éxito, los datos resultantes.
             Proporciona varias propiedades útiles como connectionState, hasData, data, hasError, y error.
            */
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return ListView(children: <Widget>[
                  ListTile(
                    title: Text(
                        'Título de la publicación: ${snapshot.data?.title ?? "Sin título"}'),
                  )
                ]);
              }
            },
          ),
        ),
      ),
    );
  }
}

Future<Post> fetchPost() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));

  if (response.statusCode == 200) {
    return Post.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Fallo al cargar la publicación');
  }
}