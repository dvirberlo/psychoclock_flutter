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
                    initValue: settings.withEssay,
                    onChanged: (value) =>
                        SettingsController().withEssay.set(value),
                    labelWidget: Row(
                      children: [
                        const Text('With essay'),
                        const SizedBox(width: 10),
                        if (settings.withEssay)
                          _DoubleField(
                            afterLabel: 'seconds long',
                            initValue: settings.essaySeconds,
                            onChanged: (value) {
                              SettingsController().essaySeconds.set(value);
                            },
                          ),
                      ],
                    ),
                  ),
                  _IntField(
                    afterLabel: 'chapters',
                    initValue: settings.chaptersCount,
                    onChanged: (value) =>
                        SettingsController().chaptersCount.set(value),
                  ),
                  if (settings.chaptersCount > 0)
                    _DoubleField(
                      label: 'Each chapter',
                      afterLabel: 'seconds long',
                      initValue: settings.chapterSeconds,
                      onChanged: (value) {
                        SettingsController().chapterSeconds.set(value);
                      },
                    ),
                  const SizedBox(height: 10),
                  const Divider(thickness: 2),
                  const SizedBox(height: 10),
                  _Toggle(
                    initValue: settings.notifyBeforeEnd,
                    onChanged: (value) =>
                        SettingsController().notifyBeforeEnd.set(value),
                    labelWidget: Row(
                      children: [
                        const Text('Notify'),
                        if (settings.notifyBeforeEnd)
                          _DoubleField(
                            afterLabel: 'seconds',
                            initValue: settings.secondsLeftCount,
                            onChanged: (value) => SettingsController()
                                .secondsLeftCount
                                .set(value),
                          ),
                        const Text(' before ends'),
                      ],
                    ),
                  ),
                  _Toggle(
                    labelWidget: const Text('Show reset button'),
                    initValue: settings.showReset,
                    onChanged: (value) =>
                        SettingsController().showReset.set(value),
                  ),
                  _Choice<ResetType>(
                    label: 'Reset type',
                    initValue: settings.resetType,
                    values: const {
                      ResetType.always: 'Always',
                      ResetType.essay: 'After essay',
                      ResetType.never: 'Never',
                    },
                    onChanged: (value) =>
                        SettingsController().resetType.set(value),
                  ),
                  _Choice<ProgressType>(
                    label: 'Circle progress type',
                    initValue: settings.progressType,
                    values: const {
                      ProgressType.total: 'Total',
                      ProgressType.perPhase: 'Per phase',
                    },
                    onChanged: (value) =>
                        SettingsController().progressType.set(value),
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

const _inputsAlignment = MainAxisAlignment.center;

class _Choice<T> extends StatelessWidget {
  final String label;
  final T initValue;
  final Map<T, String> values;
  final Function(T) onChanged;
  const _Choice({
    super.key,
    this.label = '',
    required this.initValue,
    required this.values,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: _inputsAlignment,
      children: [
        Text(label),
        const SizedBox(width: 10),
        DropdownButton<T>(
          value: initValue,
          onChanged: (value) => onChanged(value ?? initValue),
          items: values
              .map(
                (key, value) => MapEntry(
                  key,
                  DropdownMenuItem(
                    value: key,
                    child: Text(value),
                  ),
                ),
              )
              .values
              .toList(),
        ),
      ],
    );
  }
}

class _Toggle extends StatelessWidget {
  final Widget? labelWidget;
  final bool initValue;
  final Function(bool) onChanged;
  const _Toggle({
    super.key,
    this.labelWidget,
    required this.initValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: _inputsAlignment,
      children: [
        Switch(
          value: initValue,
          onChanged: (value) => onChanged(value),
        ),
        if (labelWidget != null) const SizedBox(width: 2),
        labelWidget ?? const SizedBox.shrink(),
      ],
    );
  }
}

class _Field extends StatelessWidget {
  final String label;
  final String afterLabel;
  final String initValue;
  final Function(String) onChanged;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  const _Field({
    super.key,
    this.label = '',
    this.afterLabel = '',
    required this.initValue,
    required this.onChanged,
    this.keyboardType,
    this.inputFormatters,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: _inputsAlignment,
      children: [
        Text(label),
        if (label.isNotEmpty) const SizedBox(width: 5),
        Container(
          constraints: const BoxConstraints(maxWidth: 30),
          child: TextFormField(
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            onChanged: (value) => onChanged(value),
            initialValue: initValue,
            enabled: enabled,
            textAlign: TextAlign.center,
          ),
        ),
        if (afterLabel.isNotEmpty) const SizedBox(width: 5),
        Text(
          afterLabel,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _DoubleField extends _Field {
  _DoubleField({
    super.key,
    super.label,
    super.afterLabel = 'seconds',
    required int initValue,
    required Function(int) onChanged,
    devideBy = 60,
    super.enabled,
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
    super.afterLabel,
    required int initValue,
    required Function(int) onChanged,
    super.enabled,
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
