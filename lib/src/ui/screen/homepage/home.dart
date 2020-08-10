import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:todo_flutter/src/assets/app_colors.dart';
import 'package:todo_flutter/src/data/constants/app_text_constant.dart';
import 'package:todo_flutter/src/data/constants/screen_routes.dart';
import 'package:flutter/material.dart';
import 'package:todo_flutter/src/data/constants/storage_constants.dart';

class HomeScreen extends StatefulWidget {
  final dynamic arguments;

  HomeScreen({this.arguments, Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _taskTitleController = TextEditingController();
  TextEditingController _taskDescriptionController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List _todoList = [];
  List _allTodoList = [];
  List _otherUserTodoList = [];
  String username;
  bool isDelete;

  @override
  void initState() {
    getTodoList();
    username = widget.arguments;
    super.initState();
  }

  getTodoList() async {
    // dynamic todoList = await _storage.read(key: 'todoList');
    dynamic todoList = await StorageConst().storageread('todoList');
    if (todoList != null) {
      List decodeTodoList = json.decode(todoList);
      List currentUsertodo = decodeTodoList
          .where((element) => (element['User'] == username))
          .toList();
      List otherUsertodo = decodeTodoList
          .where((element) => (element['User'] != username))
          .toList();
      setState(
        () {
          _todoList = currentUsertodo;
          _allTodoList = decodeTodoList;
          _otherUserTodoList = otherUsertodo;
        },
      );
    } else {
      print("no data");
    }
  }

  Widget build(BuildContext context) {
    isDelete =
        _todoList.indexWhere((element) => element['checked'] == true) != -1;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColors.appBackgroundColor,
        appBar: _buildAppBar(),
        // drawer: _buildDrawer(),
        body: Container(
          color: AppColors.appBackgroundColor,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Column(
                children: List.generate(
                  _todoList.length,
                  (index) {
                    Map item = _todoList[index];
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () => refresh(item["id"]),
                        child: Container(
                            width: double.infinity,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: new BorderRadius.circular(20),
                              color: AppColors.borderColor,
                              border: Border.all(
                                width: 0.5,
                                color: Color(0xFFa1a1a1),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xFFa1a1a1),
                                    blurRadius: 0.5,
                                    offset: Offset(0, 1)),
                              ],
                            ),
                            margin: EdgeInsets.only(left: 8, right: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    "   ${item['title']}",
                                    softWrap: false,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
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
                                  activeColor: Colors.deepOrangeAccent,
                                  checkColor: AppColors.iconColor,
                                ),
                              ],
                            )),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: _modalBottomSheet,
          child: Icon(Icons.add),
          backgroundColor: AppColors.bottomsheet,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: (IconButton(
        icon: Icon(
          Icons.exit_to_app,
          color: AppColors.iconColor,
        ),
        enableFeedback: isDelete,
        onPressed: logout,
      )),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: AppColors.buttongradient,
        ),
      ),
      centerTitle: true,
      title: new Text(AppTextConstant.AppBartitle),
      actions: <Widget>[
        if (isDelete)
          (IconButton(
            icon: Icon(
              Icons.delete,
              color: AppColors.iconColor,
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
                        primaryColor: AppColors.themeColor,
                        primaryColorDark: AppColors.themeColor,
                        cursorColor: Colors.black,
                      ),
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _taskTitleController,
                          validator: (value) =>
                              value.isEmpty ? 'Title cannot be blank' : null,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: new BorderSide(
                                    color: AppColors.themeColor)),
                            hintText: AppTextConstant.TITLE,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Theme(
                      data: new ThemeData(
                        primaryColor: AppColors.themeColor,
                        primaryColorDark: AppColors.themeColor,
                        cursorColor: Colors.black,
                      ),
                      child: TextFormField(
                        controller: _taskDescriptionController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: new BorderSide(
                                    color: AppColors.themeColor)),
                            hintText: AppTextConstant.DESCRIPTION),
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
                          gradient: AppColors.buttongradient,
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            AppTextConstant.CreateTodo,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline3,
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

  Future<void> todoDelete() async {
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

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  Future<void> checkedListDelete() async {
    List checkedlist =
        _todoList.where((element) => (element['checked'] != true)).toList();
    List newList = _otherUserTodoList + checkedlist;
    // await _storage.write(key: 'todoList', value: json.encode(newList));
    StorageConst().storagewrite('todoList', newList);
    Navigator.of(context).pop(getTodoList());
  }

  Future<void> logout() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppTextConstant.LOGOUT),
          content: Text('Are you sure to Exit from this User: "${username}"?'),
          actions: <Widget>[
            FlatButton(
              child: const Text(AppTextConstant.LOGOUT),
              onPressed: logoutconfirm,
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

  logoutconfirm() {
    StorageConst().storagedelete('Loggeduser');
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.of(context).pushNamed(ScreenRoutes.SIGNIN);
  }

  todoAdd() {
    String title = _taskTitleController.text;
    String desc = _taskDescriptionController.text;
    final FormState form = _formKey.currentState;

    Map todo = {
      'User': username,
      'title': title,
      'desc': desc,
      'id': randomNumber()
    };
    if (form.validate()) {
      _allTodoList.add(todo);
      StorageConst().storagewrite('todoList', _allTodoList);
      _taskTitleController.clear();
      _taskDescriptionController.clear();
      getTodoList();
      Navigator.pop(context);
    } else {}
  }

  Future<void> refresh(String id) async {
    await Navigator.of(context).pushNamed(ScreenRoutes.TODOVIEW, arguments: id);
    getTodoList();
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
