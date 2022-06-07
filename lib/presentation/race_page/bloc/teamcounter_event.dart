part of 'teamcounter_bloc.dart';

abstract class TeamcounterEvent {}

class IncrementScoreEvent extends TeamcounterEvent {
  final bool isFirstPlayer;

  IncrementScoreEvent({required this.isFirstPlayer});
}

class GameFinishEvent extends TeamcounterEvent {
  GameFinishEvent();
}

class RestartGameEvent extends TeamcounterEvent {
  RestartGameEvent();
}
