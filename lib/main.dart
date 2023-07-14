import 'package:flutter/material.dart';
import 'todo_list_page.dart';


//エントリーポイント
void main() {
  // 最初に表示するWidget
  runApp(const MyTodoApp());
}

//Todoアプリのクラス
//Todoアプリの画面を生成する
class MyTodoApp extends StatelessWidget {
  //コンストラクタ
  const MyTodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // アプリ名
      title: 'My Todo App',
      theme: ThemeData(
        // テーマカラー
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // リスト一覧画面を表示
      home: const TodoListPage(),
    );
  }
}