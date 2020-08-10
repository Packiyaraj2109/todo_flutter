import 'package:flutter/material.dart';
import 'package:todo_flutter/src/ui/screen/homepage/home.dart';
import 'package:todo_flutter/src/ui/screen/init/init.dart';
import 'package:todo_flutter/src/ui/screen/signin/signin.dart';
import 'package:todo_flutter/src/ui/screen/signup/signup.dart';
import 'package:todo_flutter/src/data/constants/screen_routes.dart';
import 'package:todo_flutter/src/ui/screen/todoview/todoview.dart';
import 'package:todo_flutter/src/ui/theme/lighttheme.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme(),
      debugShowCheckedModeBanner: false,
      initialRoute: ScreenRoutes.INIT,
      onGenerateRoute: generateRoute,
    );
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ScreenRoutes.SIGNIN:
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return Signin();
          },
        );
        break;
      case ScreenRoutes.SIGNUP:
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return Signup();
          },
        );
        break;
      case ScreenRoutes.HOMEPAGE:
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return HomeScreen(arguments: settings.arguments);
          },
        );
        break;
      case ScreenRoutes.TODOVIEW:
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return TodoView(arguments: settings.arguments);
          },
        );
        break;
      case ScreenRoutes.INIT:
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return InitScreen();
          },
        );
        break;
      default:
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return Signin();
          },
        );
    }
  }
}
