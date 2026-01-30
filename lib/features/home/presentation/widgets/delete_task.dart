import 'package:flutter/material.dart';
import 'package:secure_task/core/theme/app_colors.dart';

class DeleteConfirmDialog extends StatelessWidget {
  final String taskTitle;

  const DeleteConfirmDialog({super.key, required this.taskTitle});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.orange),
          SizedBox(width: 10),
          Text(
            'Delete Task?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ],
      ),
      content: Text('Are you sure you want to delete "$taskTitle"?'),
      actions: [
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Cancel'),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Delete'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
