import 'package:rxdart/rxdart.dart';

class Streamable<T> {
  final BehaviorSubject<T> _subject;
  final List<Function> _onSet;

  Streamable(T initValue)
      : _onSet = [],
        _subject = BehaviorSubject.seeded(initValue);

  Streamable.withOnSets(
    T initValue,
    List<Function> onSet,
  )   : _onSet = onSet,
        _subject = BehaviorSubject.seeded(initValue);

  Streamable.withOnSet(
    T initValue,
    Function onSet,
  )   : _onSet = [onSet],
        _subject = BehaviorSubject.seeded(initValue);

  Stream<T> get stream$ => _subject.stream;
  T get current => _subject.value;

  void set(T value) {
    if (value == current) return;
    _subject.add(value);
    for (final func in _onSet) {
      func();
    }
  }
}
