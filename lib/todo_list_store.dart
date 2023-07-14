
import 'todo.dart';

class TodoListStore {

  //Todoリスト
  final List<Todo> _list = [];

  //ストアのインスタンス
  static final TodoListStore _instance = TodoListStore.internal();
  //プライベートコンストラクタ
  TodoListStore.internal();

  //ファクトリーコンストラクタ
  factory TodoListStore(){
    return _instance;
  }
  //Todoの件数を取得
  int count(){
    return _list.length;
  }
  //指定したインデックスのTodoを取得
  Todo findByIndex(int index) {
    return _list[index];
  }
  //Todoを追加する
  void add(String todotitle) {
    var todo = Todo(todotitle);
    _list.insert(0, todo); // リストの先頭に追加
  }

  //Todoを更新する
  void update(Todo todo, String? todotitle) {
    if (todotitle != null){
      _list.remove(todo);
      todo.todotitle = todotitle;
    }
    _list.insert(0, todo); // リストの先頭に追加
  }

  void delete(Todo todo) {
    _list.remove(todo);
  }
}