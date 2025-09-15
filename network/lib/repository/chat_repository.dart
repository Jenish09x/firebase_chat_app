part of '../network.dart';

class ChatRepository {
  final chatRef = FireStoreHelper.chatRef;

  Future<void> sendMessage({required ChatsDocument message}) async {
    try {
      final docId = chatRef.doc().id;
      final newMessage = message.copyWith(id: docId, createdAt: DateTime.now());

      await chatRef.doc(docId).set(newMessage);
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<ChatsDocument>> getMessages({required String currentUserId, required String receiverId}) {
    final controller = StreamController<List<ChatsDocument>>();

    List<ChatsDocument> sentMessages = [];
    List<ChatsDocument> receivedMessages = [];

    void emit() {
      final allMessages = [...sentMessages, ...receivedMessages];
      allMessages.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
      controller.add(allMessages);
    }

    final sentSub = chatRef
        .where(ChatsDocumentField.userId, isEqualTo: currentUserId)
        .where(ChatsDocumentField.receiverId, isEqualTo: receiverId)
        .orderBy(ChatsDocumentField.createdAt, descending: true)
        .snapshots()
        .listen((snap) {
          sentMessages = snap.docs.map((e) => e.data()).toList();
          emit();
        });

    final receivedSub = chatRef
        .where(ChatsDocumentField.userId, isEqualTo: receiverId)
        .where(ChatsDocumentField.receiverId, isEqualTo: currentUserId)
        .orderBy(ChatsDocumentField.createdAt, descending: true)
        .snapshots()
        .listen((snap) {
          receivedMessages = snap.docs.map((e) => e.data()).toList();
          emit();
        });

    controller.onCancel = () {
      sentSub.cancel();
      receivedSub.cancel();
    };

    return controller.stream;
  }
}
