part of '../network.dart';

class AuthRepository {
  final auth = FireStoreHelper.auth;
  final userRef = FireStoreHelper.userRef;
  final userRepository = UserRepository();

  Future<bool> signUp({required UserDocument userDocument}) async {
    try {
      final result = await auth.createUserWithEmailAndPassword(
        email: userDocument.email ?? '',
        password: userDocument.password ?? '',
      );

      if (result.user != null) {
        userDocument = userDocument.copyWith(id: result.user!.uid);
        userRepository.insertUser(userDocument: userDocument);
        return true;
      }
    } catch (e) {
      rethrow;
    }
    return false;
  }

  Future<UserDocument> signIn({required UserDocument userDocument}) async {
    try {
      final cred = await auth.signInWithEmailAndPassword(
        email: userDocument.email ?? '',
        password: userDocument.password ?? '',
      );

      final user = cred.user ?? (throw DefaultException(error: 'Sign-in failed. User not found.'));

      final snap = await userRef.where(UserDocumentField.email, isEqualTo: user.email).limit(1).get();

      if (snap.docs.isEmpty) {
        throw DefaultException(error: 'User data not found.');
      }

      return snap.docs.first.data();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
