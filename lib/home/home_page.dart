import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_02/add/add_todo_page.dart';
import 'package:todo_list_02/database/app_database.dart';
import 'package:todo_list_02/database/todo_repository.dart';
import 'package:todo_list_02/details/todo_detail_page.dart';
import 'package:todo_list_02/home/home_state.dart';
import 'package:todo_list_02/home/home_view_model.dart';
import 'package:todo_list_02/settings/settings_page.dart';
import 'todo_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final HomeCubit cubit;
  late SharedPreferences preferences;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    _getPreferences();

    final db = AppDatabase();
    final repo = TodoRepositoryImpl(db);
    final vm = HomeViewModel(repo: repo);
    cubit = HomeCubit(vm: vm);
    //View попросил список
    cubit.fetchList();
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
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
      //   appBar: AppBar(
      //   title: Text("Мои задачи"),
      // ),
       body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.isEmpty) {
            return Column(
              children: [
                SizedBox(height: 150),
                Text("У вас ни одной задачи!"),
                Spacer(),
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
              SizedBox(height: 50)
              ],
            );
          }
            return Scaffold(
        body: SafeArea(
          child: Padding(padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(children: [
                const Text(
                'Мои задачи',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Spacer(),
              IconButton(onPressed: () => _navigateToSettingsPage(context), icon: Icon(Icons.settings))
              ],),
              
              const SizedBox(height: 10),
              Container(height: 1, color: Colors.black26),
              const SizedBox(height: 18),

              Expanded(
                child: ListView.separated(
                  itemCount: state.items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final todoItem = state.items[index];
                    // return TodoTile(
                    //   title: todoItem.title, 
                    //   dateText: todoItem.date, 
                    //   isDone: todoItem.isDone, 
                    //   onChanged: (v) {
                    //    // setState(() => todoItem.isFinished = v;
                    //   },
                    //   );
                    return ListTile(
                      title: Text(todoItem.title),
                      onTap: () => _navigateToDetailsPage(context, todoItem)
                      ,
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
        },
      )
      )
      );
  }

  void _navigateToAddTodoPage(BuildContext context) async {
     await Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AddTodoPage()));
    cubit.fetchList();
  }

  void _navigateToSettingsPage(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SettingsPage()));
    cubit.fetchList();
  }

  void _navigateToDetailsPage(BuildContext context, Todo item)  async {
     await Navigator.of(context).push(MaterialPageRoute(builder: (_) => TodoDetailPage(item: item)));
     cubit.fetchList();
  } 

  void _getPreferences() async {
    preferences = await SharedPreferences.getInstance();
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
