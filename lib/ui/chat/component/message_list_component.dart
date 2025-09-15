part of '../chat.dart';

class _MessageList extends StatelessWidget {
  const _MessageList({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ChatProvider>();
    return StreamBuilder<List<ChatsDocument>>(
      stream: provider.chatRepository.getMessages(
        currentUserId: provider.currentUserId,
        receiverId: provider.args.id ?? "",
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: context.colorScheme.primary));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No messages yet"));
        }

        final messages = snapshot.data!;

        return ListView.separated(
          controller: context.read<ChatProvider>().scrollController,
          itemCount: messages.length,
          reverse: true,
          itemBuilder: (context, index) {
            final msg = messages[index];
            final isMe = msg.userId == provider.currentUserId;

            return Align(
              alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.all(Spacing.medium),
                decoration: BoxDecoration(
                  color: isMe ? const Color(0xff272A35) : const Color(0xff373E4E),
                  borderRadius: BorderRadius.circular(Spacing.normal),
                ),
                child: Text(msg.chat ?? '', style: TextStyle(color: context.colorScheme.onPrimary)),
              ),
            );
          },
          separatorBuilder: (_, __) => const Gap(Spacing.medium),
        );
      },
    );
  }
}
