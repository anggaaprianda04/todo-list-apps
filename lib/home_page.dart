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

  Future deleteTodo(int id) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('AlertDialog Title'),
        content: const Text('AlertDialog description'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, "Cancel"),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await databaseInstance.delete(id);
              setState(() {});
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
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
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                              todoModel: snapshot.data![index],
                            ),
                          )),
                      child: ListTile(
                        title: Text(
                          snapshot.data![index].title ?? "",
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                            snapshot.data![index].createdAt!.substring(0, 10)),
                        trailing: GestureDetector(
                          onTap: () => deleteTodo(snapshot.data![index].id!),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
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
