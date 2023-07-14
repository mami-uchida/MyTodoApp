import 'package:flutter/material.dart';
import 'todo_input.page.dart';
import 'todo_list_store.dart';
import 'todo.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// リスト一覧画面用Widget
class TodoListPage extends StatefulWidget {
  //コンストラクタ
  const TodoListPage({Key? key}) : super(key: key);
  //Todoリスト画面の状態を生成
  @override
  State<TodoListPage> createState() => _TodoListPageState();
}


class _TodoListPageState extends State<TodoListPage> {
  //ストア
  final TodoListStore _store = TodoListStore();
  //Todoリスト入力画面に遷移する
  void _pushTodoInputPage([Todo? todo]) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context){
          return TodoInputPage(todo: todo);
        },
      ),
    );
    setState(() {});
  }


  //初期処理
  @override
  void initState(){
    super.initState();
  }

  // Todoリストのデータ
  List<String> todoList = [];

//画面を生成
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBarを表示し、タイトルも設定
      appBar: AppBar(
        title: const Text('リスト一覧'),
      ),
      // データを元にListViewを作成
      body: ListView.builder(
        //Todoの件数をリストの件数とする
        itemCount: _store.count(),
        itemBuilder: (context, index) {
          //インデックスに対応するTodoを取得する
          var item = _store.findByIndex(index);
          return Slidable(
            endActionPane: ActionPane(
              motion: const StretchMotion(),
              extentRatio: 0.50,
              children: [
                SlidableAction(
                  onPressed: (context) async {
                  //編集画面に遷移
                  _pushTodoInputPage(item);           
                  },
                backgroundColor: Colors.yellow,
                  icon: Icons.edit,
                  label: '編集',
                ),
                SlidableAction(
                  onPressed: (_) async {
                    
                    await showDialog(
                      context: context,
                      builder: (_){
                        return AlertDialog(
                          title: const Column(
                            children: [
                              Icon(Icons.warning, size: 50, color: Colors.orange),
                              Text('本当に削除しますか？'),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                // ignore: list_remove_unrelated_type
                                Navigator.of(context).pop();
                                setState(() {_store.delete(item);});
                                const snackBar = SnackBar(
                                  content: Text('削除しました'),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                
                              },
                            ),
                            TextButton(
                              child: const Text('キャンセル'),
                              onPressed: ()  => Navigator.of(context).pop(),
                            ),
                          ],
                        );
                      },
                    ); 
                  },
                  backgroundColor: Colors.red,
                  icon: Icons.delete,
                  label: '削除',
                ),
              ],
            ),
            child: Card(
              child: ListTile(
                title: Text(item.todotitle),
                
              ),
            ),
          );
        },
      ),
      //Todo追加画面に遷移するボタン
      floatingActionButton: FloatingActionButton(
        onPressed: _pushTodoInputPage,
        child: const Icon(Icons.add),
      ),
    );
  }
}