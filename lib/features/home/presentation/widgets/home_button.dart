import 'package:flutter/material.dart';

Widget homeButton({
  required String text,
  required Color color,
  required BuildContext context,
  IconData? icon,
}) {
  return GestureDetector(
    onTap: () {
      print('$text pressed');
    },
    child: Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 35),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 25,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ],
            SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
