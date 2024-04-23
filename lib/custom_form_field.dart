import 'package:flutter/material.dart';

class CustomFormFiled extends StatelessWidget {
  final String title;
  final bool isMaxLine;
  final TextEditingController textEditingController;
  const CustomFormFiled({
    required this.textEditingController,
    required this.title,
    this.isMaxLine = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: textEditingController,
            maxLines: isMaxLine ? 3 : null,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
