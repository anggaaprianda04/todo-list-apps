import 'package:flutter/material.dart';
import 'package:todo_list/custom_appbar.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        isBackPage: true,
        title: 'Tambah data',
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
