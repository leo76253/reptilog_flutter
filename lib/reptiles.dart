import 'package:flutter/material.dart';

class ReptilesIndexPage extends StatefulWidget {
  const ReptilesIndexPage({Key? key}) : super(key: key);

  @override
  _ReptilesIndexPageState createState() => _ReptilesIndexPageState();
}

class _ReptilesIndexPageState extends State<ReptilesIndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Title')),
      body: Container(child: const Center(child: Text('Reptiles Index Page'))),
    );
  }
}
