import 'package:flutter/widgets.dart';

import 'shared/shell_widget.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShellWidget(
      title: 'About',
      children: [
        Text(
          'A modern and customizable clock to simulate a psychometric test.\n\n'
          'It tries to focus in modern and simple design, without compromising any feature.',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
