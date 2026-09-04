import 'package:flutter/material.dart';

Future<Map<String, String>?> showAddItemDialog(
  BuildContext context, {
  required String checklistName,
  required String groupName,
}) {
  return showItemDialog(
    context,
    checklistName: checklistName,
    groupName: groupName,
  );
}

Future<Map<String, String>?> showEditItemDialog(
  BuildContext context, {
  required String checklistName,
  required String groupName,
  required String subSystem,
  required String description,
}) {
  return showItemDialog(
    context,
    checklistName: checklistName,
    groupName: groupName,
    subSystem: subSystem,
    description: description,
    isEdit: true,
  );
}

Future<Map<String, String>?> showItemDialog(
  BuildContext context, {
  required String checklistName,
  required String groupName,
  String subSystem = '',
  String description = '',
  bool isEdit = false,
}) {
  final subSystemController = TextEditingController(text: subSystem);
  final descriptionController = TextEditingController(text: description);

  return showDialog<Map<String, String>>(
    context: context,
    builder: (dialogContext) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1000,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isMobile = constraints.maxWidth < 700;

                    if (isMobile) {
                      return Column(
                        children: [
                          _buildReadOnlyField(
                            label: "ChecklistName",
                            value: checklistName,
                          ),
                          const SizedBox(height: 16),
                          _buildReadOnlyField(
                            label: "Group Name",
                            value: groupName,
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: subSystemController,
                            label: "Sub System",
                            hint: "Enter Sub System",
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: descriptionController,
                            label: "Check Description",
                            hint: "Enter Check Description",
                            maxLines: 4,
                          ),
                        ],
                      );
                    }

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildReadOnlyField(
                            label: "ChecklistName",
                            value: checklistName,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: _buildReadOnlyField(
                            label: "Group Name",
                            value: groupName,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: _buildTextField(
                            controller: subSystemController,
                            label: "Sub System",
                            hint: "Enter Sub System",
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: _buildTextField(
                            controller: descriptionController,
                            label: "Check Description",
                            hint: "Enter Check Description",
                            maxLines: 4,
                          ),
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {
                        subSystemController.clear();
                        descriptionController.clear();
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text("Reset"),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                      ),
                    ),

                    const SizedBox(width: 10),

                    FilledButton.icon(
                      onPressed: () {
                        final newSubSystem =
                            subSystemController.text.trim();

                        final newDescription =
                            descriptionController.text.trim();

                        if (newSubSystem.isEmpty ||
                            newDescription.isEmpty) {
                          return;
                        }

                        Navigator.pop(
                          dialogContext,
                          {
                            "subSystem": newSubSystem,
                            "description": newDescription,
                          },
                        );
                      },
                      icon: const Icon(Icons.save),
                      label: Text(isEdit ? "Update" : "Save"),
                    ),

                    const SizedBox(width: 10),

                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(dialogContext);
                      },
                      child: const Text("Close"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget _buildReadOnlyField({
  required String label,
  required String value,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "$label*",
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(height: 6),
      TextFormField(
        initialValue: value,
        readOnly: true,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
    ],
  );
}

Widget _buildTextField({
  required TextEditingController controller,
  required String label,
  required String hint,
  int maxLines = 1,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "$label*",
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(height: 6),
      TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          border: const OutlineInputBorder(),
          alignLabelWithHint: true,
        ),
      ),
    ],
  );
}