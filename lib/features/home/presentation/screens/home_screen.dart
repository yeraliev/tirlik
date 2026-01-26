import 'package:flutter/material.dart';
import 'package:secure_task/core/theme/app_colors.dart';
import 'package:secure_task/features/home/presentation/widgets/home_button.dart';

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

  @override
  Widget build(BuildContext context) {
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
            Text(
              'TIRLIK',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
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
                        text: 'Add Task',
                        color: AppColors.buttonOrange,
                        context: context,
                        icon: Icons.add_task,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: homeButton(
                        text: 'Add Note',
                        color: AppColors.buttonBlue,
                        context: context,
                        icon: Icons.note_add,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: homeButton(
                        text: 'Tasks',
                        color: AppColors.buttonGreen,
                        context: context,
                        icon: Icons.list_alt,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: homeButton(
                        text: 'Notes',
                        color: AppColors.buttonPurple,
                        context: context,
                        icon: Icons.notes,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
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
                      tabs: const [
                        Tab(text: 'Tasks'),
                        Tab(text: 'Notes'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.task_alt, size: 64),
                            SizedBox(height: 16),
                            Text(
                              'There is no task',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      // Notes Tab Content
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.note, size: 64),
                            SizedBox(height: 16),
                            Text(
                              'There is no pinned notes',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ],
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
