
import 'package:todo_list_02/database/app_database.dart';

abstract class TodoRepository {
  //набор функционала для работы с хранилищем
  Future<List<Todo>> getList();

}

class TodoRepositoryImpl implements TodoRepository {
  //хранилище
  final AppDatabase db;

  TodoRepositoryImpl(this.db);

//репозитори просит данные с хранилища
  @override
  Future<List<Todo>> getList() => db.getTodoList();
}