import 'package:flutter/material.dart';
import 'package:reptilog_flutter/model/reptile.dart';

class ReptilesIndexPage extends StatefulWidget {
  const ReptilesIndexPage({Key? key}) : super(key: key);

  @override
  _ReptilesIndexPageState createState() => _ReptilesIndexPageState();
}

class _ReptilesIndexPageState extends State<ReptilesIndexPage> {
  late Future<List<Reptile>> reptiles;

  @override
  void initState() {
    super.initState();
    // Fetch reptiles data
    reptiles = fetchReptiles();
  }

  Future<List<Reptile>> fetchReptiles() async {
    // Simulate a network call
    await Future.delayed(const Duration(seconds: 2));
    return [
      Reptile(id: 1, name: 'Crocodile', species: 'Crocodylus niloticus'),
      Reptile(id: 2, name: 'Lizard', species: 'Lacerta agilis'),
      Reptile(id: 3, name: 'Snake', species: 'Serpentes'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Title')),
      body: FutureBuilder(
        future: reptiles,
        initialData: const [],
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching reptiles'));
          } else {
            final List<Reptile> reptiles = snapshot.data;
            return ListView.builder(
              itemCount: reptiles.length,
              itemBuilder: (context, index) {
                final reptile = reptiles[index];
                return ListTile(title: Text(reptile.name), subtitle: Text(reptile.species));
              },
            );
          }
        },
      ),
    );
  }
}
