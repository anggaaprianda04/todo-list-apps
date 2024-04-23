import 'package:flutter/material.dart';
import 'package:todo_list/custom_appbar.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'Detail',
        isBackPage: true,
      ),
    );
  }
}
