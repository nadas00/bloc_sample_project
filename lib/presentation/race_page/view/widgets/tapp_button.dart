part of '../../view/race_view.dart';

class _TappButton extends StatelessWidget {
  final CounterStatus status;
  final String teamName;
  final Color color;
  final int score;
  final VoidCallback? onTap;
  final double? angle;
  const _TappButton({
    Key? key,
    required this.teamName,
    required this.color,
    required this.score,
    required this.status,
    this.angle,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Transform.rotate(
        angle: angle ?? 0,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: ShapeDecoration(
              shape: const ContinuousRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
              color: color,
            ),
            margin: const EdgeInsets.all(32),
            padding: const EdgeInsets.all(32),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  teamName,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(
                  "Tapp!! ${status == CounterStatus.doubleScore ? "+2" : ""}",
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  score.toString(),
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
