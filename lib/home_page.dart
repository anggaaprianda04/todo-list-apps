import 'package:flutter/material.dart';
import 'package:todo_list/create_page.dart';
import 'package:todo_list/custom_appbar.dart';
import 'package:todo_list/database_instance.dart';
import 'package:todo_list/todo_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseInstance databaseInstance = DatabaseInstance();

  @override
  void initState() {
    databaseInstance.database();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Todo List',
        isOnpressed: true,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreatePage(),
              ));
        },
      ),
      body: FutureBuilder<List<TodoModel>>(
        future: databaseInstance.getAll(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const Text("List masih kosong");
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].title ?? ""),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 10.0,
                color: Colors.deepPurple,
              ),
            );
          }
        },
      ),
    );
  }
}
