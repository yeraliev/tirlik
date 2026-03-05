import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_task/core/database/app_database/app_database.dart';
import 'package:secure_task/core/router/route_names.dart';
import 'package:secure_task/core/validators/validators.dart';
import 'package:secure_task/core/widgets/custom_snackbar.dart';
import 'package:secure_task/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:secure_task/features/home/presentation/bloc/home_bloc.dart';
import 'package:secure_task/l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;
    double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.addTask,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
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
                    final l10n = AppLocalizations.of(context)!;
                    final v = Validators.of(context);
                    final priorities = {
                      l10n.low: 0,
                      l10n.medium: 1,
                      l10n.high: 2,
                    };

                    if (state.status == HomeStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final taskGroups = state.taskGroups ?? [];

                    return Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.chooseTaskType,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          _buildGroups(taskGroups, l10n),
                          SizedBox(height: height * 0.02),
                          TextFormField(
                            controller: _titleController,
                            decoration: InputDecoration(
                              labelText: l10n.title,
                              border: const OutlineInputBorder(),
                            ),
                            validator: v.title,
                          ),
                          SizedBox(height: height * 0.02),
                          TextFormField(
                            controller: _descController,
                            maxLines: 4,
                            decoration: InputDecoration(
                              labelText: l10n.description,
                              border: const OutlineInputBorder(),
                              alignLabelWithHint: true,
                            ),
                            validator: v.description,
                          ),
                          SizedBox(height: height * 0.02),
                          Text(
                            l10n.priorityLabel,
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
                            l10n.dueDateLabel,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          _buildDatePicker(l10n),
                          const SizedBox(height: 100),
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
                  final v = Validators.of(context);
                  final taskGroupError = v.taskGroup(selectedGroupId);
                  final priorityError = v.priority(selectedPriority);

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
                child: Text(l10n.saveTask),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroups(List<TaskGroup> taskGroups, AppLocalizations l10n) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        ...taskGroups.map((group) {
          final isSelected = selectedGroupId == group.id;
          return InkWell(
            onTap: () {
              setState(() {
                selectedGroupId = selectedGroupId == group.id ? null : group.id;
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
        }),
        InkWell(
          onTap: () => _showCreateGroupDialog(),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                style: BorderStyle.solid,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add,
                  size: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 4),
                Text(
                  l10n.newType,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showCreateGroupDialog() {
    final l10n = AppLocalizations.of(context)!;
    final nameController = TextEditingController();
    String selectedColor = '#6C63FF';
    final colors = [
      '#6C63FF',
      '#FF6B35',
      '#4A90E2',
      '#00C853',
      '#7C4DFF',
      '#E91E63',
      '#009688',
      '#FF9800',
    ];

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Text(l10n.newTaskType),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: l10n.nameLabel,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.color,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: colors.map((hex) {
                      final color = Color(
                        int.parse(hex.replaceFirst('#', '0xFF')),
                      );
                      final isSelected = selectedColor == hex;
                      return GestureDetector(
                        onTap: () => setDialogState(() => selectedColor = hex),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? Colors.black87
                                  : Colors.transparent,
                              width: 2.5,
                            ),
                          ),
                          child: isSelected
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 16,
                                )
                              : null,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text(l10n.cancel),
                ),
                ElevatedButton(
                  onPressed: () {
                    final name = nameController.text.trim();
                    if (name.isEmpty) return;
                    final authState = context.read<AuthBloc>().state;
                    final userId = authState.user?.id;
                    if (userId == null) return;
                    context.read<HomeBloc>().add(
                      CreateTaskGroupEvent(
                        name: name,
                        color: selectedColor,
                        userId: userId,
                      ),
                    );
                    Navigator.of(ctx).pop();
                  },
                  child: Text(l10n.create),
                ),
              ],
            );
          },
        );
      },
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

  Widget _buildDatePicker(AppLocalizations l10n) {
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
              : l10n.pickADueDate,
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
