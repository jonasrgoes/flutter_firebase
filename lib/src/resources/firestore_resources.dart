import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreResources {
  /// DEPRECATED: Version 0.14.0 - Class Firestore is now deprecated. Use FirebaseFirestore instead.
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot> userFinanceDoc(String userUID) =>
      _firestore.collection("userFinance").doc(userUID).snapshots();

  /// DEPRECATED: Version 0.14.0 - Calling document() is deprecated in favor of doc()
  /// DEPRECATED: Version 0.14.0 - setData() has been deprecated in favor of set()
  Future<void> setUserBudget(String userUID, double budget) => _firestore
      .collection("userFinance")
      .doc(userUID)
      .set({'budget': budget}, SetOptions(merge: true));

  Future<void> addNewExpense(String userUID, double expenseValue) => _firestore
      .collection("userFinance")
      .doc(userUID)
      .collection("expenses")
      .doc()
      .set({'value': expenseValue, 'timestamp': FieldValue.serverTimestamp()});

  Stream<QuerySnapshot> expensesList(String userUID) => _firestore
      .collection("userFinance")
      .doc(userUID)
      .collection("expenses")
      .orderBy('timestamp', descending: true)
      .snapshots();

  Stream<QuerySnapshot> lastExpense(String userUID) => _firestore
      .collection("userFinance")
      .doc(userUID)
      .collection("expenses")
      .orderBy('timestamp', descending: true)
      .limit(1)
      .snapshots();
}
