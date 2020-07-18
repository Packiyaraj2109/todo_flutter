import 'dart:convert';

import 'package:todo_flutter/src/data/constants/app_text_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Signup extends StatefulWidget {
  Signup({Key key}) : super(key: key);
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  TextEditingController _emailController = TextEditingController();
  TextEditingController _userController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _passConfirmController = TextEditingController();
  final _storage = FlutterSecureStorage();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[200],
      body: _buildBody(),
    );
  }

  SingleChildScrollView _buildBody() {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _builldLogoSection(),
            _buildInputSection(),
          ],
        ),
      ),
    );
  }

  Expanded _builldLogoSection() {
    return Expanded(
      flex: 2,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius:
              new BorderRadius.only(bottomLeft: new Radius.circular(120)),
          gradient: LinearGradient(
            colors: [Colors.orange[900], Colors.orange[500]],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Image.asset(
                "assets/image3.png",
                height: 150.0,
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Text(
                  AppTextConstant.REGISTER,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded _buildInputSection() {
    return Expanded(
      flex: 3,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 8, left: 24, right: 24, top: 8),
              child: TextField(
                controller: _emailController,
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: AppTextConstant.EMAIL,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(36),
                    borderSide: BorderSide(color: Colors.white, width: 0.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(36),
                      borderSide: BorderSide(color: Colors.white)),
                  filled: true,
                  contentPadding:
                      EdgeInsets.only(bottom: 10.0, left: 20.0, right: 10.0),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 8, left: 24, right: 24, top: 8),
              child: TextField(
                inputFormatters: [
                  new WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),
                ],
                controller: _userController,
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  hintText: AppTextConstant.USERNAME,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(36),
                    borderSide: BorderSide(color: Colors.white, width: 0.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(36),
                      borderSide: BorderSide(color: Colors.white)),
                  filled: true,
                  contentPadding:
                      EdgeInsets.only(bottom: 10.0, left: 20.0, right: 10.0),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 8, left: 24, right: 24, top: 8),
              child: TextField(
                inputFormatters: [
                  new WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),
                ],
                obscureText: true,
                controller: _passController,
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.vpn_key),
                  hintText: AppTextConstant.PASSWORD,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(36),
                    borderSide: BorderSide(color: Colors.white, width: 0.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(36),
                      borderSide: BorderSide(color: Colors.white)),
                  filled: true,
                  contentPadding:
                      EdgeInsets.only(bottom: 10.0, left: 20.0, right: 10.0),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 8, left: 24, right: 24, top: 8),
              child: TextField(
                inputFormatters: [
                  new WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),
                ],
                obscureText: true,
                controller: _passConfirmController,
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.security),
                  hintText: ("Confirm ${AppTextConstant.PASSWORD}"),
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(36),
                    borderSide: BorderSide(color: Colors.white, width: 0.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(36),
                      borderSide: BorderSide(color: Colors.white)),
                  filled: true,
                  contentPadding:
                      EdgeInsets.only(bottom: 10.0, left: 20.0, right: 10.0),
                ),
              ),
            ),
            Container(
              margin: new EdgeInsets.symmetric(horizontal: 24.0),
              height: 50.0,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: EdgeInsets.all(0),
                  onPressed: _signupButtonPressed,
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
                        AppTextConstant.REGISTER,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Alraedy have an account?",
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 13,
                            fontWeight: FontWeight.bold)),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed('signin');
                        },
                        child: Text(
                          ("    ${AppTextConstant.LOGIN}"),
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 13,
                            fontFamily: "Ubuntu",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _signupButtonPressed() async {
    String email = _emailController.text;
    String user = _userController.text;
    String pass = _passController.text;
    String passconfirm = _passConfirmController.text;
    List userList = List();
    print("op1: $user $pass $email  $passconfirm $userList");
    if (email == '') {
      _showScaffold("Enter Email Address");
    } else if (user == '') {
      _showScaffold("Enter user Name");
    } else if (pass == '' || passconfirm == '') {
      _showScaffold("Enter Password");
    } else if (pass != passconfirm) {
      _showScaffold("Password Not Matching");
    } else {
      String loginData = await _storage.read(key: 'listUsers');
      Map currentUserData = {'email': email, 'user': user, 'pass': pass};
      print("oploginData:  $loginData");
      if (loginData != null) {
        userList = json.decode(loginData);
        print("op3: $user $pass $email  $passconfirm $userList");
        int index = userList.indexWhere((element) => element['user'] == user);
        if (index != -1) {
          _showScaffold("user :  $user is already Taken");
        } else {
          userList.add(currentUserData);
          print("op3: $user $pass $email  $passconfirm $userList");
          await _storage.write(key: 'listUsers', value: json.encode(userList));
          Navigator.of(context).pushNamed('login');
        }
      } else {
        userList.add(currentUserData);

        print("userList:  $userList");
        await _storage.write(key: 'listUsers', value: json.encode(userList));
        Navigator.of(context).pushNamed('login');
      }
    }
  }

  _showScaffold(String message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: new Duration(seconds: 1),
        action: SnackBarAction(
          label: 'Dissmiss',
          textColor: Colors.white,
          onPressed: () {
            _scaffoldKey.currentState.hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
