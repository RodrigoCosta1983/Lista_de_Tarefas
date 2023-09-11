import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/todo.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({super.key, required this.todo});

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[200],
      ),
      margin:  const EdgeInsets.symmetric(vertical: 3),
      padding: const EdgeInsets.all(16),

      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
             DateFormat('dd/MMM/yyyy HH:mm').format(todo.dateTime), // ou como formatado na linha abaixo
            //todo.dateTime.toString().substring(0,16), // formatando o dateTime
            style:const TextStyle(
              fontSize: 12,
            ),
          ),
          Text(
            todo.title,
            style:const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
