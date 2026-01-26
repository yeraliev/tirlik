import 'package:flutter/material.dart';

class NotesTab extends StatelessWidget {
  const NotesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.note, size: 64),
          SizedBox(height: 16),
          Text('There is no pinned notes', style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
