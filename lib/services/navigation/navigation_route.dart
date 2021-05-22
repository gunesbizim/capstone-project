import 'package:capstone_project/core/constants/route_constants.dart';
import 'package:capstone_project/views/hompage/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case RouteConstants.HOME_PAGE:
        return normalNavigate(HomeView(),args);
      default: return MaterialPageRoute(
      builder: (context) => Scaffold(),//TODO: add error page
    );
    }
  }

  MaterialPageRoute normalNavigate(Widget widget, RouteSettings args) {
    return MaterialPageRoute(
      builder: (context) => widget,
      settings: args
    );
  }
}
