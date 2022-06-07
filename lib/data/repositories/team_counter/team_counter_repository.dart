import 'dart:math';

import '../../utils/enums/counter_status_enum.dart';

List<CounterStatus> doubleChance = [...List.generate(3, (_) => CounterStatus.doubleScore), ...List.generate(7, (_) => CounterStatus.normalScore)];
enum GameState { finish, restart, increment, none }

class TeamCounterRepository {
  TeamCounterRepository();

  final _random = Random();
  CounterStatus pickRandomIncrement() {
    CounterStatus randomScore = doubleChance[_random.nextInt(doubleChance.length)];
    return randomScore;
  }

  int firstPlayerScore = 0;
  int secondPlayerScore = 0;
  GameState incrementCounter({required bool isFirstPlayer, required CounterStatus counterStatus}) {
    if (firstPlayerScore >= 10 || secondPlayerScore >= 10) {
      return GameState.none;
    }
    _incrementScore(counterStatus, isFirstPlayer);
    return _controlFinish(isFirstPlayer ? firstPlayerScore : secondPlayerScore);
  }

  _incrementScore(CounterStatus counterStatus, bool isFirstPlayer) {
    if (isFirstPlayer) {
      firstPlayerScore += counterStatus.toInt;
    } else {
      secondPlayerScore += counterStatus.toInt;
    }
  }

  _controlFinish(int score) {
    if (score >= 10) {
      return GameState.finish;
    }
    return GameState.increment;
  }

  GameState restart() {
    firstPlayerScore = 0;
    secondPlayerScore = 0;
    return GameState.restart;
  }
}
