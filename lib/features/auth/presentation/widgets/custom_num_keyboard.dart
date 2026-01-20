import 'package:flutter/material.dart';

class CustomNumKeyboard extends StatefulWidget {
  final TextEditingController controller;
  final Function(String)? onComplete;

  const CustomNumKeyboard({
    super.key,
    required this.controller,
    this.onComplete,
  });

  @override
  State<CustomNumKeyboard> createState() => _CustomNumKeyboardState();
}

class _CustomNumKeyboardState extends State<CustomNumKeyboard> {
  void _addPinChar(String text) {
    if (widget.controller.text.length < 4) {
      widget.controller.text = widget.controller.text + text;
      
      if (widget.controller.text.length == 4 && widget.onComplete != null) {
        widget.onComplete!(widget.controller.text);
      }
    }
  }

  void _clearAll() {
    widget.controller.clear();
  }

  void _removeLast() {
    if (widget.controller.text.isNotEmpty) {
      widget.controller.text = 
          widget.controller.text.substring(0, widget.controller.text.length - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            circleTextButton(
              text: '1',
              onPressed: () => _addPinChar('1'),
              context: context,
            ),
            circleTextButton(
              text: '2',
              onPressed: () => _addPinChar('2'),
              context: context,
            ),
            circleTextButton(
              text: '3',
              onPressed: () => _addPinChar('3'),
              context: context,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            circleTextButton(
              text: '4',
              onPressed: () => _addPinChar('4'),
              context: context,
            ),
            circleTextButton(
              text: '5',
              onPressed: () => _addPinChar('5'),
              context: context,
            ),
            circleTextButton(
              text: '6',
              onPressed: () => _addPinChar('6'),
              context: context,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            circleTextButton(
              text: '7',
              onPressed: () => _addPinChar('7'),
              context: context,
            ),
            circleTextButton(
              text: '8',
              onPressed: () => _addPinChar('8'),
              context: context,
            ),
            circleTextButton(
              text: '9',
              onPressed: () => _addPinChar('9'),
              context: context,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            circleTextButton(
              text: 'delete all',
              onPressed: _clearAll,
              context: context,
              icon: Icons.clear_all,
            ),
            circleTextButton(
              text: '0',
              onPressed: () => _addPinChar('0'),
              context: context,
            ),
            circleTextButton(
              text: 'remove',
              onPressed: _removeLast,
              context: context,
              icon: Icons.backspace_rounded,
            ),
          ],
        ),
      ],
    );
  }

  Widget circleTextButton({
    required String text,
    required VoidCallback onPressed,
    required BuildContext context,
    IconData? icon,
  }) {
    return Expanded(
      child: icon != null
          ? IconButton(
              onPressed: onPressed,
              style: IconButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(24),
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
              icon: Icon(icon, size: 24),
            )
          : TextButton(
              onPressed: onPressed,
              style: TextButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(24),
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
              child: Text(text, style: const TextStyle(fontSize: 24)),
            ),
    );
  }
}