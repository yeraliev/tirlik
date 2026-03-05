import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_task/core/router/route_names.dart';
import 'package:secure_task/core/theme/app_colors.dart';
import 'package:secure_task/features/home/presentation/bloc/home_bloc.dart';
import 'package:secure_task/l10n/app_localizations.dart';

class NotesTab extends StatefulWidget {
  const NotesTab({super.key});

  @override
  State<NotesTab> createState() => _NotesTabState();
}

class _NotesTabState extends State<NotesTab> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetNotesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return BlocBuilder<HomeBloc, HomeState>(
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
                  style: TextStyle(fontSize: width * 0.04, color: Colors.red),
                ),
                SizedBox(height: height * 0.02),
                ElevatedButton(
                  onPressed: () {
                    context.read<HomeBloc>().add(GetNotesEvent());
                  },
                  child: Text(l10n.retry),
                ),
              ],
            ),
          );
        }

        final notes = state.notes;

        if (notes == null || notes.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.note_outlined,
                  size: width * 0.2,
                  color: Colors.grey,
                ),
                SizedBox(height: height * 0.02),
                Text(
                  l10n.noNotesYet,
                  style: TextStyle(fontSize: width * 0.045, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(width * 0.04),
          itemCount: notes.length,
          itemBuilder: (context, index) {
            final note = notes[index];

            return Card(
              margin: EdgeInsets.only(bottom: height * 0.015),
              child: ListTile(
                leading: Icon(
                  note.isPinned ? Icons.push_pin : Icons.note,
                  color: note.isPinned
                      ? AppColors.primary
                      : AppColors.buttonBlue,
                ),
                title: Text(
                  note.title,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  note.content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: note.isPinned
                    ? const Icon(
                        Icons.push_pin,
                        size: 16,
                        color: AppColors.primary,
                      )
                    : null,
                onTap: () async {
                  final updated = await context.pushNamed(
                    RouteNames.editNote,
                    extra: {
                      'noteId': note.id,
                      'title': note.title,
                      'content': note.content,
                      'isPinned': note.isPinned,
                    },
                  );
                  if (updated == true && context.mounted) {
                    context.read<HomeBloc>().add(GetNotesEvent());
                  }
                },
              ),
            );
          },
        );
      },
    );
  }
}
