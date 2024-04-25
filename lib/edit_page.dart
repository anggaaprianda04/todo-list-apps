import 'package:flutter/material.dart';
import 'package:todo_list/custom_appbar.dart';
import 'package:todo_list/custom_form_field.dart';
import 'package:todo_list/database_instance.dart';
import 'package:todo_list/todo_model.dart';

class EditPage extends StatefulWidget {
  final TodoModel? todoModel;
  const EditPage({required this.todoModel, super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  TextEditingController titleEditController = TextEditingController();
  TextEditingController descEditController = TextEditingController();

  @override
  void dispose() {
    titleEditController.clear();
    descEditController.clear();
    super.dispose();
  }

  @override
  void initState() {
    databaseInstance.database();
    titleEditController.text = widget.todoModel?.title ?? "";
    descEditController.text = widget.todoModel?.desc ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        isBackPage: true,
        title: 'Edit data',
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
              textEditingController: titleEditController,
            ),
            CustomFormFiled(
              title: "Deskripsi",
              textEditingController: descEditController,
              isMaxLine: true,
            ),
            ElevatedButton(
                style: const ButtonStyle(
                    shape: MaterialStatePropertyAll(BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)))),
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.deepPurple)),
                onPressed: () async {
                  await databaseInstance.update(widget.todoModel!.id!, {
                    "title": titleEditController.text,
                    "desc": descEditController.text,
                    "updated_at": DateTime.now().toString(),
                  });
                  Navigator.pop(context);
                },
                child: const Text(
                  'Ubah',
                  style: TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
