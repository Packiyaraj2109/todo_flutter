import 'package:todo_flutter/home.dart';
import 'package:todo_flutter/signin.dart';
import 'package:todo_flutter/signup.dart';
import 'package:todo_flutter/src/data/constants/screen_routes.dart';
import 'package:todo_flutter/todoview.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var ScreenRoutes;
    return MaterialApp(
      initialRoute: ScreenRoutes.SIGNIN,
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
            return HomeScreen(arguments:settings.arguments);
          },
        );
         case ScreenRoutes.TODOVIEW:
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return TodoView(arguments:settings.arguments);
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
