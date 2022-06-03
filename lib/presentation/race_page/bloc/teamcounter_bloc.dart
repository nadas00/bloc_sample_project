import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../../data/utils/enums/counter_status_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/team_counter/team_counter_repository.dart';

part 'teamcounter_event.dart';
part 'teamcounter_state.dart';

class TeamCounterBloc extends Bloc<TeamcounterEvent, TeamCounterState> {
  @override
  Future<void> close() {
    _incrementControllerEvenetStreamSubscription.cancel();
    _repository.dispose();
    return super.close();
  }

  late StreamSubscription<TeamcounterEvent> _incrementControllerEvenetStreamSubscription;

  final TeamCounterRepository _repository;

  TeamCounterBloc({required TeamCounterRepository repository})
      : _repository = repository,
        super(TeamCounterInitialState()) {
    on<IncrementScoreEvent>(_incrementScore);
    on<GameFinishEvent>(_finishGame);
    on<RestartGameEvent>(_restartGame);
    _incrementControllerEvenetStreamSubscription = _repository.incrementStreamStatus.listen((TeamcounterEvent event) {
      add(event);
    });
  }

  void _incrementScore(IncrementScoreEvent event, Emitter<TeamCounterState> emit) {
    emit(event.isFirstPlayer ? FirstPlayerIncrementScoreState(event.counterStatus) : SecondPlayerIncrementScoreState(event.counterStatus));
  }

  void _finishGame(GameFinishEvent event, Emitter<TeamCounterState> emit) {
    emit(TeamCounterFinishState());
  }

  void _restartGame(RestartGameEvent event, Emitter<TeamCounterState> emit) {
    emit(TeamCounterInitialState());
  }
}
