import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:psychoclock/controllers/settings_controller.dart';
import 'package:psychoclock/models/settings.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Column(
        children: [
          const Text('Settings View'),
          StreamBuilder(
            stream: SettingsController().settingsChanges$,
            builder: (context, snap) {
              final settings = SettingsController().generateSettings();
              return Column(
                children: [
                  _Toggle(
                    label: 'With essay',
                    initValue: settings.withEssay,
                    onChanged: (value) =>
                        SettingsController().withEssay.set(value),
                  ),
                  if (settings.withEssay)
                    _DoubleField(
                      label: 'Essay seconds',
                      initValue: settings.essaySeconds,
                      onChanged: (value) {
                        SettingsController().essaySeconds.set(value);
                      },
                    ),
                  _IntField(
                    label: 'Chapters count',
                    initValue: settings.chaptersCount,
                    onChanged: (value) =>
                        SettingsController().chaptersCount.set(value),
                  ),
                  if (settings.chaptersCount > 0)
                    _DoubleField(
                      label: 'Chapter seconds',
                      initValue: settings.chapterSeconds,
                      onChanged: (value) {
                        SettingsController().chapterSeconds.set(value);
                      },
                    ),
                  const SizedBox(height: 10),
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(height: 10),
                  _Toggle(
                    label: 'Notify when a phase nears its end',
                    initValue: settings.notifyBeforeEnd,
                    onChanged: (value) =>
                        SettingsController().notifyBeforeEnd.set(value),
                  ),
                  if (settings.notifyBeforeEnd)
                    _DoubleField(
                      label: 'Notify before ends seconds',
                      initValue: settings.secondsLeftCount,
                      onChanged: (value) =>
                          SettingsController().secondsLeftCount.set(value),
                    ),
                  _Toggle(
                    label: 'Reset clock after essay',
                    initValue: settings.resetVisualClockEssay,
                    onChanged: (value) {
                      SettingsController().resetVisualClockEssay.set(value);
                      SettingsController().resetVisualClockChapter.set(value);
                    },
                  ),
                  if (settings.resetVisualClockEssay)
                    _Toggle(
                      label: 'Reset clock after chapters',
                      initValue: settings.resetVisualClockChapter,
                      onChanged: (value) => SettingsController()
                          .resetVisualClockChapter
                          .set(value),
                    ),
                  _Toggle(
                    label: 'Circlular bar represents current phase',
                    initValue: settings.progressType == ProgressType.perPhase,
                    onChanged: (value) {
                      SettingsController().progressType.set(
                          value ? ProgressType.perPhase : ProgressType.total);
                    },
                  ),
                  _Toggle(
                    label: 'Show reset button',
                    initValue: settings.showReset,
                    onChanged: (value) =>
                        SettingsController().showReset.set(value),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _Toggle extends StatelessWidget {
  final String label;
  final bool initValue;
  final Function(bool) onChanged;
  const _Toggle({
    super.key,
    this.label = '',
    required this.initValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Switch(
          value: initValue,
          onChanged: (value) => onChanged(value),
        ),
        Text(label),
        const SizedBox(width: 10),
      ],
    );
  }
}

class _Field extends StatelessWidget {
  final String label;
  final String initValue;
  final Function(String) onChanged;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  const _Field({
    super.key,
    this.label = '',
    required this.initValue,
    required this.onChanged,
    this.keyboardType,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label),
        const SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            onChanged: (value) => onChanged(value),
            initialValue: initValue,
          ),
        ),
      ],
    );
  }
}

class _DoubleField extends _Field {
  _DoubleField({
    super.key,
    super.label,
    required int initValue,
    required Function(int) onChanged,
    devideBy = 60,
  }) : super(
          initValue: ((initValue / devideBy) % 1 != 0)
              ? (initValue / devideBy).toString()
              : (initValue / devideBy).toStringAsFixed(0),
          onChanged: (value) {
            final newVal = double.tryParse(value);
            if (newVal == null) return;
            onChanged((newVal * devideBy).toInt());
          },
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp(r'^\d+\.?\d{0,2}'),
            ),
          ],
          keyboardType: TextInputType.number,
        );
}

class _IntField extends _Field {
  _IntField({
    super.key,
    super.label,
    required int initValue,
    required Function(int) onChanged,
  }) : super(
          initValue: initValue.toString(),
          onChanged: (value) {
            final newVal = int.tryParse(value);
            if (newVal == null) return;
            onChanged(newVal);
          },
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
        );
}
