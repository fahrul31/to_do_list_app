import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/data/api/api_service.dart';
import 'package:to_do_list/data/db/auth_repository.dart';
import 'package:to_do_list/provider/auth_provider.dart';
import 'package:to_do_list/provider/checklist_provider.dart';
import 'package:to_do_list/ui/home_page.dart';
import 'package:to_do_list/ui/login_page.dart';
import 'package:to_do_list/ui/register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AuthProvider authProvider;
  late ChecklistProvider checklistProvider;
  @override
  void initState() {
    super.initState();
    final authRepository = AuthRepository();
    final apiService = ApiService();
    authProvider = AuthProvider(apiService, authRepository);
    checklistProvider = ChecklistProvider(apiService, authRepository);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => authProvider),
        ChangeNotifierProvider(create: (context) => checklistProvider),
      ],
      child: MaterialApp(
        title: 'To-Do-List App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: LoginPage.routeName,
        routes: {
          LoginPage.routeName: (context) => const LoginPage(),
          RegisterPage.routeName: (context) => const RegisterPage(),
          HomePage.routeName: (context) => const HomePage(),
        },
      ),
    );
  }
}
