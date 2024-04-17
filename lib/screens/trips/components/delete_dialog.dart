import 'package:flutter/material.dart';
import 'package:travel_app/utils/constants/colors.dart';

class DeleteConfirmDialog extends StatelessWidget {
  const DeleteConfirmDialog({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Confirm deletion",
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      backgroundColor: MyColors.light,
      surfaceTintColor: MyColors.light,
      content: Text(
        "Are you sure you want to delete $name trip?",
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
            child: const Text(
              "Delete",
              style: TextStyle(
                color: MyColors.primary,
              ),
            )),
      ],
    );
  }
}
