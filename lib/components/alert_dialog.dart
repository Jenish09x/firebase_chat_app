import 'package:firebase_chat_app/core/core.dart';
import 'package:firebase_chat_app/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AppAlertDialog extends StatelessWidget {
  static Future show({
    required BuildContext context,
    required String title,
    required String content,
    required String doneText,
    Color? doneTextColor,
    required void Function() onDone,
  }) {
    return showDialog(
      context: context,
      builder: (context) => AppAlertDialog(
        title: title,
        content: content,
        doneText: doneText,
        onDone: onDone,
        doneTextColor: doneTextColor,
      ),
    );
  }

  final String title;
  final String doneText;
  final String content;
  final void Function() onDone;
  final Color? doneTextColor;

  const AppAlertDialog({
    super.key,
    required this.title,
    required this.doneText,
    required this.content,
    required this.onDone,
    this.doneTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(Spacing.normal),
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: context.textTheme.titleLarge),
            Gap(Spacing.small),
            Text(content, style: context.textTheme.labelSmall?.copyWith(color: context.colorScheme.onSurfaceVariant)),
            Gap(Spacing.normal),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    context.navigator.pop();
                  },
                  child: Text(
                    "Cancel",
                    style: context.textTheme.labelMedium?.copyWith(color: context.colorScheme.onSurfaceVariant),
                  ),
                ),
                Gap(Spacing.medium),
                TextButton(
                  onPressed: () {
                    context.navigator.pop();
                    onDone.call();
                  },
                  child: Text(
                    doneText,
                    style: context.textTheme.labelMedium?.copyWith(color: context.colorScheme.primary),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
