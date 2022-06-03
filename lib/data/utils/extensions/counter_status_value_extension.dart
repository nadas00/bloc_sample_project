part of '../enums/counter_status_enum.dart';

extension CounterStatusValue on CounterStatus {
  int get toInt {
    switch (this) {
      case CounterStatus.normalScore:
        return 1;
      case CounterStatus.doubleScore:
        return 2;
      case CounterStatus.none:
        return 0;
    }
  }
}
