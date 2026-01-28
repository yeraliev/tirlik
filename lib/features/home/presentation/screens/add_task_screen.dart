import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_task/core/database/app_database/app_database.dart';
import 'package:secure_task/core/router/route_names.dart';
import 'package:secure_task/core/validators/validators.dart';
import 'package:secure_task/core/widgets/custom_snackbar.dart';
import 'package:secure_task/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:secure_task/features/home/presentation/bloc/home_bloc.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descController;
  final _formKey = GlobalKey<FormState>();
  int? selectedGroupId;
  int selectedPriority = 0;
  DateTime? _dueDate;
  final Map<String, int> priorities = {'Low': 0, 'Medium': 1, 'High': 2};

  @override
  void initState() {
    _titleController = TextEditingController();
    _descController = TextEditingController();
    context.read<HomeBloc>().add(GetTaskGroupsEvent());
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Task',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state.status == HomeStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final taskGroups = state.taskGroups ?? [];

                    if (taskGroups.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('No task groups'),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () {
                                context.read<HomeBloc>().add(
                                  GetTaskGroupsEvent(),
                                );
                              },
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    }

                    return Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Choose your task type: ',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          _buildGroups(taskGroups),
                          SizedBox(height: height * 0.02),
                          TextFormField(
                            controller: _titleController,
                            decoration: const InputDecoration(
                              labelText: 'Title',
                              border: OutlineInputBorder(),
                            ),
                            validator: Validators.title,
                          ),
                          SizedBox(height: height * 0.02),
                          TextFormField(
                            controller: _descController,
                            maxLines: 4,
                            decoration: const InputDecoration(
                              labelText: 'Description',
                              border: OutlineInputBorder(),
                              alignLabelWithHint: true,
                            ),
                            validator: Validators.description,
                          ),
                          SizedBox(height: height * 0.02),
                          Text(
                            'Priority: ',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          _buildPriorities(priorities),
                          SizedBox(height: height * 0.02),
                          Text(
                            'Due date (optional): ',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          _buildDatePicker(),
                          SizedBox(height: 100),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: ElevatedButton(
                onPressed: () async {
                  final taskGroupError = Validators.taskGroup(selectedGroupId);
                  final priorityError = Validators.priority(selectedPriority);

                  if (_formKey.currentState!.validate() &&
                      selectedGroupId != null) {
                    final authState = context.read<AuthBloc>().state;
                    final userId = authState.user?.id;
                    if (userId == null) return;
                    context.read<HomeBloc>().add(
                      AddTaskEvent(
                        title: _titleController.text.trim(),
                        description: _descController.text.trim(),
                        taskGroupId: selectedGroupId!,
                        userId: userId,
                        priority: selectedPriority,
                        dueDate: _dueDate,
                      ),
                    );

                    context.goNamed(RouteNames.home);
                  } else {
                    if (taskGroupError != null) {
                      _showError(taskGroupError);
                    } else if (priorityError != null) {
                      _showError(priorityError);
                    }
                  }
                },
                child: const Text('Save Task'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroups(List<TaskGroup> taskGroups) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: taskGroups.map((group) {
        final isSelected = selectedGroupId == group.id;
        return InkWell(
          onTap: () {
            setState(() {
              if (selectedGroupId == group.id) {
                selectedGroupId = null;
              } else {
                selectedGroupId = group.id;
              }
            });
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey.shade300,
              ),
            ),
            child: Text(
              group.name,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPriorities(Map<String, int> priorities) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: priorities.entries.map((entry) {
        final isSelected = selectedPriority == entry.value;
        return InkWell(
          onTap: () {
            setState(() {
              selectedPriority = entry.value;
            });
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey.shade300,
              ),
            ),
            child: Text(
              entry.key,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDatePicker() {
    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: _dueDate ?? DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
        );
        if (picked != null) setState(() => _dueDate = picked);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(
          _dueDate != null
              ? '${_dueDate!.day.toString().padLeft(2, '0')}/${_dueDate!.month.toString().padLeft(2, '0')}/${_dueDate!.year}'
              : 'Pick a due date',
          style: TextStyle(
            color: _dueDate != null ? Colors.black87 : Colors.grey.shade600,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
