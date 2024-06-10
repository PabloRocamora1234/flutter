import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/post/post.dart';
import 'package:http/http.dart' as http;

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Container(
        child: Center(
          child: FutureBuilder<List<Post>>(
            future: fetchPost(),
            builder: (context, snapshot)
            {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<Post>? listado=snapshot.data;
                if(listado!=null){
                  var contador=0;
                  for (var post in listado) {
                    contador++;
                    print('$contador : ${post.title}');
                  }
                }

                return Text("");
              }

            },

          ),
        ),
      )
    );
  }
  Future<List<Post>> fetchPost() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));

    if (response.statusCode == 200) {
      //print(response.body);
      List<dynamic> jsonResponse = json.decode(response.body);
      // Mapea la lista de JSON a una lista de objetos Post
      List<Post> posts = jsonResponse.map((json) => Post.fromJson(json)).toList();

      return posts;
    } else {
      // Si la solicitud no fue exitosa, lanza una excepción.
      //throw Exception('Error en la carga');
      return [];
    }

  }
}