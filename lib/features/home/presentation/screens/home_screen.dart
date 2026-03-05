import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_task/core/locale/locale_cubit.dart';
import 'package:secure_task/core/router/route_names.dart';
import 'package:secure_task/core/theme/app_colors.dart';
import 'package:secure_task/features/home/presentation/widgets/home_button.dart';
import 'package:secure_task/features/home/presentation/widgets/notes_tab.dart';
import 'package:secure_task/features/home/presentation/widgets/tasks_tab.dart';
import 'package:secure_task/l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void _showLanguageSelector(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final currentLocale = context.read<LocaleCubit>().state;

    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: Text(l10n.language),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLanguageOption(
              context: context,
              dialogContext: dialogCtx,
              languageCode: 'en',
              languageName: 'English 🇺🇸',
              currentLocale: currentLocale,
            ),
            const SizedBox(height: 8),
            _buildLanguageOption(
              context: context,
              dialogContext: dialogCtx,
              languageCode: 'ru',
              languageName: 'Русский 🇷🇺',
              currentLocale: currentLocale,
            ),
            const SizedBox(height: 8),
            _buildLanguageOption(
              context: context,
              dialogContext: dialogCtx,
              languageCode: 'kk',
              languageName: 'Қазақша 🇰🇿',
              currentLocale: currentLocale,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption({
    required BuildContext context,
    required BuildContext dialogContext,
    required String languageCode,
    required String languageName,
    required Locale currentLocale,
  }) {
    final isSelected = currentLocale.languageCode == languageCode;

    return Material(
      color: isSelected
          ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.2)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: () {
          context.read<LocaleCubit>().setLocale(Locale(languageCode));
          Navigator.pop(dialogContext);
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: Theme.of(context).colorScheme.primary,
                  size: 20,
                )
              else
                const Icon(Icons.circle_outlined, size: 20, color: Colors.grey),
              const SizedBox(width: 12),
              Text(
                languageName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.09,
                height: MediaQuery.of(context).size.width * 0.09,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Image.asset('assets/logo_main.png'),
                ),
              ),
            ),
            const Text(
              'TIRLIK',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        actions: [
          Tooltip(
            message: l10n.language,
            child: IconButton(
              icon: Icon(
                Icons.language,
                size: 24,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              onPressed: () => _showLanguageSelector(context),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: homeButton(
                        text: l10n.addTask,
                        color: AppColors.buttonOrange,
                        context: context,
                        icon: Icons.add_task,
                        onTap: () => context.pushNamed(RouteNames.addTask),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: homeButton(
                        text: l10n.addNote,
                        color: AppColors.buttonBlue,
                        context: context,
                        icon: Icons.note_add,
                        onTap: () => context.pushNamed(RouteNames.addNote),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: homeButton(
                        text: l10n.tasks,
                        color: AppColors.buttonGreen,
                        context: context,
                        icon: Icons.list_alt,
                        onTap: () => context.pushNamed(RouteNames.allTasks),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: homeButton(
                        text: l10n.notes,
                        color: AppColors.accent,
                        context: context,
                        icon: Icons.notes,
                        onTap: () => context.pushNamed(RouteNames.allNotes),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: TabBar(
                      controller: tabController,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      labelColor: Theme.of(context).colorScheme.onPrimary,
                      unselectedLabelColor: Colors.black54,
                      labelStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      unselectedLabelStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      tabs: [
                        Tab(text: l10n.tasks),
                        Tab(text: l10n.notes),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [TasksTab(), NotesTab()],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
