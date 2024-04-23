import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;
  final bool isOnpressed;
  final bool isBackPage;
  final Function()? onPressed;
  const CustomAppBar(
      {required this.title,
      this.height = kToolbarHeight,
      this.onPressed,
      this.isOnpressed = false,
      this.isBackPage = false,
      super.key});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.deepPurple,
      centerTitle: true,
      leading: isBackPage == true
          ? Builder(
              builder: (context) => IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.chevron_left,
                    size: 30,
                    color: Colors.white,
                  )),
            )
          : const SizedBox(),
      actions: [
        isOnpressed == true
            ? IconButton(
                onPressed: onPressed,
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ))
            : const SizedBox()
      ],
      title: Text(
        title,
        style: const TextStyle(
            fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700),
      ),
    );
  }
}
