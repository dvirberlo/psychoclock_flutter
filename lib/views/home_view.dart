import 'package:flutter/material.dart';

import '../controllers/clock_controller.dart';
import '../controllers/settings_controller.dart';
import '../models/clock_state.dart';
import 'shared/shell_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ShellWidget(
      children: [
        const SizedBox(height: 30),
        StreamBuilder(
          stream: ClockController().clockState.stream$,
          builder: (context, snapshot) {
            final seconds = (snapshot.data?.seconds ?? 0) % 60;
            final minutes = ((snapshot.data?.seconds ?? 0) ~/ 60) % 60;
            final hours = (snapshot.data?.seconds ?? 0) ~/ 3600;
            final double progressFraction =
                ClockController().clockMode.current == ClockMode.done
                    ? 1
                    : (snapshot.data?.progressFraction ?? 0);
            final phaseType = snapshot.data?.phase.type ?? ClockPhaseType.essay;
            return Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 300,
                  height: 300,
                  child: CircularProgressIndicator(
                    value: progressFraction,
                    backgroundColor:
                        Theme.of(context).primaryColor.withOpacity(0.2),
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
      ],
    );
  }
}

class _ButtonsRow extends StatelessWidget {
  const _ButtonsRow({super.key});

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
              onPressed: () {
                ClockController().toggleStart();
              },
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
              onPressed: () {
                ClockController().reset();
              },
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
