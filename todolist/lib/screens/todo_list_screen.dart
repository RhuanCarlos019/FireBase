import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/add_todo.dart';
import '../widgets/todo_item.dart';
import '../services/firestore_service.dart';

class TodoListScreen extends StatelessWidget {
  final TextEditingController _taskController = TextEditingController();

  Future<void> _addTask(String task) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && task.isNotEmpty) {
      await FirestoreService().addTodo(task, user.uid);
      _taskController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          AddTodo(
            controller: _taskController,
            onAddTask: _addTask,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirestoreService().getTodos(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                final tasks = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return TodoItem(
                      id: task.id,
                      task: task['task'],
                      onDelete: () => FirestoreService().deleteTodo(task.id),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
