enum ClockMode { off, on, paused, done }

enum ClockPhaseType { essay, chapters }

class ClockPhase {
  final ClockPhaseType type;
  final int? counter;
  const ClockPhase({
    required this.type,
    this.counter,
  });
}

class ClockState {
  final int seconds;
  final double progressFraction;
  final ClockPhase phase;
  const ClockState({
    this.seconds = 0,
    this.progressFraction = 0,
    this.phase = const ClockPhase(type: ClockPhaseType.essay),
  });

  ClockState copyWith({
    int? seconds,
    double? progressFraction,
    ClockPhase? phase,
  }) {
    return ClockState(
      seconds: seconds ?? this.seconds,
      progressFraction: progressFraction ?? this.progressFraction,
      phase: phase ?? this.phase,
    );
  }
}
