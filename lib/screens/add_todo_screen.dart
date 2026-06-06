import 'package:flutter/material.dart';

class AddTodoScreen extends StatefulWidget {
  final Map<String, dynamic>? existingTodo;
  const AddTodoScreen({super.key, this.existingTodo});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final _titleController = TextEditingController();
  final List<Map<String, dynamic>> _todoItems = [];

  @override
  void initState() {
    super.initState();

    // Load existing data if editing
    if (widget.existingTodo != null) {
      _titleController.text = widget.existingTodo!['title'] ?? '';

      final savedItems = widget.existingTodo!['items'] ?? [];
      for (final item in savedItems) {
        _todoItems.add({
          'text': item['text'],
          'checked': item['checked'],
        });
      }
    }

    // Add empty item if none exist
    if (_todoItems.isEmpty) {
      _todoItems.add({'text': '', 'checked': false});
    }
  }

  void _addItem() {
    setState(() {
      _todoItems.add({'text': '', 'checked': false});
    });
  }

  void _saveTodo() {
    final title = _titleController.text.trim();
    final nonEmptyItems =
        _todoItems.where((item) => item['text'].trim().isNotEmpty).toList();

    if (title.isEmpty && nonEmptyItems.isEmpty) {
      Navigator.pop(context); // nothing to save
      return;
    }

    final newTodo = {
      'title': title.isEmpty ? '(Untitled)' : title,
      'items': nonEmptyItems,
      'date': '${DateTime.now().day} ${_monthName(DateTime.now().month)}',
      'isTodo': true,
    };

    Navigator.pop(context, newTodo);
  }

  String _monthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add To-do'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveTodo,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Checklist Title',
                border: InputBorder.none,
              ),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ..._todoItems.map((item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        item['checked']
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: item['checked'] ? Colors.orange : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          item['checked'] = !item['checked'];
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        onChanged: (val) {
                          item['text'] = val;
                        },
                        controller: TextEditingController(text: item['text']),
                        decoration: const InputDecoration(
                          hintText: 'To-do item',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            TextButton.icon(
              onPressed: _addItem,
              icon: const Icon(Icons.add),
              label: const Text('Add another item'),
            )
          ],
        ),
      ),
    );
  }
}
