import 'package:firebase_chat_app/core/core.dart';
import 'package:firebase_chat_app/resources/resources.dart';
import 'package:flutter/material.dart';

class GradientFilledButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final double? width;

  const GradientFilledButton({super.key, this.onPressed, required this.child, this.width});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(backgroundColor: Colors.transparent, padding: EdgeInsets.zero),
      child: Ink(
        width: width,
        padding: EdgeInsets.symmetric(horizontal: Spacing.xLarge, vertical: Spacing.medium),
        decoration: BoxDecoration(
          borderRadius: ShapeBorderRadius.medium,
          color: context.colorScheme.inverseSurface,
          gradient: onPressed == null
              ? null
              : LinearGradient(
                  colors: [context.colorScheme.primary, context.colorScheme.secondary],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
        ),
        child: child,
      ),
    );
  }
}
