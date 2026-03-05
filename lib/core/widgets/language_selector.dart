import 'package:flutter/material.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Locale>(
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Locale>>[
        const PopupMenuItem<Locale>(
          value: Locale('en'),
          child: Row(
            children: [Text('🇺🇸 '), SizedBox(width: 8), Text('English')],
          ),
        ),
        const PopupMenuItem<Locale>(
          value: Locale('ru'),
          child: Row(
            children: [Text('🇷🇺 '), SizedBox(width: 8), Text('Русский')],
          ),
        ),
        const PopupMenuItem<Locale>(
          value: Locale('kk'),
          child: Row(
            children: [Text('🇰🇿 '), SizedBox(width: 8), Text('Қазақ')],
          ),
        ),
      ],
      child: Tooltip(
        message: 'Change Language',
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          child: const Text('🌐', style: TextStyle(fontSize: 20)),
        ),
      ),
    );
  }
}
