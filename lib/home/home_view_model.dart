
import 'package:todo_list_02/database/todo_repository.dart';
import 'package:todo_list_02/home/home_state.dart';
import 'package:todo_list_02/todo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//описываем viewModel
class HomeViewModel {
  final TodoRepository repo;

  HomeViewModel({required this.repo});

  Future<List<Todo>> fetchList() => repo.getList();
}

//Подвязываем viewModel с состоянием
class HomeCubit extends Cubit<HomeState> {
    final HomeViewModel vm;

  //при инициализации cubit фиксируем первоначальное состояние
    HomeCubit({required this.vm}) : super(HomeState.initial());

    Future<void> fetchList() async {
      try {
        final items = await vm.fetchList();
        if (items.isEmpty) {
          //поменять состояние
           emit(state.copyWith(items: [], isEmpty: true));
        } else {
          //поменять состояние
          emit(state.copyWith(items: items, isEmpty: false));
        }
      } catch (e) {
        //TODO: добавить состояние ошибки
      }
    }
}