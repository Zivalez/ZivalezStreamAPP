import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Cari...',
            prefixIcon: Icon(Icons.search),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            SearchChip(label: 'noblesse'),
            SearchChip(label: 'kimetsu no yaiba'),
            SearchChip(label: 'jigokuraku'),
            SearchChip(label: 'mashle'),
          ],
        ),
      ),
    );
  }
}

class SearchChip extends StatelessWidget {
  final String label;

  const SearchChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      onDeleted: () {},
    );
  }
}
