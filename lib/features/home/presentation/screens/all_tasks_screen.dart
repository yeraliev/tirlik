import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_task/core/database/app_database/app_database.dart';
import 'package:secure_task/core/theme/app_colors.dart';
import 'package:secure_task/core/widgets/custom_snackbar.dart';
import 'package:secure_task/features/home/presentation/bloc/home_bloc.dart';
import 'package:secure_task/features/home/presentation/widgets/delete_task.dart';
import 'package:secure_task/features/home/presentation/widgets/edit_task.dart';
import 'package:secure_task/features/home/presentation/widgets/task_detail_sheet.dart';

class AllTasksScreen extends StatefulWidget {
  const AllTasksScreen({super.key});

  @override
  State<AllTasksScreen> createState() => _AllTasksScreenState();
}

class _AllTasksScreenState extends State<AllTasksScreen> {
  int? _priorityFilter;
  DateTime? _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  void _fetchTasks() {
    context.read<HomeBloc>().add(
      GetAllTasksEvent(
        dateFilter: _selectedDate,
        priorityFilter: _priorityFilter,
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      CustomSnackbar.successSnackbar(
        success: message,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      CustomSnackbar.errorSnackbar(
        error: message,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
      _fetchTasks();
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Tasks',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Filter by date',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _DateChip(
                          label: 'All',
                          selected: _selectedDate == null,
                          onTap: () {
                            setState(() => _selectedDate = null);
                            _fetchTasks();
                          },
                        ),
                        const SizedBox(width: 8),
                        _DateChip(
                          label: 'Today',
                          selected: _selectedDate != null &&
                              _isSameDay(_selectedDate!, DateTime.now()),
                          onTap: () {
                            setState(() => _selectedDate = DateTime.now());
                            _fetchTasks();
                          },
                        ),
                        const SizedBox(width: 8),
                        _DateChip(
                          label: _selectedDate != null &&
                                  !_isSameDay(_selectedDate!, DateTime.now())
                              ? _formatDate(_selectedDate!)
                              : 'Pick date',
                          selected: _selectedDate != null &&
                              !_isSameDay(_selectedDate!, DateTime.now()),
                          icon: Icons.calendar_today,
                          onTap: _pickDate,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Filter by priority',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _FilterChip(
                          label: 'All',
                          selected: _priorityFilter == null,
                          onTap: () {
                            setState(() => _priorityFilter = null);
                            _fetchTasks();
                          },
                        ),
                        const SizedBox(width: 8),
                        _FilterChip(
                          label: 'High',
                          selected: _priorityFilter == 2,
                          onTap: () {
                            setState(() => _priorityFilter = 2);
                            _fetchTasks();
                          },
                        ),
                        const SizedBox(width: 8),
                        _FilterChip(
                          label: 'Medium',
                          selected: _priorityFilter == 1,
                          onTap: () {
                            setState(() => _priorityFilter = 1);
                            _fetchTasks();
                          },
                        ),
                        const SizedBox(width: 8),
                        _FilterChip(
                          label: 'Low',
                          selected: _priorityFilter == 0,
                          onTap: () {
                            setState(() => _priorityFilter = 0);
                            _fetchTasks();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            Expanded(
              child: BlocConsumer<HomeBloc, HomeState>(
                listener: (context, state) {
                  if (state.status == HomeStatus.error) {
                    _showError(state.error!);
                  }
                },
                builder: (context, state) {
                  if (state.status == HomeStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.error != null) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: width * 0.16,
                            color: Colors.red,
                          ),
                          SizedBox(height: height * 0.02),
                          Text(
                            state.error!,
                            style: TextStyle(
                              fontSize: width * 0.04,
                              color: Colors.red,
                            ),
                          ),
                          SizedBox(height: height * 0.02),
                          ElevatedButton(
                            onPressed: _fetchTasks,
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  final tasks = state.allTasks;

                  if (tasks == null || tasks.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.task_alt,
                            size: width * 0.2,
                            color: Colors.grey,
                          ),
                          SizedBox(height: height * 0.02),
                          Text(
                            'No tasks found',
                            style: TextStyle(
                              fontSize: width * 0.045,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.04,
                      vertical: 4,
                    ),
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      final isCompleted = task.isCompleted;

                      return Dismissible(
                        key: Key('all_task_${task.id}'),
                        direction: DismissDirection.endToStart,
                        confirmDismiss: (direction) async {
                          return await _showDeleteConfirmDialog(
                            context,
                            task.title,
                          );
                        },
                        background: _buildDismissBackground(width, height),
                        onDismissed: (direction) {
                          context.read<HomeBloc>().add(
                            DeleteTaskEvent(taskId: task.id),
                          );
                          _showSuccess('${task.title} deleted');
                        },
                        child: Card(
                          margin: EdgeInsets.only(bottom: height * 0.015),
                          child: ListTile(
                            onTap: () => TaskDetailSheet.show(
                              context,
                              task: task,
                              groups: state.taskGroups,
                            ),
                            leading: Checkbox(
                              value: isCompleted,
                              onChanged: (value) {
                                if (value == null) return;
                                context.read<HomeBloc>().add(
                                  UpdateTaskEvent(
                                    taskId: task.id,
                                    isCompleted: !isCompleted,
                                  ),
                                );
                              },
                            ),
                            title: Text(
                              task.title,
                              style: TextStyle(
                                decoration: isCompleted
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                _buildGroupChip(state.taskGroups, task.taskGroupId),
                                if (task.dueDate != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_today,
                                          size: 12,
                                          color: task.dueDate!.isBefore(DateTime.now())
                                              ? Colors.red.shade400
                                              : Colors.grey.shade500,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          _formatDate(task.dueDate!),
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: task.dueDate!.isBefore(DateTime.now())
                                                ? Colors.red.shade400
                                                : Colors.grey.shade500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (task.priority > 0)
                                  Container(
                                    margin: const EdgeInsets.only(right: 4),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: task.priority == 2
                                          ? Colors.red.shade50
                                          : Colors.orange.shade50,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: task.priority == 2
                                            ? Colors.red.shade200
                                            : Colors.orange.shade200,
                                      ),
                                    ),
                                    child: Text(
                                      task.priority == 2 ? 'High' : 'Medium',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: task.priority == 2
                                            ? Colors.red.shade700
                                            : Colors.orange.shade700,
                                      ),
                                    ),
                                  ),
                                IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: AppColors.primary,
                                  ),
                                  onPressed: () {
                                    _showEditTaskDialog(context, task);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  Widget _buildDismissBackground(double width, double height) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: width * 0.05),
      margin: EdgeInsets.only(bottom: height * 0.015),
      child: Icon(
        Icons.delete_forever,
        color: Colors.white,
        size: width * 0.08,
      ),
    );
  }

  Future<bool?> _showDeleteConfirmDialog(
    BuildContext context,
    String taskTitle,
  ) {
    return showDialog<bool>(
      context: context,
      builder: (context) => DeleteConfirmDialog(taskTitle: taskTitle),
    );
  }

  void _showEditTaskDialog(BuildContext context, dynamic task) async {
    final bool? success = await showDialog(
      context: context,
      builder: (context) => EditTaskDialog(task: task),
    );

    if (success ?? false) {
      _showSuccess('Task updated successfully!');
      _fetchTasks();
    }
  }

  Widget _buildGroupChip(List<TaskGroup>? groups, int taskGroupId) {
    if (groups == null) return const SizedBox.shrink();
    final group = groups.where((g) => g.id == taskGroupId).firstOrNull;
    if (group == null) return const SizedBox.shrink();
    final color = Color(int.parse(group.color.replaceFirst('#', '0xFF')));
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        group.name,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

class _DateChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final IconData? icon;

  const _DateChip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? Theme.of(context).colorScheme.primary
              : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected
                ? Theme.of(context).colorScheme.primary
                : Colors.grey.shade300,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 14,
                color: selected ? Colors.white : Colors.grey.shade600,
              ),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: TextStyle(
                color: selected ? Colors.white : Colors.grey.shade700,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? Theme.of(context).colorScheme.primary
              : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected
                ? Theme.of(context).colorScheme.primary
                : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.grey.shade700,
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
