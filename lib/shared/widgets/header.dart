import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.title, this.widget});

  final String title;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        if (widget != null) widget!,
      ],
    );
  }
}
