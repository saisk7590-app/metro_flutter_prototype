import 'package:flutter/material.dart';

import '../../constants/checklist_data.dart';
import '../../widgets/checklist/add_group_dialog.dart';
import '../../widgets/checklist/add_item_dialog.dart';

class ChecklistEditScreen extends StatefulWidget {
  final String checklistName;

  const ChecklistEditScreen({super.key, required this.checklistName});

  @override
  State<ChecklistEditScreen> createState() => _ChecklistEditScreenState();
}

class _ChecklistEditScreenState extends State<ChecklistEditScreen> {
  late List<Map<String, dynamic>> groups;

  @override
  void initState() {
    super.initState();

    groups = ChecklistData.groups.map((group) {
      return {
        "name": group["name"],
        "expanded": false,
        "items": List<Map<String, String>>.from(
          (group["items"] as List).map(
            (item) => Map<String, String>.from(item),
          ),
        ),
      };
    }).toList();
  }

  void toggleGroup(int index) {
    setState(() {
      groups[index]["expanded"] = !groups[index]["expanded"];
    });
  }

  Future<void> addGroup() async {
    final groupName = await showAddGroupDialog(context);

    if (groupName == null || groupName.isEmpty) {
      return;
    }

    setState(() {
      groups.add({
        "name": groupName,
        "expanded": false,
        "items": <Map<String, String>>[],
      });
    });
  }

  Future<void> addItem(int groupIndex) async {
    final item = await showAddItemDialog(
      context,
      checklistName: widget.checklistName,
      groupName: groups[groupIndex]["name"],
    );

    if (item == null) {
      return;
    }

    setState(() {
      final items = groups[groupIndex]["items"] as List<Map<String, String>>;

      items.add(item);
    });
  }

  Future<void> editItem(int groupIndex, int itemIndex) async {
    final items = groups[groupIndex]["items"] as List<Map<String, String>>;

    final item = items[itemIndex];

    final updatedItem = await showEditItemDialog(
      context,
      checklistName: widget.checklistName,
      groupName: groups[groupIndex]["name"],
      subSystem: item["subSystem"] ?? "",
      description: item["description"] ?? "",
    );

    if (updatedItem == null) {
      return;
    }

    setState(() {
      items[itemIndex] = updatedItem;
    });
  }

  Future<void> deleteItem(int groupIndex, int itemIndex) async {
    final items = groups[groupIndex]["items"] as List;

    final item = items[itemIndex] as Map;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text("Delete Item"),
          content: Text(
            "Are you sure you want to delete\n\n"
            "${item["description"]}?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text("Cancel"),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );

    if (confirmed != true) {
      return;
    }

    setState(() {
      items.removeAt(itemIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        title: const Text("Edit Checklist"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          _buildChecklistHeader(context),
          _buildAddGroupButton(context),
          Divider(height: 1, color: colors.outlineVariant),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: groups.length,
              itemBuilder: (context, index) {
                return _buildGroup(context, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChecklistHeader(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Checklist Name",
            style: TextStyle(fontSize: 13, color: colors.onSurfaceVariant),
          ),
          const SizedBox(height: 6),
          Text(
            widget.checklistName,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Widget _buildAddGroupButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
      child: Align(
        alignment: Alignment.centerRight,
        child: ElevatedButton.icon(
          onPressed: addGroup,
          icon: const Icon(Icons.add),
          label: const Text("Add Group"),
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGroup(BuildContext context, int index) {
    final colors = Theme.of(context).colorScheme;
    final group = groups[index];
    final bool expanded = group["expanded"];
    final List<Map<String, String>> items = group["items"];

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: colors.outlineVariant),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => toggleGroup(index),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Icon(
                    expanded
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_right,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      group["name"],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: colors.primary,
                      ),
                    ),
                  ),

                  TextButton.icon(
                    onPressed: () {
                      addItem(index);
                    },
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text("Add Item"),
                  ),
                ],
              ),
            ),
          ),

          if (expanded) _buildItems(context, index, items),
        ],
      ),
    );
  }

  Widget _buildItems(
    BuildContext context,
    int groupIndex,
    List<Map<String, String>> items,
  ) {
    if (items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: Text("No items added"),
      );
    }

    return Column(
      children: [
        const Divider(height: 1),
        ...List.generate(
          items.length,
          (itemIndex) =>
              _buildItem(context, groupIndex, itemIndex, items[itemIndex]),
        ),
      ],
    );
  }

  Widget _buildItem(
    BuildContext context,
    int groupIndex,
    int itemIndex,
    Map<String, String> item,
  ) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: colors.outlineVariant)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item["subSystem"] ?? "",
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(item["description"] ?? ""),
              ],
            ),
          ),

          IconButton(
            tooltip: "Edit",
            icon: Icon(Icons.edit_outlined, color: colors.primary),
            onPressed: () {
              editItem(groupIndex, itemIndex);
            },
          ),

          IconButton(
            tooltip: "Delete",
            icon: Icon(Icons.delete_outline, color: colors.error),
            onPressed: () {
              deleteItem(groupIndex, itemIndex);
            },
          ),
        ],
      ),
    );
  }
}
