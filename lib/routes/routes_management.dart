import 'package:firebase_chat_app/data/prefrences/prefrences.dart';
import 'package:firebase_chat_app/ui/auth/forgot_password/forgot_password.dart';
import 'package:firebase_chat_app/ui/auth/sign_in/sign_in.dart';
import 'package:firebase_chat_app/ui/auth/sign_up/sign_up.dart';
import 'package:firebase_chat_app/ui/auth/welcome_page/welcome_page.dart';
import 'package:firebase_chat_app/ui/chat/chat.dart';
import 'package:firebase_chat_app/ui/dashboard/dashboard.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRoutes {
  String get initialRoute => Preference().isLogin ? DashboardScreen.routeName : WelcomePageScreen.routeName;

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case WelcomePageScreen.routeName:
        return _fadeRoute(WelcomePageScreen.builder, settings);
      case SignInScreen.routeName:
        return _fadeRoute(SignInScreen.builder, settings);
      case SignUpScreen.routeName:
        return _fadeRoute(SignUpScreen.builder, settings);
      case ForgotPasswordScreen.routeName:
        return _fadeRoute(ForgotPasswordScreen.builder, settings);
      case DashboardScreen.routeName:
        return _fadeRoute(DashboardScreen.builder, settings);
      case ChatScreen.routeName:
        return _fadeRoute(ChatScreen.builder, settings);
      default:
        return _fadeRoute(
          (context) => Scaffold(body: Center(child: Text('No route defined for ${settings.name}'))),
          settings,
        );
    }
  }

  PageRouteBuilder _fadeRoute(WidgetBuilder builder, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => builder(context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
