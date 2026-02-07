import 'package:flutter/material.dart';
import 'package:todo_list_02/add/add_todo_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateToAddTodoPage(context),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void navigateToAddTodoPage(BuildContext context) async {
    final result = await Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AddTodoPage()));
    // if (result != null) {
      print("Текст со второго экрана: $result");
    // }
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
