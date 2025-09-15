part of 'chat.dart';

class ChatScreen extends StatelessWidget {
  static const String routeName = '/chat';

  static Widget builder(BuildContext context) {
    final args = context.args;
    return ChangeNotifierProvider(
      create: (context) => ChatProvider(
        context: context,
        args: args,
        chatRepository: ChatRepository(),
        loadingDialogHandler: LoadingDialogHandler(context: context),
      ),
      builder: (context, child) => ChatScreen(),
    );
  }

  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ChatProvider>();
    return Scaffold(
      appBar: AppBar(title: Text("${provider.args.name}")),
      body: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select<ChatProvider, bool>((value) => value.isLoading);

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Padding(
      padding: EdgeInsets.all(Spacing.normal),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(child: _MessageList()),
            Gap(Spacing.normal),
            _MessageInput(),
          ],
        ),
      ),
    );
  }
}
