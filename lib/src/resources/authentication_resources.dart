import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AuthenticationResources {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// BREAKING: Version 0.18.0 - The FirebaseUser class has been renamed to User
  /// DEPRECATED: Version 0.18.0 - onAuthStateChanged has been deprecated in favor of authStateChanges()
  Stream<User?> get onAuthStateChange => _firebaseAuth.authStateChanges();

  /// BREAKING: Version 0.18.0 - Accessing the current user via currentUser() is now synchronous via the currentUser getter.
  Future<String> getUserUID() async {
    final User? user = _firebaseAuth.currentUser;
    return user!.uid;
  }

  Future<int> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      return 1;
    } on PlatformException catch (e) {
      print("Platform Exception: Authentication: " + e.toString());
      return -1;
    } catch (e) {
      print("Exception: Error: " + e.toString());
      return -2;
    }
  }

  Future<int> signUpWithEmailAndPassword(String email, String password, String displayName) async {
    try {
      /// BREAKING: Version 0.18.0 - The AuthResult class has been renamed to UserCredential.
      UserCredential authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      await setUserDisplayName(authResult.user, displayName);
      return 1;
    } on PlatformException catch (e) {
      print("Platform Exception: Authentication: " + e.toString());
      return -1;
    } catch (e) {
      print("Exception: Authentication: " + e.toString());

      return -2;
    }
  }

  Future<void> setUserDisplayName(User? user, String displayName) async {
    /// BREAKING: Version 0.18.0 - Removed the UpdateUserInfo class when using updateProfile in favor of named arguments.
    /// Use updateDisplayName
    await _firebaseAuth.currentUser!.updateDisplayName(displayName);
  }

  Future<void> get signOut async {
    _firebaseAuth.signOut();
//    _googleSignIn.signOut();
  }
}
