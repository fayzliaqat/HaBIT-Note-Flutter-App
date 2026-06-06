import 'package:flutter/material.dart';
import '../screens/add_note_screen.dart';
import '../screens/add_todo_screen.dart';

class NotesTab extends StatefulWidget {
  const NotesTab({super.key});

  @override
  State<NotesTab> createState() => _NotesTabState();
}

class _NotesTabState extends State<NotesTab> {
  bool isGridView = false;
  List<Map<String, dynamic>> notes = [];
  Color? selectedFilterColor;

  @override
  Widget build(BuildContext context) {
    final visibleNotes = selectedFilterColor == null
        ? notes
        : notes.where((note) => note['color'] == selectedFilterColor).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              isGridView ? Icons.list : Icons.grid_view,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                isGridView = !isGridView;
              });
            },
          ),
        ],
      ),
      body: notes.isEmpty
          ? _buildEmptyView()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildColorFilter(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: visibleNotes.isEmpty
                        ? const Center(
                            child: Text(
                              'No notes match this color.',
                              style: TextStyle(color: Colors.black),
                            ),
                          )
                        : _buildListView(visibleNotes),
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: _showAddOptions,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildEmptyView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/empty_note.png',
            height: 180,
          ),
          const SizedBox(height: 20),
          const Text(
            'Create your first note!',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildColorFilter() {
    final colors = [
      null,
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.cyan,
      Colors.pinkAccent,
      Colors.purple,
      Colors.grey,
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
      child: Row(
        children: colors.map((color) {
          final isSelected = selectedFilterColor == color;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedFilterColor = color;
                });
              },
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: color ?? Colors.black,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? Colors.black : Colors.grey,
                  ),
                ),
                child: color == null
                    ? const Center(
                        child: Icon(Icons.clear, size: 16, color: Colors.white),
                      )
                    : null,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildListView(List<Map<String, dynamic>> visibleNotes) {
    return ListView.separated(
      itemCount: visibleNotes.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, index) {
        final note = visibleNotes[index];
        return GestureDetector(
          onTap: () async {
            final updatedNote = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => note['isTodo'] == true
                    ? AddTodoScreen(existingTodo: note)
                    : AddNoteScreen(existingNote: note),
              ),
            );
            if (updatedNote != null && mounted) {
              setState(() {
                notes[index] = updatedNote;
              });
            }
          },
          onLongPress: () => _confirmDelete(note),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: note['color'],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note['title'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  note['date'],
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAddOptions() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.notes),
                title: const Text('Add Note'),
                onTap: () async {
                  Navigator.pop(context);
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AddNoteScreen()),
                  );
                  if (result != null && mounted) {
                    setState(() {
                      notes.add(result);
                    });
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.check_box),
                title: const Text('Add To-do'),
                onTap: () async {
                  Navigator.pop(context);
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AddTodoScreen()),
                  );
                  if (result != null && mounted) {
                    setState(() {
                      notes.add(result);
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _confirmDelete(Map<String, dynamic> note) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete this note?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                notes.remove(note);
              });
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
