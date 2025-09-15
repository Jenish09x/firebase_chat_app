import 'package:firebase_chat_app/resources/resources.dart';
import 'package:firebase_chat_app/routes/routes_management.dart';
import 'package:flutter/material.dart';

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AppRoutes appRoutes = AppRoutes();
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: MaterialApp(
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
            child: Builder(
              builder: (context) {
                return child!;
              },
            ),
          );
        },
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        theme: lightTheme,
        initialRoute: appRoutes.initialRoute,
        onGenerateRoute: appRoutes.generateRoute,
        navigatorKey: navigatorKey,
      ),
    );
  }
}
