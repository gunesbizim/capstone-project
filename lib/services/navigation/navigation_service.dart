import 'package:capstone_project/services/navigation/navigation_route.dart';
import 'package:flutter/cupertino.dart';

import 'INavigationService.dart';

class NavigationService extends  INavigationService{
  static final NavigationService _instance = NavigationService._init();
  static NavigationService get instance => _instance;

  NavigationService._init();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  final removeAllOldRoutes = (Route<dynamic> route) => false;

  @override
  Future<void> navigateToPage({String? path, Object? data}) async {
    final routeSetting = new RouteSettings(name: path, arguments: data);
    final materialPageRoute = NavigationRoute.instance.generateRoute(routeSetting);
    await navigatorKey.currentState!.push(materialPageRoute);
  }

  @override
  Future<void> navigateToPageClear({String? path, Object? data}) async {
    final routeSetting = new RouteSettings(name: path, arguments: data);
    final materialPageRoute = NavigationRoute.instance.generateRoute(routeSetting);
    await navigatorKey.currentState!.pushAndRemoveUntil(materialPageRoute, (route) => false);
  }
}
