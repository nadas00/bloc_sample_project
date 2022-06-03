part of 'teamcounter_bloc.dart';

abstract class TeamCounterState {
  final CounterStatus status;

  TeamCounterState([this.status = CounterStatus.none]);
}

class TeamCounterInitialState extends TeamCounterState {}

class TeamCounterFinishState extends TeamCounterState {}

class FirstPlayerIncrementScoreState extends TeamCounterState {
  FirstPlayerIncrementScoreState(CounterStatus status) : super(status);
}

class SecondPlayerIncrementScoreState extends TeamCounterState {
  SecondPlayerIncrementScoreState(CounterStatus status) : super(status);
}
