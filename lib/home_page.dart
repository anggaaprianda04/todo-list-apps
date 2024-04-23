import 'package:flutter/material.dart';
import 'package:todo_list/create_page.dart';
import 'package:todo_list/custom_appbar.dart';
import 'package:todo_list/database_instance.dart';
import 'package:todo_list/detail_page.dart';
import 'package:todo_list/todo_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseInstance databaseInstance = DatabaseInstance();

  Future _refresh() async {
    setState(() {});
  }

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
      body: RefreshIndicator(
        edgeOffset: 20.0,
        backgroundColor: Colors.white,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        strokeWidth: 3.0,
        color: Colors.deepPurple,
        displacement: 20.0,
        onRefresh: () => _refresh(),
        child: FutureBuilder<List<TodoModel>>(
          future: databaseInstance.getAll(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Text("List masih kosong");
              }
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DetailPage(),
                        )),
                    child: ListTile(
                      title: Text(snapshot.data![index].title ?? ""),
                    ),
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
      ),
    );
  }
}
