part of '../network.dart';

class UserRepository {
  final userRef = FireStoreHelper.userRef;

  Future<void> insertUser({required UserDocument userDocument}) async {
    try {
      final snapshot = await userRef.where(UserDocumentField.email, isEqualTo: userDocument.email).limit(1).get();

      if (snapshot.docs.isNotEmpty) {
        throw DefaultException(error: "User with this email already exists!");
      }

      final docId = userRef.doc(userDocument.id).id;
      final newUser = userDocument.copyWith(id: docId);

      await userRef.doc(docId).set(newUser);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserDocument>> getAllUsers() async {
    try {
      final snapshot = await userRef.orderBy(UserDocumentField.createdAt, descending: true).get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      rethrow;
    }
  }
}
