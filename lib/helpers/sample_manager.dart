import 'package:solu_bloc/api/api.dart';
import 'package:solu_bloc/data/models/todo.dart';
import 'package:solu_bloc/tools/manager.dart';

class SampleManager extends Manager {
  static SampleManager instance;
  factory SampleManager() => instance ??= SampleManager._instance();
  SampleManager._instance();
  List<Todo> todos = [];
  bool _loadingTodos = false;
  bool get loadingTodos => _loadingTodos;

  set loadingTodos(bool show) {
    _loadingTodos = show;
    notifyChanges();
  }

  Future loadTodos() {
    loadingTodos = true;
    return api.getTodos().then((response) async {
      var payload = response.data;
      await _saveTodosLocally(payload);
      loadingTodos = false;
      return response;
    }).catchError((error) {
      loadingTodos = false;
      throw error;
    });
  }

  Future _saveTodosLocally(payload) async {
    todos = [];
    for (var item in payload) {
      todos.add(Todo.fromMap(item));
    }
    print("Todos saved");
  }

  @override
  Future init() async {
    super.init();
  }
}

var sampleManager = SampleManager();
