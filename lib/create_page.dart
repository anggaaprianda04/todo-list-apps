import 'package:flutter/material.dart';
import 'package:todo_list/custom_appbar.dart';
import 'package:todo_list/custom_form_field.dart';
import 'package:todo_list/database_instance.dart';
import 'package:todo_list/home_page.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  TextEditingController titleController = TextEditingController(text: "");
  TextEditingController descController = TextEditingController(text: "");

  @override
  void dispose() {
    titleController.clear();
    descController.clear();
    super.dispose();
  }

  @override
  void initState() {
    databaseInstance.database();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        isBackPage: true,
        title: 'Tambah data',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            CustomFormFiled(
              title: "Judul",
              textEditingController: titleController,
            ),
            CustomFormFiled(
              title: "Deskripsi",
              textEditingController: descController,
              isMaxLine: true,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: const ButtonStyle(
                    shape: MaterialStatePropertyAll(BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)))),
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.deepPurple)),
                onPressed: () async {
                  await databaseInstance.insert({
                    "title": titleController.text,
                    "desc": descController.text,
                    "created_at": DateTime.now().toString(),
                    "updated_at": DateTime.now().toString(),
                  });
                  Navigator.pushAndRemoveUntil(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                      (route) => false);
                  setState(() {});
                },
                child: const Text(
                  'Tambah',
                  style: TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
