import 'package:firebase_chat_app/core/core.dart';
import 'package:firebase_chat_app/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class EmptyViewAction extends StatelessWidget {
  const EmptyViewAction({super.key, required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return TextButton(
      style: TextButton.styleFrom(foregroundColor: colorScheme.primary),
      onPressed: onPressed,
      child: Text.rich(
        TextSpan(
          text: label,
          children: const [
            WidgetSpan(alignment: PlaceholderAlignment.middle, child: Icon(Icons.navigate_next_outlined)),
          ],
        ),
        style: const TextStyle(height: 1.0),
      ),
    );
  }
}

class EmptyDataView extends StatelessWidget {
  const EmptyDataView({super.key, required this.icon, this.title, this.description, this.action});

  final String icon;
  final String? title;
  final String? description;
  final EmptyViewAction? action;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final foregroundColor = theme.colorScheme.onSurfaceVariant;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.normal),
        child: FittedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Material(
                  type: MaterialType.transparency,
                  shape: CircleBorder(
                    side: BorderSide(color: foregroundColor, width: 2, strokeAlign: BorderSide.strokeAlignInside),
                  ),
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 96, maxHeight: 96),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(Spacing.medium),
                    child: SvgPicture.asset(
                      icon,
                      height: 48,
                      colorFilter: ColorFilter.mode(foregroundColor, BlendMode.srcIn),
                    ),
                  ),
                ),
              ),
              const Gap(Spacing.normal),
              if (title != null) ...[
                DefaultTextStyle.merge(
                  style: theme.textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                  child: Text(title ?? "", style: TextStyle(color: foregroundColor)),
                ),
              ],
              if (!description.isNullOrEmpty) ...[
                const Gap(Spacing.small),
                Text(
                  description ?? "",
                  style: TextStyle(color: foregroundColor),
                  textAlign: TextAlign.center,
                ),
              ],
              if (action != null) ...[const Gap(Spacing.small), action!],
            ],
          ),
        ),
      ),
    );
  }
}
