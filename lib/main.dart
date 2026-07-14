import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drift Mystery',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<String> tasks = ['Task A', 'Task B', 'Task C', 'Task D', 'Task E'];

  // Track the currently selected task
  String? selectedTask;

  void removeSelectedTask() {
    if (selectedTask != null) {
      setState(() {
        tasks.remove(selectedTask);
        selectedTask = null; // reset after deletion
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task Mystery')),
      body: ListView(
        children: tasks
            .map(
              (task) => TaskTitle(
                key: ValueKey(task),
                title: task,
                isSelected: selectedTask == task,
                onSelected: () {
                  setState(() {
                    selectedTask = task;
                  });
                },
              ),
            )
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: removeSelectedTask,
        child: const Icon(Icons.delete),
      ),
    );
  }
}

class TaskTitle extends StatefulWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onSelected;

  const TaskTitle({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  State<TaskTitle> createState() => _TaskTitleState();
}

class _TaskTitleState extends State<TaskTitle> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.title),
      trailing: Checkbox(
        value: widget.isSelected,
        onChanged: (bool? value) {
          if (value == true) {
            widget.onSelected();
          }
        },
      ),
    );
  }
}
