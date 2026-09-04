import 'package:flutter/material.dart';

Future<String?> showAddGroupDialog(BuildContext context) {
  final controller = TextEditingController();

  return showDialog<String>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: const Text("Add Group"),
        content: TextField(
          controller: controller,
          autofocus: true,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(
            labelText: "Group Name",
            hintText: "Enter group name",
            border: OutlineInputBorder(),
          ),
          onSubmitted: (value) {
            final name = value.trim();

            if (name.isNotEmpty) {
              Navigator.pop(dialogContext, name);
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
            },
            child: const Text("Cancel"),
          ),
          FilledButton(
            onPressed: () {
              final name = controller.text.trim();

              if (name.isNotEmpty) {
                Navigator.pop(dialogContext, name);
              }
            },
            child: const Text("Add"),
          ),
        ],
      );
    },
  );
}