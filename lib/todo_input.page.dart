import 'package:flutter/material.dart';
import 'todo_list_store.dart';
import 'todo.dart';

//Todo入力画面
class TodoInputPage extends StatefulWidget {
  final Todo? todo;
//コンストラクタ
//Todoを引数で受け取った場合は更新、受け取らない場合は追加画面
  const TodoInputPage({Key? key,this.todo}) : super(key: key);

//Todo入力画面の状態を生成する
  @override
  State<TodoInputPage> createState() => _TodoInputPageState();
}
  //Todo入力画面の状態クラス
class _TodoInputPageState extends State<TodoInputPage> {
    //ストア
  final TodoListStore _store = TodoListStore();

  //新規追加かどうか  
  late bool _isCreateTodo;
  //画面項目
  late String _title;

  //初期処理
  @override
  void initState() {
    super.initState();
    var todo = widget.todo;
    _title = todo?.todotitle ?? "";
    _isCreateTodo = todo == null;
  }


  //画面を作成
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isCreateTodo ? 'Todo追加' : 'Todo更新'),
      ),
      body: Container(
        //余白をつける
        padding: const EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              autofocus: true,
              decoration: const InputDecoration(
                labelText: "タイトル",
              ),
              //TextEditingControllerを使うことでいちいちsetStateしなくても画面を更新してくれる
              controller: TextEditingController(text: _title),
              onChanged: (String value) {
                  _title = value;
              },
            ),
            const SizedBox(height: 8),
            //追加・編集ボタン
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){
                  if (_isCreateTodo) {
                    //Todoを追加する
                    _store.add(_title);
                  } else {
                    //Todoを更新する
                    _store.update(widget.todo!, _title);
                  }
                  //Todoリスト画面に戻る
                  Navigator.of(context).pop();
                },
                child: Text(
                  _isCreateTodo ? '追加' : '更新',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  //Todoリストの画面に戻る
                  Navigator.of(context).pop();               
                },
                child: const Text('キャンセル'),
              )
            ),
          ],
        ),
      ),
    );
  }
}


