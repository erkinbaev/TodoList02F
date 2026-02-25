
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_02/database/app_database.dart';
import 'package:todo_list_02/main.dart';

class TodoDetailPage extends StatefulWidget{
  final Todo item;
  const TodoDetailPage({super.key, required this.item});

  @override
  State<TodoDetailPage> createState() => _TodoDetailPage();
}

class _TodoDetailPage extends State<TodoDetailPage> {
  late final TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController(text: widget.item.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Детали"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Flex(direction: .vertical,
        children: [
          TextField(  
            controller: _controller,
            decoration: InputDecoration(
              labelText: "Название",
              border: OutlineInputBorder(),
            ),
          ),
          TextButton(onPressed: () => _updateTodo(), child: Text("Сохранить")),
          TextButton(onPressed: () => _deleteTodo(), child: Text("Удалить"))
        ],
        ),  
      ),
    );
  }

  Future<void> _updateTodo() async {
    late final bool isDone;

    isDone = true;

    late final String newTitle;
    newTitle = _controller.text;

    await database.updateTodo(widget.item.id, TodosCompanion(isDone: Value(isDone)));
    Navigator.pop(context, true);
  }

  Future<void> _deleteTodo() async {
    await database.deleteTodo(widget.item.id);
    Navigator.pop(context, true);
  }
}