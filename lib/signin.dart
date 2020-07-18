import 'dart:convert';

import 'package:todo_flutter/src/data/constants/app_text_constant.dart';
import 'package:todo_flutter/src/data/constants/screen_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Signin extends StatefulWidget {
  Signin({Key key}) : super(key: key);
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  @override
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _storage = FlutterSecureStorage();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // bool _validate = false;
  // bool _validatepass = false;

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[200],
      body: _buildBody(context),
    );
  }

  SingleChildScrollView _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildLogo(),
            _buildSignup(context),
          ],
        ),
      ),
    );
  }

  Expanded _buildSignup(BuildContext context) {
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
                inputFormatters: [
                  new WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),
                ],
                controller: _userNameController,
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
                  // errorText: _validate ? 'Value Can\'t Be Empty' : null,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 16, left: 24, right: 24, top: 16),
              child: TextField(
                inputFormatters: [
                  new WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),
                ],
                controller: _passwordController,
                cursorColor: Colors.grey,
                obscureText: true,
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
                  // errorText: _validate ? 'Value Can\'t Be Empty' : null,
                ),
              ),
            ),
            Container(
              margin: new EdgeInsets.symmetric(horizontal: 24.0),
              height: 50.0,
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: EdgeInsets.all(0),
                  onPressed: _loginButton,
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
                        AppTextConstant.LOGIN,
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
              padding: const EdgeInsets.only(
                  bottom: 8, left: 24, right: 24, top: 40),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Don't have an account?",
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 13,
                            fontWeight: FontWeight.bold)),
                    Center(
                      child: InkWell(
                        onTap: _signupButton,
                        child: Text(
                          ("    ${AppTextConstant.REGISTER}"),
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
            ),
          ],
        ),
      ),
    );
  }

  Expanded _buildLogo() {
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
                padding: EdgeInsets.only(top: 30, bottom:0),
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
                    (AppTextConstant.LOGIN),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ]),
      ),
    );
  }

  _loginButton() async {
    {
      String userName = _userNameController.text;
      String password = _passwordController.text;
      String loginData = await _storage.read(key: 'listUsers');
      print("logindata $loginData");

      if (userName == '') {
        _showScaffold("Enter User Name");
      } else if (password == '') {
        _showScaffold("Enter Password");
      } else if (loginData != null) {
        List decodeUserData = json.decode(loginData);
        int index = decodeUserData.indexWhere((element) =>
            element['user'] == userName && element['pass'] == password);

        if (index != -1) {
          _storage.write(key: 'Loggeduser', value: userName);
          Navigator.of(context).pushNamed(ScreenRoutes.HOMEPAGE,arguments: userName);
          _userNameController.clear();
          _passwordController.clear();
        } else {
          _showScaffold("User Name & Password is incorrect");
        }
      } else {
        _showScaffold("Users Not yet created");
      }
    }
  }

  _signupButton() {
    Navigator.of(context).pushNamed(ScreenRoutes.SIGNUP);
  }

  _showScaffold(String message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: new Duration(seconds: 1),
        action: SnackBarAction(
          label: 'Dissmiss',
          textColor: Colors.yellow,
          onPressed: () {
            _scaffoldKey.currentState.hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
