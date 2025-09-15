part of 'chat.dart';

final class ChatProvider extends BaseProvider {
  final UserDocument args;
  final ChatRepository chatRepository;
  final LoadingDialogHandler loadingDialogHandler;

  ChatProvider({
    required super.context,
    required this.args,
    required this.chatRepository,
    required this.loadingDialogHandler,
  });

  final ScrollController scrollController = ScrollController();
  final TextEditingController controller = TextEditingController();
  String currentUserId = FireStoreHelper.auth.currentUser!.uid;
  String? receiverId;
  bool isLoading = false;

  List<ChatsDocument> _messages = [];

  List<ChatsDocument> get messages => _messages;

  StreamSubscription? _chatSubscription;

  @override
  void initState() {
    super.initState();
    initChat();
  }

  Future<void> initChat() async {
    receiverId = args.id ?? '';
    _chatSubscription?.cancel();

    _chatSubscription = await processApi(
      request: () async =>
          chatRepository.getMessages(currentUserId: currentUserId, receiverId: receiverId ?? '').listen((data) {
            _messages = data;
          }),
      onLoading: (loading) {
        isLoading = loading;
        notifyListeners();
      },
    );
  }

  Future<void> sendMessage() async {
    if (controller.text.trim().isEmpty) return;

    final message = ChatsDocument(userId: currentUserId, receiverId: receiverId, chat: controller.text.trim());
    await processApi(request: () => chatRepository.sendMessage(message: message));
    controller.clear();
    scrollController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    notifyListeners();
  }

  @override
  void dispose() {
    _chatSubscription?.cancel();
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
