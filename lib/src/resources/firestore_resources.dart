import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/src/models/expense_model.dart';

class FirestoreResources {
  /// DEPRECATED: Version 0.14.0 - Class Firestore is now deprecated. Use FirebaseFirestore instead.
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot> userFinanceDoc(String userUID) =>
      _firestore.collection("userFinance").doc(userUID).snapshots();

  /// DEPRECATED: Version 0.14.0 - Calling document() is deprecated in favor of doc()
  /// DEPRECATED: Version 0.14.0 - setData() has been deprecated in favor of set()
  Future<void> setUserBudget(String userUID, double budget) =>
      _firestore.collection("userFinance").doc(userUID).set({'budget': budget}, SetOptions(merge: true));

  Future<void> addNewExpense(String userUID, double expenseValue) => _firestore
      .collection("userFinance")
      .doc(userUID)
      .collection("expenses")
      .doc()
      .set({'value': expenseValue, 'timestamp': FieldValue.serverTimestamp()});

  Future<void> updateTotal(String userUID) async {
    print('updateTotal');

    double total = .0;

    Future<QuerySnapshot<Map<String, dynamic>>> docs = _firestore
        .collection("userFinance")
        .doc(userUID)
        .collection("expenses")
        .orderBy('timestamp', descending: true)
        .get();

    await docs.then((snap) {
      print('snap.docs.length: ${snap.docs.length}');
      for (var doc in snap.docs) {
        print('${doc.get('value')}');
        total += double.parse(doc.get('value').toString());
      }
    });

    _firestore.collection("userFinance").doc(userUID).set({'totalSpent': total}, SetOptions(merge: true));

    print('updateTotal final: ${total.toString()}');
  }

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
