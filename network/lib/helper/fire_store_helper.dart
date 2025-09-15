part of '../network.dart';

class FireStoreHelper {
  static FirebaseFirestore fireStore = FirebaseFirestore.instance;
  static FirebaseAuth auth = FirebaseAuth.instance;

  static const userCollection = "users";
  static const chatsCollection = "chats";

  static final userCollectionRef = fireStore.collection(userCollection);
  static final chatsCollectionRef = fireStore.collection(chatsCollection);

  static final userRef = userCollectionRef.withConverter(
    fromFirestore: (snapshot, options) => UserDocument.fromJson(snapshot.data()!).copyWith(id: snapshot.id),
    toFirestore: (value, options) => value.toJson(),
  );

  static final chatRef = chatsCollectionRef.withConverter(
    fromFirestore: (snapshot, options) => ChatsDocument.fromJson(snapshot.data()!).copyWith(id: snapshot.id),
    toFirestore: (value, options) => value.toJson(),
  );
}
