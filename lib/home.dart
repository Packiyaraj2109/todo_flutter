import 'dart:convert';
import 'dart:math';

import 'package:todo_flutter/src/data/constants/app_text_constant.dart';
import 'package:todo_flutter/src/data/constants/screen_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeScreen extends StatefulWidget {
  final dynamic arguments;

  HomeScreen({this.arguments, Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _taskTitleController = TextEditingController();
  TextEditingController _taskDescriptionController = TextEditingController();
  final _storage = FlutterSecureStorage();
  bool isCheck = false;
  List _todoList = [];
  List _allTodoList = [];
  List _otherUserTodoList = [];
  String username;
  bool isDelete;

  @override
  void initState() {
    getTodoList();
    username = widget.arguments;
    print("oploginData:  $username");
    super.initState();
  }

  getTodoList() async {
    dynamic todoList = await _storage.read(key: 'todoList');
    if (todoList != null) {
      List decodeTodoList = json.decode(todoList);
      List currentUsertodo = decodeTodoList
          .where((element) => (element['User'] == username))
          .toList();
      List otherUsertodo = decodeTodoList
          .where((element) => (element['User'] != username))
          .toList();
      setState(() {
        _todoList = currentUsertodo;
        _allTodoList = decodeTodoList;
        _otherUserTodoList = otherUsertodo;
      });
      print("_todoList $_todoList");
      print("_allTodoList $_allTodoList");
      print("decodeTodoList $decodeTodoList");
      print("_otherUserTodoList $otherUsertodo");
    } else {
      print("no data");
    }
  }

  Widget build(BuildContext context) {
    isDelete =
        _todoList.indexWhere((element) => element['checked'] == true) != -1;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: _buildAppBar(),
      // drawer: _buildDrawer(),
      body: Container(
        color: Colors.grey[200],
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(_todoList.length, (index) {
              Map item = _todoList[index];
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(ScreenRoutes.TODOVIEW,arguments: item["id"]);
                  },
                  child: Container(
                      width: double.infinity,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: new BorderRadius.circular(10),
                        color: Colors.grey[200],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[900],
                            blurRadius: 3.0,
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(left: 8, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "   ${item['title']}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Checkbox(
                            value: item['checked'] ?? false,
                            onChanged: (bool newvalue) {
                              _todoList[index]['checked'] = newvalue;
                              setState(() {
                                _todoList = _todoList;
                              });
                            },
                            activeColor: Colors.green,
                            checkColor: Colors.white,
                          ),
                        ],
                      )),
                ),
              );
            }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _modalBottomSheet,
        child: Icon(Icons.add),
        backgroundColor: Colors.orange[900],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // Drawer _buildDrawer() {
  //   return Drawer(
  //     child: ListView(
  //       padding: EdgeInsets.zero,
  //       children: <Widget>[
  //         DrawerHeader(
  //           child: Text(
  //             AppTextConstant.USERNAME,
  //             style: TextStyle(color: Colors.white, fontSize: 30),
  //           ),
  //           decoration: BoxDecoration(
  //             gradient: LinearGradient(
  //               begin: Alignment.bottomRight,
  //               end: Alignment.topLeft,
  //               colors: [Colors.orange[900], Colors.orange],
  //             ),
  //           ),
  //         ),
  //         ListTile(
  //           title: Text('User Info'),
  //         ),
  //         Divider(
  //           color: Colors.grey[500],
  //         ),
  //         ListTile(
  //           title: Text('Logout'),
  //         ),
  //         Divider(
  //           color: Colors.grey[500],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  AppBar _buildAppBar() {
    return AppBar(
      leading: (IconButton(
        icon: Icon(
          Icons.exit_to_app,
          color: Colors.white,
        ),
        enableFeedback: isDelete,
        onPressed: logout,
      )),
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
      title: new Text('My Tasks'),
      actions: <Widget>[
        if (isDelete)
          (IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: todoDelete,
          ))
      ],
    );
  }

  void _modalBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: SingleChildScrollView(
              child: Wrap(
                alignment: WrapAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Theme(
                      data: new ThemeData(
                        primaryColor: Colors.orange,
                        primaryColorDark: Colors.orange,
                        cursorColor: Colors.black,
                      ),
                      child: TextField(
                        controller: _taskTitleController,
                        decoration: InputDecoration(
                            errorText: false ? 'Value Can\'t Be Empty' : null,
                            border: OutlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.orange)),
                            hintText: AppTextConstant.TITLE,
                            labelStyle: TextStyle(fontSize: 20)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Theme(
                      data: new ThemeData(
                        primaryColor: Colors.orange,
                        primaryColorDark: Colors.orange,
                        cursorColor: Colors.black,
                      ),
                      child: TextField(
                        controller: _taskDescriptionController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.orange)),
                            hintText: "Description",
                            labelStyle: TextStyle(fontSize: 25)),
                        maxLines: 9,
                      ),
                    ),
                  ),
                  Container(
                    margin: new EdgeInsets.symmetric(horizontal: 24.0),
                    height: 50.0,
                    padding: const EdgeInsets.only(bottom: 16),
                    width: 250,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0)),
                      padding: EdgeInsets.all(0),
                      onPressed: todoAdd,
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
                            "Create Todo",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'MeriendaOne-Regular',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
              onPressed: checkedListDelete,
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

  checkedListDelete() async {
    List checkedlist =
        _todoList.where((element) => (element['checked'] != true)).toList();
    List newList = _otherUserTodoList + checkedlist;
    await _storage.write(key: 'todoList', value: json.encode(newList));
    Navigator.of(context).pop(getTodoList());
  }

  logout() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text('Are you sure to Exit from this User: ${username}?'),
          actions: <Widget>[
            FlatButton(
              child: const Text("Logout"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
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

  todoAdd() async {
    String title = _taskTitleController.text;
    String desc = _taskDescriptionController.text;

    Map todo = {
      'User': username,
      'title': title,
      'desc': desc,
      'id': randomNumber()
    };

    _allTodoList.add(todo);
    await _storage.write(key: 'todoList', value: json.encode(_allTodoList));
    print("all:  $_allTodoList");
    _taskTitleController.clear();
    _taskDescriptionController.clear();
    getTodoList();
    Navigator.pop(context);
  }

  randomNumber() {
    var rnd = new Random();
    var next = rnd.nextDouble() * 1000000;
    while (next < 100000) {
      next *= 10;
    }
    return next.toInt().toString();
  }

  
}
