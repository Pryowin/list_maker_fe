import 'package:flutter/material.dart';
import 'package:list_maker/login_page.dart';
import 'package:list_maker/services/auth_service.dart';
import 'package:list_maker/show_lists.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AuthService.init();

  runApp(Provider(
    create: (BuildContext context) => AuthService(),
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
      home: FutureBuilder<bool>(
        future: context.read<AuthService>().isUserLoggedIn(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data!) {
              return const ShowLists();
            } else {
              return LoginPage();
            }
          }
          return const CircularProgressIndicator();
        },
      ),
      debugShowCheckedModeBanner: false,
      routes: {'/lists': (context) => const ShowLists()},
    );
  }
}
