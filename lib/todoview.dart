import 'dart:convert';

import 'package:todo_flutter/src/data/constants/app_text_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TodoView extends StatefulWidget {
  final dynamic arguments;
  TodoView({this.arguments, Key key}) : super(key: key);

  @override
  _TodoViewState createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  @override
  bool _editable = false;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  String todoId;
  List decodeTodoList;
  int index;
  String title;
  final _storage = FlutterSecureStorage();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void initState() {
    todofetch();
    super.initState();
  }

  void todofetch() async {
    todoId = widget.arguments;
    print('statement $todoId');
    dynamic todoList = await _storage.read(key: 'todoList');
    decodeTodoList = json.decode(todoList);
    index = decodeTodoList.indexWhere((element) => element['id'] == todoId);
    _titleController.text = decodeTodoList[index]['title'];
    _descController.text = decodeTodoList[index]['desc'];
    setState(() {
      title = decodeTodoList[index]['title'];
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[200],
      appBar: _buildAppBar(),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  ("${AppTextConstant.TITLE} :"),
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Theme(
                  data: new ThemeData(
                    primaryColor: Colors.orange,
                    primaryColorDark: Colors.orange,
                    cursorColor: Colors.black,
                  ),
                  child: TextField(
                    controller: _titleController,
                    enabled: _editable,
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  "Description: ",
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Theme(
                  data: new ThemeData(
                    primaryColor: Colors.orange,
                    primaryColorDark: Colors.orange,
                    cursorColor: Colors.black,
                  ),
                  child: TextField(
                    controller: _descController,
                    enabled: _editable,
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.orange)),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400),
                    maxLines: 8,
                  ),
                ),
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.only(top: 48),
                  width: 300,
                  height: 100,
                  child: Visibility(
                    visible: _editable,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0)),
                      padding: EdgeInsets.all(0),
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          gradient: LinearGradient(
                            colors: [Colors.orange[500], Colors.orange[900]],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Submit",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      onPressed: editTodo,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.orange[900], Colors.orange],
          ),
        ),
      ),
      centerTitle: true,
      title: new Text('${title}'),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.white,
          ),
          onPressed: todoDelete,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 0, left: 0),
          child: IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.white,
            ),
            onPressed: () {
              setState(
                () {
                  _editable = !_editable;
                },
              );
            },
          ),
        ),
      ],
    );
  }

  todoDelete() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppTextConstant.DELETE),
          content: const Text('Are you sure to delete this todo?'),
          actions: <Widget>[
            FlatButton(
              child: const Text(AppTextConstant.DELETE),
              onPressed:delete,
            ),
            FlatButton(
              child: const Text(AppTextConstant.CANCEL),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  setStorage(decodeTodoList) async {
    await _storage.write(key: 'todoList', value: json.encode(decodeTodoList));
  }

  delete() async {
    decodeTodoList.removeAt(index);
    setStorage(decodeTodoList);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  editTodo() async {
    String title = _titleController.text;
    String desc = _descController.text;
    debugPrint('title $desc');
    debugPrint('title $title');
    decodeTodoList[index]['title'] = title;
    decodeTodoList[index]['desc'] = desc;
    setStorage(decodeTodoList);
    setState(
      () {
        _editable = !_editable;
      },
    );
  }
}
