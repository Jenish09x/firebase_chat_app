import 'package:firebase_chat_app/core/core.dart';
import 'package:firebase_chat_app/resources/resources.dart';
import 'package:flutter/material.dart';

class OutlineCommonButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final double? width;

  const OutlineCommonButton({super.key, this.onPressed, required this.child, this.width});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(side: BorderSide(color: context.colorScheme.primary,width: 1)),
      child: Ink(
        width: width,
        padding: EdgeInsets.symmetric(horizontal: Spacing.xLarge, vertical: Spacing.medium),
        child: child,
      ),
    );
  }
}

class OutlineButton extends StatelessWidget {
  const OutlineButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
