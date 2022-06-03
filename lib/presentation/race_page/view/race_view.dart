import 'dart:math';

import '../../../data/repositories/team_counter/team_counter_repository.dart';
import '../../../data/utils/enums/counter_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/teamcounter_bloc.dart';
part '../view/widgets/tapp_button.dart';
part '../view/widgets/scoreboard.dart';
part '../view/widgets/restart_button.dart';

class RacePage extends StatelessWidget {
  const RacePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RepositoryProvider(
        create: (context) => TeamCounterRepository(),
        child: BlocProvider<TeamCounterBloc>(
          create: (context) => TeamCounterBloc(
            repository: context.read<TeamCounterRepository>(),
          ),
          child: Builder(builder: (context) {
            return Column(
              children: [
                BlocBuilder<TeamCounterBloc, TeamCounterState>(
                  buildWhen: (previous, current) => current is SecondPlayerIncrementScoreState || previous is TeamCounterFinishState,
                  builder: (context, state) {
                    return _TappButton(
                      angle: pi,
                      status: state.status,
                      onTap: () => context.read<TeamCounterRepository>().incrementCounter(isFirstPlayer: false),
                      color: Colors.red,
                      score: context.select<TeamCounterRepository, int>((value) => value.secondPlayerScore),
                      teamName: 'Red Team',
                    );
                  },
                ),
                BlocConsumer<TeamCounterBloc, TeamCounterState>(
                  listenWhen: (previous, current) => (current is TeamCounterInitialState || current is TeamCounterFinishState),
                  listener: (context, state) {
                    if (state is TeamCounterInitialState) {
                      showSnackBar(context, "Oyun Başladı!");
                    } else if (state is TeamCounterFinishState) {
                      showSnackBar(context, "Oyun Bitti!");
                    }
                  },
                  builder: (context, state) {
                    if (state is TeamCounterFinishState) {
                      return _RestartButton(
                        onTap: () => context.read<TeamCounterRepository>().restart(),
                      );
                    }
                    return _ScoreBoard(
                      firstTeamScore: context.select<TeamCounterRepository, int>((value) => value.firstPlayerScore).toString(),
                      secondTeamScore: context.select<TeamCounterRepository, int>((value) => value.secondPlayerScore).toString(),
                    );
                  },
                ),
                BlocBuilder<TeamCounterBloc, TeamCounterState>(
                  buildWhen: (previous, current) => current is FirstPlayerIncrementScoreState || previous is TeamCounterFinishState,
                  builder: (context, state) {
                    return _TappButton(
                      status: state.status,
                      onTap: () => context.read<TeamCounterRepository>().incrementCounter(isFirstPlayer: true),
                      color: Colors.blue,
                      score: context.select<TeamCounterRepository, int>((value) => value.firstPlayerScore),
                      teamName: 'Blue Team',
                    );
                  },
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(content: Text(message)),
    );
}
