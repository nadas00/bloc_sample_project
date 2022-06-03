import 'core/init/bloc/bloc_observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'roota_app.dart';
import 'package:flutter/material.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(const TappGame()),
    blocObserver: SimpleBlocObserver(),
  );
}
