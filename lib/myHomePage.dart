import 'dart:convert';

import 'package:consumo_api/model/gif.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Gif>> _listaGif;

  Future<List<Gif>?> getGif() async {
    final response = await http.get(Uri.parse(
        'https://api.giphy.com/v1/gifs/trending?api_key=J9cPMk2ZcVW9iYzpng3J4YPLc5itomrz&limit=10&offset=0&rating=g&bundle=messaging_non_clips'));

    List<Gif> gifs = [];

    if (response.statusCode == 200) {
      print(response.body);

      String body = utf8.decode(response.bodyBytes);

      //conver body to Json
      final jsonData = jsonDecode(body);

      print(jsonData);
    } else {
      throw Exception("Fallo de conexion");
    }

    return null;
  }

  @override
  void initState() {
    super.initState();

    getGif();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
