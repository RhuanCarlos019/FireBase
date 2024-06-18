import 'package:flutter/material.dart';

class AddTodo extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onAddTask;

  AddTodo({required this.controller, required this.onAddTask});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'New Task',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => onAddTask(controller.text),
          ),
        ],
      ),
    );
  }
}
