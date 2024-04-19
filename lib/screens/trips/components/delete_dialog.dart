import 'package:flutter/material.dart';
import 'package:travel_app/utils/constants/colors.dart';

class DeleteConfirmDialog extends StatelessWidget {
  const DeleteConfirmDialog({
    super.key,
    required this.title,
    required this.content,
    required this.action,
  });

  final String title;
  final String content;
  final String action;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
      backgroundColor: MyColors.light,
      surfaceTintColor: MyColors.light,
      content: Text(
        content,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
      contentPadding: const EdgeInsets.only(
        left: 24.0,
        top: 16.0,
        right: 24.0,
        bottom: 5.0,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text(
            "Cancel",
            style: TextStyle(
              color: MyColors.primary,
            ),
          ),
        ),
        TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              action,
              style: const TextStyle(
                color: MyColors.primary,
              ),
            )),
      ],
    );
  }
}
