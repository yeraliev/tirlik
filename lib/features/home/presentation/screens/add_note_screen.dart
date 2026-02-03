import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_task/core/theme/app_colors.dart';
import 'package:secure_task/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:secure_task/features/home/presentation/bloc/home_bloc.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _contentFocusNode = FocusNode();
  bool _isPinned = false;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _titleFocusNode.dispose();
    _contentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isPinned ? Icons.push_pin : Icons.push_pin_outlined,
              color: _isPinned ? Colors.amber : Colors.grey,
              size: 25,
            ),
            onPressed: () {
              setState(() {
                _isPinned = !_isPinned;
              });
            },
          ),
          TextButton(
            onPressed: () => _saveNote(context),
            child: const Text(
              'Done',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                focusNode: _titleFocusNode,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  hintText: 'Title',
                  hintStyle: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  fillColor: AppColors.background,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                ),
                textCapitalization: TextCapitalization.sentences,
                maxLines: null,
                onSubmitted: (_) {
                  _contentFocusNode.requestFocus();
                },
              ),
              const SizedBox(height: 6),
              Divider(color: Colors.grey),
              const SizedBox(height: 6),
              Expanded(
                child: TextField(
                  controller: _contentController,
                  focusNode: _contentFocusNode,
                  style: const TextStyle(fontSize: 17),
                  decoration: const InputDecoration(
                    hintText: 'Note',
                    hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
                    fillColor: AppColors.background,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveNote(BuildContext context) {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();
    final authState = context.read<AuthBloc>().state;
    final userId = authState.user?.id;
    if (userId == null) return;

    if (title.isEmpty && content.isEmpty) {
      Navigator.pop(context);
      return;
    } else {
      context.read<HomeBloc>().add(
        AddNoteEvent(
          title: title,
          content: content,
          userId: userId,
          isPinned: _isPinned,
        ),
      );
    }
    Navigator.pop(context);
  }
}
