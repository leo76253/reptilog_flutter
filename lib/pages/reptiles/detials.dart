import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reptilog_flutter/model/reptile.dart';
import 'package:http/http.dart' as http;
import 'package:gap/gap.dart';

class ReptileDetailsPage extends StatefulWidget {
  final String reptileId;
  const ReptileDetailsPage({super.key, required this.reptileId});

  @override
  State<ReptileDetailsPage> createState() => _ReptileDetailsPageState();
}

class _ReptileDetailsPageState extends State<ReptileDetailsPage> {
  late Future<Reptile> reptiles;

  @override
  void initState() {
    super.initState();
    // Fetch reptiles data
    reptiles = fetchReptiles();
  }

  Future<Reptile> fetchReptiles() async {
    final response = await http.get(Uri.parse('http://reptilog.test/api/reptiles/${widget.reptileId}'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return Reptile.fromJson(data);
    } else {
      throw Exception('Failed to load reptiles');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.go('/reptiles')),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('NAME'),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0, 8.0, 0),
            child: IconButton(icon: const Icon(Icons.edit), onPressed: () => context.go('/reptiles/edit/${widget.reptileId}')),
          ),
        ],
      ),
      body: Column(
        children: [
          FutureBuilder<Reptile>(
            future: reptiles,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final reptile = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8.0,
                        children: [
                          Text('Name: ${reptile.name}'),
                          Text('Species: ${reptile.species}'),
                          Text('Hatch Date: ${reptile.hatchDate?.day}/${reptile.hatchDate?.month}/${reptile.hatchDate?.year}'),
                          Text(
                            'Acquisition Date: ${reptile.acquisitionDate?.day}/${reptile.acquisitionDate?.month}/${reptile.acquisitionDate?.year}',
                          ),
                          Text('Clutch: ${reptile.clutch}'),
                          Text('Acquisition Source: ${reptile.acquisitionSource}'),
                          if (reptile.notes != null) Text('Notes: ${reptile.notes}'),
                        ],
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
