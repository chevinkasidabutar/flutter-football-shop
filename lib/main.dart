import 'package:bolabalestore/screens/login.dart';
import 'package:bolabalestore/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const BolabaleStoreApp());
}

class BolabaleStoreApp extends StatelessWidget {
  const BolabaleStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<CookieRequest>(
      create: (_) => CookieRequest(),
      child: MaterialApp(
        title: 'BolaBale Store',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const LoginPage(),
      ),
    );
  }
}
