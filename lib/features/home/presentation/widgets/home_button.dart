import 'package:flutter/material.dart';

Widget homeButton({
  required String text,
  required Color color,
  required BuildContext context,
  IconData? icon,
  VoidCallback? onTap,
  int? maxLines,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 25,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ],
            const SizedBox(height: 8),
            Text(
              text,
              textAlign: TextAlign.center,
              maxLines: maxLines ?? 1,
              overflow: TextOverflow.ellipsis,
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
