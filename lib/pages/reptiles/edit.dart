import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reptilog_flutter/model/reptile.dart';
import 'package:http/http.dart' as http;

class ReptileEditPage extends StatefulWidget {
  final String reptileId;
  const ReptileEditPage({super.key, required this.reptileId});

  @override
  State<ReptileEditPage> createState() => _ReptileEditPageState();
}

class _ReptileEditPageState extends State<ReptileEditPage> {
  late Future<Reptile> futureReptile;
  late Reptile _reptile;
  final _editReptileFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Fetch reptiles data
    futureReptile = fetchReptile();
  }

  Future<Reptile> fetchReptile() async {
    final response = await http.get(Uri.parse('http://reptilog.test/api/reptiles/${widget.reptileId}'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return Reptile.fromJson(data);
    } else {
      throw Exception('Failed to load reptiles');
    }
  }

  void saveReptile() async {
    if (_editReptileFormKey.currentState!.validate()) {
      final response = await http.put(
        Uri.parse('http://reptilog.test/api/reptiles/${widget.reptileId}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(_reptile.toJson()),
      );

      if (response.statusCode == 200) {
        // Successfully saved
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Successfully saved reptile'), backgroundColor: Colors.green));
        context.go('/reptiles/details/${widget.reptileId}');
      } else {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to save reptile'), backgroundColor: Colors.red));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.go('/reptiles/details/${widget.reptileId}')),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Edit Reptile Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              saveReptile();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          FutureBuilder<Reptile>(
            future: futureReptile,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                _reptile = snapshot.data!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Form(
                        key: _editReptileFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 8.0,
                          children: [
                            TextFormField(
                              initialValue: _reptile.name,
                              decoration: InputDecoration(labelText: 'Name'),
                              onChanged: (value) => {
                                setState(() {
                                  _reptile.name = value;
                                }),
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter name';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              initialValue: _reptile.species,
                              decoration: InputDecoration(labelText: 'Species'),
                              onChanged: (value) => {
                                setState(() {
                                  _reptile.species = value;
                                }),
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter species';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              initialValue: _reptile.hatchDate.toString(),
                              decoration: InputDecoration(labelText: 'Hatch Date'),
                              onChanged: (value) => {
                                setState(() {
                                  _reptile.hatchDate = DateTime.parse(value);
                                }),
                              },
                            ),
                            TextFormField(
                              initialValue: _reptile.clutch,
                              decoration: InputDecoration(labelText: 'Clutch'),
                              onChanged: (value) => {
                                setState(() {
                                  _reptile.clutch = value;
                                }),
                              },
                            ),
                            TextFormField(
                              initialValue: _reptile.acquisitionSource,
                              decoration: InputDecoration(labelText: 'Acquisition Source'),
                              onChanged: (value) => {
                                setState(() {
                                  _reptile.acquisitionSource = value;
                                }),
                              },
                            ),
                            TextFormField(
                              initialValue: _reptile.notes,
                              minLines: 2,
                              maxLines: 5,
                              decoration: InputDecoration(labelText: 'Notes'),
                              onChanged: (value) => {
                                setState(() {
                                  _reptile.notes = value;
                                }),
                              },
                            ),
                          ],
                        ),
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
