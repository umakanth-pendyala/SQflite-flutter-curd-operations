import 'package:database_handling_sqflite/database_helper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('database management'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () async {
              int i = await DatabaseHelper.instance.insert({
                DatabaseHelper.columnName: 'Umakanth',
                //id is primary key so auto generated
              });
              print('the value inserted id is :$i');
            },
            child: Text('insert'),
            color: Colors.blue,
          ),
          FlatButton(
            onPressed: () async {
              List<Map<String, dynamic>> rows =
                  await DatabaseHelper.instance.queryAll();
              print(rows);
            },
            child: Text('query'),
            color: Colors.red,
          ),
          FlatButton(
            onPressed: () async {
              int i = await DatabaseHelper.instance.update({
                DatabaseHelper.columnId: 2,
                DatabaseHelper.columnName: 'sriram pendyala'
              });
              print('$i is the updated value');
            },
            child: Text('update'),
            color: Colors.orange,
          ),
          FlatButton(
            onPressed: () async {
              int i = await DatabaseHelper.instance.delete(3);
            },
            child: Text('delete'),
            color: Colors.lightBlueAccent,
          )
        ],
      ),
    );
  }
}
