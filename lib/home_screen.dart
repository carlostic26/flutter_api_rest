import 'package:consumo_api/api_giphy.dart';
import 'package:consumo_api/api_rick.dart';
import 'package:consumo_api/api_simpsons_episodes.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Menú'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          WidgetStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.blue),
                    ),
                    onPressed: () => _goGiphy(context),
                    child: const Text('API de Giphy')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          WidgetStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.green),
                    ),
                    onPressed: () => _goRick(context),
                    child: const Text('API de Rick And Morty')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          WidgetStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.amber),
                    ),
                    onPressed: () => _goSimpsons(context),
                    child: const Text('API de Simpsons Episodes')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _goGiphy(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ApiGiphy(),
      ),
    );
  }

  _goRick(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ApiRick(),
      ),
    );
  }

  _goSimpsons(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ApiSimpsonsEpisodes(),
      ),
    );
  }
}
