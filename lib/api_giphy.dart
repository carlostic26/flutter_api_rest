import 'dart:convert';
import 'package:consumo_api/model/gif.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiGiphy extends StatefulWidget {
  const ApiGiphy({super.key});

  @override
  State<ApiGiphy> createState() => _ApiGiphyState();
}

class _ApiGiphyState extends State<ApiGiphy> {
  late Future<List<Gif>> _listaGif;

  Future<List<Gif>> getGif() async {
    final response = await http.get(Uri.parse(
        'https://api.giphy.com/v1/gifs/trending?api_key=J9cPMk2ZcVW9iYzpng3J4YPLc5itomrz&limit=10&offset=0&rating=g&bundle=messaging_non_clips'));

    List<Gif> gif = [];

    if (response.statusCode == 200) {
      //print(response.body);

      String body = utf8.decode(response.bodyBytes);

      //conver body to Json
      final jsonData = jsonDecode(body);

      print(jsonData["data"]);

      for (var item in jsonData["data"]) {
        gif.add(Gif(item["title"], item["images"]["original"]["url"]));
      }

      return gif;
    } else {
      throw Exception("Fallo de conexion");
    }
  }

  @override
  void initState() {
    super.initState();

    _listaGif = getGif();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('CONSUMO API GIPHY'),
      ),
      body: FutureBuilder<List<Gif>>(
        future: _listaGif,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return const Text('Error');
          } else {
            return ListView(
              children: _listGifs(snapshot.data ?? []),
            );
          }
        },
      ),
    );
  }

  List<Widget> _listGifs(List<Gif> data) {
    List<Widget> gifs = [];

    for (var gif in data) {
      gifs.add(Card(
          child: Column(
        children: [
          Image.network(gif.url),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(gif.name),
          ),
        ],
      )));
    }

    return gifs;
  }
}
