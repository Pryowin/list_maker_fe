import 'package:flutter/material.dart';
import 'package:list_maker/services/auth_service.dart';
import 'package:provider/provider.dart';

class ShowLists extends StatefulWidget {
  const ShowLists({super.key});

  @override
  State<ShowLists> createState() => _ShowListsState();
}

class _ShowListsState extends State<ShowLists> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Show Lists'),
        actions: [
          IconButton(
              onPressed: () {
                context.read<AuthService>().logoutUser();
                Navigator.pushReplacementNamed(context, '/login');
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: const Center(
        child: Text(
          'This is a placeholder for the ShowLists widget',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
