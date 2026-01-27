import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_task/core/theme/app_colors.dart';
import 'package:secure_task/features/home/presentation/bloc/home_bloc.dart';
// Import your NoteBloc and states

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
                    context.read<HomeBloc>().add(GetNotesEvent());
                  },
                  child: Text('Retry'),
                ),
              ],
            ),
          );
        }
        if (state.notes == null || state.notes!.isEmpty) {
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
                  'No notes yet',
                  style: TextStyle(fontSize: width * 0.045, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(width * 0.04),
          itemCount: state.notes!.length,
          itemBuilder: (context, index) {
            final note = state.notes![index];

            return Card(
              margin: EdgeInsets.only(bottom: height * 0.015),
              child: ListTile(
                leading: Icon(Icons.note, color: AppColors.buttonBlue),
                title: Text(note.title),
                subtitle: Text(note.content),
                trailing: Icon(Icons.arrow_forward_ios, size: width * 0.04),
                onTap: () {
                  // Navigate to note detail
                },
              ),
            );
          },
        );
      },
    );
  }
}
