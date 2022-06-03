part of '../../view/race_view.dart';

class _RestartButton extends StatelessWidget {
  final VoidCallback onTap;
  const _RestartButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.black12,
        child: Column(
          children: [
            Transform.rotate(
              angle: pi,
              child: Text(
                "Tekrar Başlat!",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Tekrar Başlat!",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}
