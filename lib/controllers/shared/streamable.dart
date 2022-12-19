import 'package:rxdart/rxdart.dart';

class Streamable<T> {
  final BehaviorSubject<T> _subject;
  final List<Function> _changeListeners;

  Streamable(T initValue)
      : _changeListeners = [],
        _subject = BehaviorSubject.seeded(initValue);

  Streamable.withListeners(
    T initValue,
    List<Function> onSet,
  )   : _changeListeners = onSet,
        _subject = BehaviorSubject.seeded(initValue);

  Streamable.withListener(
    T initValue,
    Function onSet,
  )   : _changeListeners = [onSet],
        _subject = BehaviorSubject.seeded(initValue);

  Stream<T> get stream$ => _subject.stream;
  T get current => _subject.value;

  void set(T value) {
    if (value == current) return;
    _subject.add(value);
    for (final func in _changeListeners) {
      func();
    }
  }
}
