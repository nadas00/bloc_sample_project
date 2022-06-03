import 'presentation/race_page/view/race_view.dart';
import 'package:flutter/material.dart';

class TappGame extends StatelessWidget {
  const TappGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RacePage(),
    );
  }
}
