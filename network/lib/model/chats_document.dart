part of 'model.dart';

abstract interface class ChatsDocumentField {
  static const String id = 'id';
  static const String userId = 'userId';
  static const String receiverId = 'receiverId';
  static const String chat = 'chat';
  static const String createdAt = 'created_at';
}

class ChatsDocument extends Equatable {
  final String? id;
  final String? userId;
  final String? receiverId;
  final String? chat;
  final DateTime? createdAt;

  const ChatsDocument({this.id, this.userId, this.receiverId, this.chat, this.createdAt});

  factory ChatsDocument.fromJson(Map<String, dynamic> json) {
    return ChatsDocument(
      id: json[ChatsDocumentField.id],
      userId: json[ChatsDocumentField.userId],
      receiverId: json[ChatsDocumentField.receiverId],
      chat: json[ChatsDocumentField.chat],
      createdAt: json[ChatsDocumentField.createdAt] != null
          ? (json[ChatsDocumentField.createdAt] is Timestamp
                ? (json[ChatsDocumentField.createdAt] as Timestamp).toDate()
                : DateTime.tryParse(json[ChatsDocumentField.createdAt].toString()))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ChatsDocumentField.id: id,
      ChatsDocumentField.userId: userId,
      ChatsDocumentField.receiverId: receiverId,
      ChatsDocumentField.chat: chat,
      ChatsDocumentField.createdAt: createdAt != null ? Timestamp.fromDate(createdAt!) : null,
    };
  }

  ChatsDocument copyWith({String? id, String? userId, String? receiverId, String? chat, DateTime? createdAt}) {
    return ChatsDocument(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      receiverId: receiverId ?? this.receiverId,
      chat: chat ?? this.chat,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, userId, receiverId, chat, createdAt];
}
