import 'dart:async';
import 'dart:math';

import '../../utils/enums/counter_status_enum.dart';
import '../../../presentation/race_page/bloc/teamcounter_bloc.dart';

List<CounterStatus> doubleChance = [...List.generate(3, (_) => CounterStatus.doubleScore), ...List.generate(7, (_) => CounterStatus.normalScore)];

class TeamCounterRepository {
  final StreamController<TeamcounterEvent> counterStream = StreamController<TeamcounterEvent>();

  TeamCounterRepository();

  Stream<TeamcounterEvent> get incrementStreamStatus async* {
    yield* counterStream.stream;
  }

  final _random = Random();
  int firstPlayerScore = 0;
  int secondPlayerScore = 0;
  void incrementCounter({required bool isFirstPlayer}) {
    if (firstPlayerScore >= 10 || secondPlayerScore >= 10) {
      return;
    }
    CounterStatus randomScore = doubleChance[_random.nextInt(doubleChance.length)];

    _incrementScore(randomScore, isFirstPlayer);
    _controlFinish(isFirstPlayer ? firstPlayerScore : secondPlayerScore);
  }

  void _incrementScore(CounterStatus counterStatus, bool isFirstPlayer) {
    if (isFirstPlayer) {
      firstPlayerScore += counterStatus.toInt;
    } else {
      secondPlayerScore += counterStatus.toInt;
    }
    counterStream.add(IncrementScoreEvent(counterStatus: counterStatus, isFirstPlayer: isFirstPlayer));
  }

  void _controlFinish(int score) {
    if (score >= 10) {
      counterStream.add(GameFinishEvent());
    }
  }

  void restart() {
    firstPlayerScore = 0;
    secondPlayerScore = 0;
    counterStream.add(RestartGameEvent());
  }

  void dispose() {
    counterStream.close();
  }
}
