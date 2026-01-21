import 'package:flutter/material.dart';

class CustomSnackbar {
  static SnackBar errorSnackbar({
    required String error,
    required VoidCallback onPressed,
  }) => SnackBar(
    content: Row(
      children: [
        Icon(Icons.error_outline_rounded, color: Colors.red, size: 20),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            error,
            style: TextStyle(color: Colors.black87, fontSize: 16),
            maxLines: 4,
          ),
        ),
        SizedBox(width: 10),
        IconButton(
          onPressed: onPressed,
          icon: Icon(Icons.clear_rounded, color: Colors.black87, size: 20),
        ),
      ],
    ),
    backgroundColor: Colors.white,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.all(20),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.all(Radius.circular(20)),
    ),
  );
}
