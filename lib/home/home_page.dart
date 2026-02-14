import 'package:flutter/material.dart';
import 'package:todo_list_02/add/add_todo_page.dart';
import 'package:todo_list_02/todo.dart';
import 'todo_tile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<Todo> _todoList = [
  Todo(id: 1, title: "Сделать домашнее задание", date: "20.01.2026", isDone: false), 
  Todo(id: 2, title: "Купить телефон", date: "27.01.2026", isDone: true),
  Todo(id: 3, title: "Съездить в Турцию", date: "08.02.2026", isDone: false),
  Todo(id: 4, title: "Прочитать книгу", date: "12.02.2026", isDone: false)
  ];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Срабатывает 1 раз и здесь инициализируем задачи:
    //К примеру: запрашивать данные с сервера, локально с б.д
    //Запуска таймеоа или анимации
    print("MyHomePage - initState");
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    //Когда меняется тема, язык приложения 
    print("MyHomePage - didChangeDependencies");
  }

  @override
  Widget build(BuildContext context) {
    //рисует нам ui и срабатывает постоянно при изменении состояния State
    print("MyHomePage - build");
   
       return Scaffold(
        body: SafeArea(
          child: Padding(padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Text(
                'Мои задачи',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              Container(height: 1, color: Colors.black26),
              const SizedBox(height: 18),

              Expanded(
                child: ListView.separated(
                  itemCount: _todoList.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final todoItem = _todoList[index];
                    return TodoTile(
                      title: todoItem.title, 
                      dateText: todoItem.date, 
                      isDone: todoItem.isDone, 
                      onChanged: (v) {
                       // setState(() => todoItem.isFinished = v;
                      }
                      );
                  },
                )
                ),
                const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton.icon(
                  onPressed: () {
                    _navigateToAddTodoPage(context);
                  },
                  icon: const Icon(Icons.add, size: 26),
                  label: const Text(
                    'Добавить задачу',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0A72FF),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
          )
          ),
       );
  }

  void _navigateToAddTodoPage(BuildContext context) async {
    final result = await Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AddTodoPage()));
     if (result != null) {
      print("Текст со второго экрана: $result");
     }
  }

  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print("MyHomePage - didUpdateWidget");
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    //НЕ используется
    print("MyHomePage - deactivate");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //Здесь выключаем все таймеры, подписки (Stream)
    print("MyHomePage - dispose");
  }
}
