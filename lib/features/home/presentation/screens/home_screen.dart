import 'package:flutter/material.dart';
import 'package:secure_task/core/theme/app_colors.dart';
import 'package:secure_task/features/home/presentation/widgets/home_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
