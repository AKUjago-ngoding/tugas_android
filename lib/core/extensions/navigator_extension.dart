import 'package:flutter/material.dart';

extension NavigationExtensions on BuildContext {
  Future<T?> push<T>(Widget page, {String? name}) {
    return Navigator.push<T>(
      this,
      MaterialPageRoute(
        builder: (_) => page,
        settings: RouteSettings(name: name ?? page.runtimeType.toString()),
      ),
    );
  }

  Future<T?> pushReplacement<T, TO>(Widget page, {String? name}) {
    return Navigator.pushReplacement<T, TO>(
      this,
      MaterialPageRoute(
        builder: (_) => page,
        settings: RouteSettings(name: name ?? page.runtimeType.toString()),
      ),
    );
  }

  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed<T>(routeName, arguments: arguments);
  }

  Future<T?> pushReplacementNamed<T, TO>(String newRouteName, {Object? arguments}) {
    return Navigator.of(this).pushReplacementNamed<T, TO>(
      newRouteName,
      arguments: arguments,
    );
  }

  Future<T?> pushNamedAndRemoveUntil<T>(
    String newRouteName,
    RoutePredicate predicate, {
    Object? arguments,
  }) {
    return Navigator.of(this).pushNamedAndRemoveUntil<T>(
      newRouteName,
      predicate,
      arguments: arguments,
    );
  }

  Future<T?> pushAndRemoveAll<T>(Widget page, {String? name}) {
    return Navigator.pushAndRemoveUntil<T>(
      this,
      MaterialPageRoute(
        builder: (_) => page,
        settings: RouteSettings(name: name ?? page.runtimeType.toString()),
      ),
      (route) => false,
    );
  }

  void pop<T>([T? result]) {
    Navigator.of(this).pop<T>(result);
  }
}
