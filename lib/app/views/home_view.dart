import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../controllers/clock_controller.dart';
import '../controllers/settings_controller.dart';
import '../models/clock_state.dart';
import 'shared/shell_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  KeyEventResult _onKey(BuildContext context, KeyEvent event) {
    final _ClockShortcuts? key;
    if (event.runtimeType != KeyDownEvent ||
        (key = _ClockShortcutsExtension.fromKey(event.character)) == null) {
      return KeyEventResult.ignored;
    }
    switch (key) {
      case _ClockShortcuts.toggle:
        ClockController().toggleStart();
        break;
      case _ClockShortcuts.reset:
        ClockController().reset();
        break;
      case _ClockShortcuts.showHelp:
        showDialog(
          context: context,
          builder: (context) => const _ShortCutsDialog(),
        );
        break;
      default:
        return KeyEventResult.ignored;
    }
    return KeyEventResult.handled;
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onKeyEvent: (node, event) => _onKey(context, event),
      autofocus: true,
      child: ShellWidget(
        children: [
          const SizedBox(height: 30),
          VisibilityDetector(
            key: const Key('clock-widget'),
            onVisibilityChanged: (info) {
              if (info.visibleFraction != 0) {
                ClockController().continueStreaming();
              } else {
                ClockController().pauseStreaming();
              }
            },
            child: StreamBuilder(
              stream: ClockController().clockState.stream$,
              builder: (context, snapshot) {
                final seconds = (snapshot.data?.seconds ?? 0) % 60;
                final minutes = ((snapshot.data?.seconds ?? 0) ~/ 60) % 60;
                final hours = (snapshot.data?.seconds ?? 0) ~/ 3600;
                final double progressFraction =
                    ClockController().clockMode.current == ClockMode.done
                        ? 1
                        : (snapshot.data?.progressFraction ?? 0);
                final phaseType =
                    snapshot.data?.phase.type ?? ClockPhaseType.essay;
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 300,
                      height: 300,
                      child: CircularProgressIndicator(
                        value: progressFraction,
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.2),
                        strokeWidth: 3,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          phaseType == ClockPhaseType.essay
                              ? 'Essay'
                              : 'Chapter ${snapshot.data?.phase.counter}',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        Text(
                          '${hours == 0 ? '' : '${hours.toString().padLeft(2, '0')} : '}${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        const _ButtonsRow(),
                      ],
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ButtonsRow extends StatelessWidget {
  const _ButtonsRow({super.key});

  static void toggleClock() {
    ClockController().toggleStart();
  }

  static void resetClock() {
    ClockController().reset();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StreamBuilder(
          stream: ClockController().clockMode.stream$,
          builder: (context, snapshot) {
            final mode = snapshot.data ?? ClockMode.off;
            final mainButtonText = {
              ClockMode.off: 'Start',
              ClockMode.done: 'Start',
              ClockMode.on: 'Stop',
              ClockMode.paused: 'Continue',
            }[mode];
            final icon = {
              ClockMode.off: Icons.play_arrow_rounded,
              ClockMode.done: Icons.play_arrow_rounded,
              ClockMode.paused: Icons.play_arrow_rounded,
              ClockMode.on: Icons.pause_rounded,
            }[mode];
            return TextButton.icon(
              icon: Icon(icon),
              onPressed: toggleClock,
              label: Text('$mainButtonText'),
            );
          },
        ),
        StreamBuilder(
          stream: SettingsController().showReset.stream$,
          builder: (context, snapshot) {
            if (snapshot.data == false) return const SizedBox.shrink();
            return TextButton.icon(
              icon: const Icon(Icons.restart_alt_rounded),
              onPressed: resetClock,
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.secondary,
              ),
              label: const Text('Reset'),
            );
          },
        ),
      ],
    );
  }
}

enum _ClockShortcuts { toggle, reset, showHelp }

extension _ClockShortcutsExtension on _ClockShortcuts {
  String get label {
    switch (this) {
      case _ClockShortcuts.toggle:
        return 'Start/Stop';
      case _ClockShortcuts.reset:
        return 'Reset';
      case _ClockShortcuts.showHelp:
        return 'Show this dialog';
    }
  }

  String get shortcut {
    switch (this) {
      case _ClockShortcuts.toggle:
        return 'E';
      case _ClockShortcuts.reset:
        return 'R';
      case _ClockShortcuts.showHelp:
        return '?';
    }
  }

  IconData get icon {
    switch (this) {
      case _ClockShortcuts.toggle:
        return Icons.play_arrow_rounded;
      case _ClockShortcuts.reset:
        return Icons.restart_alt_rounded;
      case _ClockShortcuts.showHelp:
        return Icons.help_outline_rounded;
    }
  }

  static _ClockShortcuts? fromKey(String? character) {
    switch (character) {
      case 'E':
        return _ClockShortcuts.toggle;
      case 'R':
        return _ClockShortcuts.reset;
      case '?':
        return _ClockShortcuts.showHelp;
      default:
        return null;
    }
  }
}

class _ShortCutsDialog extends StatelessWidget {
  const _ShortCutsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Shortcuts'),
      children: _ClockShortcuts.values
          .map(
            (e) => ListTile(
              leading: Icon(e.icon),
              title: Text(e.label),
              subtitle: Text('Press "${e.shortcut}"'),
            ),
          )
          .toList(),
    );
  }
}
