import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reptilog_flutter/model/reptile.dart';
import 'package:http/http.dart' as http;

class ReptilesIndexPage extends StatefulWidget {
  const ReptilesIndexPage({super.key});

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
    final response = await http.get(Uri.parse('http://reptilog.test/api/reptiles'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Reptile.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load reptiles');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.go('/')),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Reptiles'),
      ),
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
                return ListTile(
                  title: Text(reptile.name),
                  subtitle: Text(reptile.species),
                  onTap: () {
                    context.go('/reptiles/details/${reptile.id}');
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
