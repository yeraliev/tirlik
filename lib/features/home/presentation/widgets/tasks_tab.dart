import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_task/core/theme/app_colors.dart';
import 'package:secure_task/core/widgets/custom_snackbar.dart';
import 'package:secure_task/features/home/presentation/bloc/home_bloc.dart';
import 'package:secure_task/features/home/presentation/widgets/delete_task.dart';
import 'package:secure_task/features/home/presentation/widgets/edit_task.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetTasksEvent());
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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.status == HomeStatus.error) {
          _showError(state.error!);
        }
      },
      builder: (context, state) {
        if (state.status == HomeStatus.loading) {
          return Center(child: CircularProgressIndicator());
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
                  style: TextStyle(fontSize: width * 0.04, color: Colors.red),
                ),
                SizedBox(height: height * 0.02),
                ElevatedButton(
                  onPressed: () {
                    context.read<HomeBloc>().add(GetTasksEvent());
                  },
                  child: Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (state.tasks == null || state.tasks!.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.task_alt, size: width * 0.2, color: Colors.grey),
                SizedBox(height: height * 0.02),
                Text(
                  'No tasks yet',
                  style: TextStyle(fontSize: width * 0.045, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(width * 0.04),
          itemCount: state.tasks!.length,
          itemBuilder: (context, index) {
            final task = state.tasks![index];
            final isCompleted = task.isCompleted;

            return Dismissible(
              key: Key(task.id.toString()),
              direction: DismissDirection.endToStart,
              confirmDismiss: (direction) async {
                return await _showDeleteConfirmDialog(context, task.title);
              },
              background: _buildDismissBackground(width, height),
              onDismissed: (direction) {
                context.read<HomeBloc>().add(DeleteTaskEvent(taskId: task.id));

                _showSuccess('${task.title} deleted');
              },
              child: Card(
                margin: EdgeInsets.only(bottom: height * 0.015),
                child: ListTile(
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration: isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
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
                  subtitle: Text(
                    task.description ?? "",
                    maxLines: 3,
                    overflow: TextOverflow.fade,
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit, color: AppColors.primary),
                    onPressed: () {
                      _showEditTaskDialog(context, task);
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
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
    }
  }
}
