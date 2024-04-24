import 'package:flutter/material.dart';
import 'package:todo_list/custom_appbar.dart';
import 'package:todo_list/todo_model.dart';

class DetailPage extends StatelessWidget {
  final TodoModel todoModel;
  const DetailPage({required this.todoModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Detail',
        isBackPage: true,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${todoModel.title}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    todoModel.createdAt!.substring(0, 10),
                    style: const TextStyle(fontSize: 16),
                  ),
                ]),
            const SizedBox(
              height: 20,
            ),
            Text(
              '${todoModel.desc}',
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
