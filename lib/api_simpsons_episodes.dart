import 'dart:convert';
import 'package:consumo_api/model/gif.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiSimpsonsEpisodes extends StatefulWidget {
  const ApiSimpsonsEpisodes({super.key});

  @override
  State<ApiSimpsonsEpisodes> createState() => _ApiSimpsonsEpisodesState();
}

class _ApiSimpsonsEpisodesState extends State<ApiSimpsonsEpisodes> {
  late Future<List<Gif>> _listaGif;

  Future<List<Gif>> getGif() async {
    final response = await http
        .get(Uri.parse('https://api.sampleapis.com/simpsons/episodes'));

    List<Gif> gif = [];

    if (response.statusCode == 200) {
      //print(response.body);

      String body = utf8.decode(response.bodyBytes);

      //conver body to Json
      final jsonData = jsonDecode(body);

      //print(jsonData["results"]);

      for (var item in jsonData) {
        gif.add(Gif(item["name"], item["thumbnailUrl"]));
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
        title: const Text('CONSUMO API RICK AND MORTHY'),
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
            FutureBuilder<void>(
              future: precacheImage(NetworkImage(gif.url), context),
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Muestra el indicador de progreso mientras se carga la imagen
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return CircularProgressIndicator();
                } else {
                  // La imagen se cargó correctamente
                  return Image.network(gif.url);
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(gif.name),
            ),
          ],
        ),
      ));
    }

    return gifs;
  }
}
