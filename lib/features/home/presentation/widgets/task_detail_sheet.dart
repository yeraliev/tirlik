import 'package:flutter/material.dart';
import 'package:secure_task/core/database/app_database/app_database.dart';

class TaskDetailSheet extends StatelessWidget {
  final Task task;
  final List<TaskGroup>? groups;

  const TaskDetailSheet({super.key, required this.task, required this.groups});

  static void show(
    BuildContext context, {
    required Task task,
    required List<TaskGroup>? groups,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => TaskDetailSheet(task: task, groups: groups),
    );
  }

  @override
  Widget build(BuildContext context) {
    final group = groups?.where((g) => g.id == task.taskGroupId).firstOrNull;
    final groupColor = group != null
        ? Color(int.parse(group.color.replaceFirst('#', '0xFF')))
        : null;
    final isOverdue =
        task.dueDate != null && task.dueDate!.isBefore(DateTime.now());

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      builder: (_, controller) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: ListView(
          controller: controller,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (group != null && groupColor != null)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: groupColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  group.name,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: groupColor,
                  ),
                ),
              ),
            const SizedBox(height: 12),
            Text(
              task.title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                decoration:
                    task.isCompleted ? TextDecoration.lineThrough : null,
                color: task.isCompleted ? Colors.grey : null,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _PriorityBadge(priority: task.priority),
                if (task.dueDate != null) ...[
                  const SizedBox(width: 8),
                  Icon(
                    Icons.calendar_today,
                    size: 13,
                    color: isOverdue ? Colors.red.shade400 : Colors.grey.shade500,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${task.dueDate!.day.toString().padLeft(2, '0')}/${task.dueDate!.month.toString().padLeft(2, '0')}/${task.dueDate!.year}',
                    style: TextStyle(
                      fontSize: 13,
                      color: isOverdue
                          ? Colors.red.shade400
                          : Colors.grey.shade600,
                    ),
                  ),
                ],
              ],
            ),
            if ((task.description ?? '').isNotEmpty) ...[
              const SizedBox(height: 16),
              Divider(color: Colors.grey.shade200),
              const SizedBox(height: 12),
              Text(
                task.description!,
                style: const TextStyle(fontSize: 15, height: 1.5),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _PriorityBadge extends StatelessWidget {
  final int priority;
  const _PriorityBadge({required this.priority});

  @override
  Widget build(BuildContext context) {
    if (priority == 0) return const SizedBox.shrink();
    final isHigh = priority == 2;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isHigh ? Colors.red.shade50 : Colors.orange.shade50,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isHigh ? Colors.red.shade200 : Colors.orange.shade200,
        ),
      ),
      child: Text(
        isHigh ? 'High' : 'Medium',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: isHigh ? Colors.red.shade700 : Colors.orange.shade700,
        ),
      ),
    );
  }
}
