import 'package:flutter/material.dart';

class AddNoteScreen extends StatefulWidget {
  final Map<String, dynamic>? existingNote;

  const AddNoteScreen({super.key, this.existingNote});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  Color selectedColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
        text: widget.existingNote != null ? widget.existingNote!['title'] : '');
    _contentController = TextEditingController(
        text:
            widget.existingNote != null ? widget.existingNote!['preview'] : '');
    selectedColor = widget.existingNote != null
        ? widget.existingNote!['color']
        : Colors.white;
  }

  void _saveNote() {
    if (_titleController.text.trim().isEmpty &&
        _contentController.text.trim().isEmpty) {
      Navigator.pop(context);
      return;
    }

    final newNote = {
      'title': _titleController.text.trim().isEmpty
          ? '(Untitled)'
          : _titleController.text.trim(),
      'preview': _contentController.text.trim(),
      'color': selectedColor,
      'date': '${DateTime.now().day} ${_monthName(DateTime.now().month)}',
    };

    Navigator.pop(context, newNote);
  }

  void _openColorPicker() {
    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Colour',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              children: _buildColorDots(),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildColorDots() {
    final colors = [
      Colors.white,
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.cyan,
      Colors.pinkAccent,
      Colors.purple,
      Colors.grey,
    ];

    return colors
        .map(
          (color) => GestureDetector(
            onTap: () {
              setState(() {
                selectedColor = color;
              });
              Navigator.pop(context);
            },
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(
                    color: selectedColor == color ? Colors.black : Colors.grey),
              ),
            ),
          ),
        )
        .toList();
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
      backgroundColor: selectedColor,
      appBar: AppBar(
        title: const Text('Add Note'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.color_lens_outlined),
            onPressed: _openColorPicker,
          ),
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveNote,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Title',
                border: InputBorder.none,
              ),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: TextField(
                controller: _contentController,
                decoration: const InputDecoration(
                  hintText: 'Type something...',
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.multiline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
