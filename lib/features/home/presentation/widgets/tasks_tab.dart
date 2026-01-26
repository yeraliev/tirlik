import 'package:flutter/material.dart';

class TasksTab extends StatelessWidget {
  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.task_alt, size: 64),
          SizedBox(height: 16),
          Text('There is no task', style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
