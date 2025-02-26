import 'package:basigo_dirt/modules/auth/data/models/user.model.dart';
import 'package:basigo_dirt/modules/auth/domain/entities/user.entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;

abstract class RemoteAuthDataSource {
  Future<UserCredential> login({
    required String email,
    required String password,
  });
  Future<UserModel?> fetchUserById(String id);
  Future<void> logout();
  User? get currentUser;
}

class RemoteAuthDTSImpl implements RemoteAuthDataSource {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<UserCredential> login({
    required String email,
    required String password,
  }) {
    return auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<UserModel?> fetchUserById(String id) async {
    final document = await firestore
        .collection('users')
        .withConverter(
          fromFirestore: (snap, _) => UserModel.fromMap(snap.data() ?? {}),
          toFirestore: (data, _) => data.toMap,
        )
        .doc(id)
        .get();

    return document.data();
  }

  @override
  User? get currentUser {
    if (auth.currentUser == null) return null;
    return UserModel.fromFirebase(auth.currentUser!);
  }

  @override
  Future<void> logout() {
    return auth.signOut();
  }
}
