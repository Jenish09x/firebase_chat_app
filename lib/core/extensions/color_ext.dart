part of '../core.dart';
extension $ColorExtension on Color{
  Color withColorOpacity(double opacity) => this.withValues(alpha: opacity);
}