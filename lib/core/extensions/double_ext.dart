part of '../core.dart';
extension $NullableDoubleExt on double? {
  String get toRoundFormat {
    if (this == null) {
      return "0";
    }
    if (this! % 1 == 0) {
      return this!.toInt().toString();
    } else {
      return this!.toStringAsFixed(1);
    }
  }
}

