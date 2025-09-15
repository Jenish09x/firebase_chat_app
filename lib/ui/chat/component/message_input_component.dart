part of '../chat.dart';

class _MessageInput extends StatefulWidget {
  const _MessageInput({super.key});

  @override
  State<_MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<_MessageInput> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<ChatProvider>();
    return TextField(
      controller: provider.controller,
      autofocus: true,
      cursorColor: context.colorScheme.primary,
      style: context.textTheme.labelMedium?.copyWith(color: context.colorScheme.primary.withValues(alpha: .7)),
      decoration: InputDecoration(
        hintText: "Write",
        hintStyle: context.textTheme.labelMedium?.copyWith(color: context.colorScheme.primary.withValues(alpha: .5)),
        suffixIcon: CommonButton.cupertino(
          onTap: () => provider.sendMessage(),
          child: Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(Spacing.medium), color: Color(0xff565E70)),
            child: Icon(CupertinoIcons.chat_bubble_fill, color: context.colorScheme.onPrimary, size: Spacing.large),
          ),
        ),
        filled: true,
        fillColor: Color(0xFF000000).withValues(alpha: 0.20),
        border: InputBorder.none,
      ),
    );
  }
}
