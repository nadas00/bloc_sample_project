part of '../../view/race_view.dart';

class _ScoreBoard extends StatelessWidget {
  final String firstTeamScore;
  final String secondTeamScore;
  const _ScoreBoard({
    Key? key,
    required this.firstTeamScore,
    required this.secondTeamScore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Transform.rotate(
            angle: pi,
            child: Text(
              "Blue team : $firstTeamScore",
              style: Theme.of(context).textTheme.labelLarge,
            )),
        Text(
          "Red team :  $secondTeamScore",
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }
}
