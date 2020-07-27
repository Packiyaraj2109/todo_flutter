import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:todo_flutter/src/assets/app_images.dart';
import 'package:todo_flutter/src/data/constants/screen_routes.dart';

class InitScreen extends StatefulWidget {
  InitScreen({Key key}) : super(key: key);

  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  final _storage = FlutterSecureStorage();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Future.delayed(
          Duration(seconds: 2),
          () {
            redirect();
          },
        );
      },
    );
    super.initState();
  }

  Future <void> redirect() async {
    String loginData = await _storage.read(key: "Loggeduser");

    if (loginData != null) {
      Navigator.of(context)
          .pushNamed(ScreenRoutes.HOMEPAGE, arguments: loginData);
    } else {
      Navigator.of(context).pop();
      Navigator.of(context).pushNamed(ScreenRoutes.SIGNIN);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange[700], Colors.orange[400]],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(child:Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(80),
              ),
              child:ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child:AppImages.appLogo(height: 100, width: 100),
                ),
            )),
      ),
    );
  }
}
