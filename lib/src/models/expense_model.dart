import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenseModel {
  String id;
  double expenseValue;
  Timestamp timestamp;

  ExpenseModel(
      {required this.id, required this.expenseValue, required this.timestamp});

  factory ExpenseModel.fromDocument(DocumentSnapshot document) {
    /// DEPRECATED: Version 0.14.0 - documentID has been deprecated in favor of id.
    return ExpenseModel(
        id: document.id,
        expenseValue: document['value'],
        timestamp: document['timestamp']);
  }
}
