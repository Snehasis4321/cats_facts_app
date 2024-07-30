import 'package:cats_facts_app/api_call.dart';
import 'package:flutter/material.dart';

class FactPage extends StatefulWidget {
  const FactPage({super.key});

  @override
  State<FactPage> createState() => _FactPageState();
}

class _FactPageState extends State<FactPage> {
  String imageUrl = "https://cataas.com/cat";

  void refreshImage() {
    setState(() {
      // Add a timestamp to force a new image to be loaded
      imageUrl = "https://cataas.com/cat?timestamp=${DateTime.now().millisecondsSinceEpoch}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getCatFact(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(children: [
              Container(
                child: Image.network(
                  imageUrl,
                  width: 500,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  snapshot.data.toString(),
                  style: const TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ]);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return Center(child: const CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          refreshImage();
          setState(() {});
        },
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}