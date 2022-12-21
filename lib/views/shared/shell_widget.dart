import 'dart:math';

import 'package:flutter/widgets.dart';

class ShellWidget extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  const ShellWidget({super.key, this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: max((MediaQuery.of(context).size.width * 0.7), 300),
          child: Column(
            children: [
              if (title != null)
                Text(
                  title!,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
              if (title != null) const SizedBox(height: 20),
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}
