import 'package:flutter/material.dart';
import 'package:list_maker/create_account.dart';
import 'package:list_maker/services/auth_service.dart';
import 'package:provider/provider.dart';

import 'package:list_maker/services/api_service.dart';

import 'package:list_maker/show_lists.dart';
import 'package:list_maker/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //TODO Use configuration to replace hard-coded URL
  final apiService = ApiService.instance;

  // Configure Dio
  apiService.configureDio(baseUrl: 'http://localhost:5000');

  await AuthService.init();

  runApp(MultiProvider(
    providers: [
      Provider<ApiService>(
        create: (_) => ApiService.instance,
      ),
      Provider<AuthService>(create: (_) => AuthService())
    ],
    child: const ListMaker(),
  ));
}

class ListMaker extends StatelessWidget {
  const ListMaker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "List Maker",
        theme: ThemeData(
            canvasColor: Colors.transparent,
            primarySwatch: Colors.blue,
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.blue, foregroundColor: Colors.black)),
        /* home: const CounterStateful(
        buttonColor: Colors.amber,
      ), */
        debugShowCheckedModeBanner: false,
        routes: {
          '/lists': (context) => const ShowLists(),
          '/login': (context) => LoginPage(),
          '/createAccount': (context) => CreateAccount(),
        },
        home: context.read<AuthService>().isUserValid()
            ? const ShowLists()
            : LoginPage());
  }
}
