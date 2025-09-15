import 'package:firebase_chat_app/core/core.dart';
import 'package:firebase_chat_app/resources/resources.dart';
import 'package:flutter/material.dart';

class _ModalTitle extends StatelessWidget {
  const _ModalTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: context.theme.textTheme.titleLarge,
      textAlign: TextAlign.center,
      child: Text(title, style: context.textTheme.headlineSmall),
    );
  }
}

class BottomSheetHeader extends StatelessWidget implements PreferredSizeWidget {
  const BottomSheetHeader({super.key, required this.title});

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + Spacing.large);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Container(
      color: theme.colorScheme.surface,
      foregroundDecoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: theme.colorScheme.outline)),
      ),
      child: Column(
        children: [
          Container(
            height: 4,
            width: 64,
            margin: const EdgeInsets.fromLTRB(Spacing.normal, Spacing.medium, Spacing.normal, Spacing.none),
            decoration: BoxDecoration(
              borderRadius: ShapeBorderRadius.small,
              color: theme.bottomSheetTheme.dragHandleColor ?? theme.colorScheme.onSurface.withOpacity(.2),
            ),
          ),
          SizedBox(
            height: kToolbarHeight,
            child: NavigationToolbar(centerMiddle: true, middle: _ModalTitle(title: title)),
          ),
        ],
      ),
    );
  }
}

class DialogHeader extends StatelessWidget implements PreferredSizeWidget {
  const DialogHeader({super.key, required this.title, this.hasCloseButton = true, this.onClose, this.leading});

  final String title;
  final bool hasCloseButton;
  final VoidCallback? onClose;
  final Widget? leading;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    Widget? trailing;
    if (hasCloseButton) {
      trailing = CloseButton(color: theme.colorScheme.onSurface, onPressed: onClose);
    }

    return Container(
      color: theme.colorScheme.surface,
      height: kToolbarHeight,
      child: NavigationToolbar(
        centerMiddle: true,
        middle: _ModalTitle(title: title),
        trailing: trailing,
        leading: leading,
      ),
    );
  }
}

class AppModalLayout extends StatelessWidget {
  const AppModalLayout({super.key, required this.title, required this.content, this.bottom});

  final String title;
  final Widget content;
  final Widget? bottom;

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget header = BottomSheetHeader(title: title);

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: header,
      body: content,
      bottomNavigationBar: bottom,
    );
  }
}

class AppDialogLayout extends StatelessWidget {
  final String title;
  final Widget content;

  const AppDialogLayout({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    final dialogHeader = DialogHeader(title: title);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        dialogHeader,
        Padding(
          padding: EdgeInsets.fromLTRB(Spacing.normal, Spacing.normal, Spacing.normal, Spacing.normal),
          child: content,
        ),
      ],
    );
  }
}

Future<T?> showAppModal<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool barrierDismissible = true,
  double? maxBottomHeight,
}) async {
  final maxHeight = maxBottomHeight ?? (context.height - kToolbarHeight - context.padding.top);
  final minHeight = context.padding.bottom;
  return await showModalBottomSheet(
    context: context,

    builder: (context) => PopScope(
      canPop: barrierDismissible,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight, minHeight: minHeight),
        child: builder(context),
      ),
    ),
    isDismissible: barrierDismissible,
    isScrollControlled: true,
    useSafeArea: true,
  );
}

Future<T> showAppDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool barrierDismissible = true,
}) async {
  final maxHeight = context.height - kToolbarHeight - context.padding.top;
  return await showDialog(
    context: context,
    builder: (context) => Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: Spacing.large),
      clipBehavior: Clip.hardEdge,
      child: PopScope(
        canPop: barrierDismissible,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxHeight),
          child: builder(context),
        ),
      ),
    ),
  );
}
