import 'package:flutter/material.dart';

void main() {
  runApp(ToDoApp());
}

class ToDoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: ToDoHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ToDoHome extends StatefulWidget {
  @override
  _ToDoHomeState createState() => _ToDoHomeState();
}

class _ToDoHomeState extends State<ToDoHome> {
  List<String> tasks = [];

  void _addTask() {
    String newTask = '';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Task'),
        content: TextField(
          autofocus: true,
          onChanged: (value) => newTask = value,
          decoration: InputDecoration(hintText: "Enter task"),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              if (newTask.trim().isNotEmpty) {
                setState(() {
                  tasks.add(newTask.trim());
                });
                Navigator.pop(context);
              }
            },
            child: Text("Add"),
          )
        ],
      ),
    );
  }

  void _editTask(int index) {
    String editedTask = tasks[index];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Task'),
        content: TextField(
          controller: TextEditingController(text: editedTask),
          onChanged: (value) => editedTask = value,
          autofocus: true,
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              if (editedTask.trim().isNotEmpty) {
                setState(() {
                  tasks[index] = editedTask.trim();
                });
                Navigator.pop(context);
              }
            },
            child: Text("Save"),
          )
        ],
      ),
    );
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("To-Do List")),
      body: tasks.isEmpty
          ? Center(child: Text("No tasks added yet."))
          : ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) => Card(
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            title: Text(tasks[index]),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _editTask(index)),
                IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteTask(index)),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: Icon(Icons.add),
        tooltip: "Add Task",
      ),
    );
  }
}