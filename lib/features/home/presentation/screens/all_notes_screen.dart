import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_task/core/router/route_names.dart';
import 'package:secure_task/core/theme/app_colors.dart';
import 'package:secure_task/features/home/presentation/bloc/home_bloc.dart';
import 'package:secure_task/l10n/app_localizations.dart';

class AllNotesScreen extends StatefulWidget {
  const AllNotesScreen({super.key});

  @override
  State<AllNotesScreen> createState() => _AllNotesScreenState();
}

class _AllNotesScreenState extends State<AllNotesScreen> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    context.read<HomeBloc>().add(SearchNotesEvent(query: ''));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.allNotes,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  context.read<HomeBloc>().add(
                    SearchNotesEvent(query: value.trim()),
                  );
                },
                decoration: InputDecoration(
                  hintText: l10n.searchNotes,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            context.read<HomeBloc>().add(
                              SearchNotesEvent(query: ''),
                            );
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
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
                            onPressed: () {
                              context.read<HomeBloc>().add(
                                SearchNotesEvent(
                                  query: _searchController.text.trim(),
                                ),
                              );
                            },
                            child: Text(l10n.retry),
                          ),
                        ],
                      ),
                    );
                  }

                  final notes = state.searchedNotes;

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
                            _searchController.text.isEmpty
                                ? l10n.noNotesYet
                                : l10n.noResultsFound,
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
                              context.read<HomeBloc>().add(
                                SearchNotesEvent(
                                  query: _searchController.text.trim(),
                                ),
                              );
                            }
                          },
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
}
