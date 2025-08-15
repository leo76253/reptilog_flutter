import 'package:flutter/material.dart';

class ReptileDetailsPage extends StatefulWidget {
  final String reptileId;
  const ReptileDetailsPage({super.key, required this.reptileId});

  @override
  State<ReptileDetailsPage> createState() => _ReptileDetailsPageState();
}

class _ReptileDetailsPageState extends State<ReptileDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Title')),
      body: Center(child: Text('Viewing details for reptile ID: ${widget.reptileId}')),
    );
  }
}
