import 'package:bloc/bloc.dart';
import '../../../data/utils/enums/counter_status_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/team_counter/team_counter_repository.dart';

part 'teamcounter_event.dart';
part 'teamcounter_state.dart';

class TeamCounterBloc extends Bloc<TeamcounterEvent, TeamCounterState> {
  final TeamCounterRepository _repository;

  TeamCounterBloc({required TeamCounterRepository repository})
      : _repository = repository,
        super(TeamCounterInitialState()) {
    on<IncrementScoreEvent>(_incrementScore);
    on<GameFinishEvent>(_finishGame);
    on<RestartGameEvent>(_restartGame);
  }

  void _incrementScore(IncrementScoreEvent event, Emitter<TeamCounterState> emit) {
    CounterStatus randomScore = _repository.pickRandomIncrement();
    GameState gameState = _repository.incrementCounter(isFirstPlayer: event.isFirstPlayer, counterStatus: randomScore);
    if (gameState == GameState.none) {
      return;
    }
    emit(event.isFirstPlayer ? FirstPlayerIncrementScoreState(randomScore) : SecondPlayerIncrementScoreState(randomScore));
    if (gameState == GameState.finish) {
      emit(TeamCounterFinishState());
    }
  }

  void _finishGame(GameFinishEvent event, Emitter<TeamCounterState> emit) {
    emit(TeamCounterFinishState());
  }

  void _restartGame(RestartGameEvent event, Emitter<TeamCounterState> emit) {
    _repository.restart();
    emit(TeamCounterInitialState());
  }
}
