import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_task/core/theme/app_colors.dart';
import 'package:secure_task/features/home/presentation/bloc/home_bloc.dart';

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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return BlocBuilder<HomeBloc, HomeState>(
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

            return Card(
              margin: EdgeInsets.only(bottom: height * 0.015),
              child: ListTile(
                leading: Icon(Icons.circle, color: Colors.red, size: 16),
                title: Text(task.title),
                trailing: Checkbox(
                  value: isCompleted,
                  onChanged: (value) {
                    if (value == null) return;
                  },
                ),
                subtitle: Text(task.description ?? ""),
              ),
            );
          },
        );
      },
    );
  }
}
