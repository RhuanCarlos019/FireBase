import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  final String id;
  final String task;
  final Function() onDelete;

  TodoItem({required this.id, required this.task, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: onDelete,
      ),
    );
  }
}
