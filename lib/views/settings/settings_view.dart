import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:psychoclock/controllers/settings_controller.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text('Settings View'),
          StreamBuilder(
            stream: SettingsController().settingsChanges$,
            builder: (context, snap) {
              return Text(
                  'Settings: ${json.encode(SettingsController().settings.toJson())}');
            },
          ),
        ],
      ),
    );
  }
}
