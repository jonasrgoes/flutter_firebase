import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/src/utils/prefs_manager.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_firebase/src/resources/repository.dart';
import 'package:flutter_firebase/src/utils/validator.dart';
import 'package:flutter_firebase/src/utils/values/string_constants.dart';
import 'package:flutter_firebase/src/blocs/bloc.dart';

class UserFinanceBloc implements Bloc {
  final _repository = Repository();
  final _financeValue = BehaviorSubject<String>();

  Stream<String> get financeValue => _financeValue.stream.transform(_validateFinanceValue);

  Function(String) get changeFinanceValue => _financeValue.sink.add;

  final _validateFinanceValue = StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    if (Validator.validateFinanceValue(value)) {
      sink.add(value);
    } else {
      sink.addError(StringConstants.financeValueValidateMessage);
    }
  });

  bool validateFinance() {
    return _financeValue.hasValue && _financeValue.value.isNotEmpty;
  }

  Stream<User?> get currentUser => _repository.onAuthStateChange;
  Future<String> getUserUID() => _repository.getUserUID();
  Future<void> signOut() => _repository.signOut();

  String getCurrentUserDisplayNameFromPrefs(SharedPreferences prefs) {
    PrefsManager prefsMang = PrefsManager();
    String? displayName = prefsMang.getCurrentUserDisplayName(prefs);
    print("CURRENT DISPLAYNAME: " + displayName!);
    return displayName;
  }

  Stream<DocumentSnapshot> userFinanceDoc(String? userUID) => _repository.userFinanceDoc(userUID!);

  Future<void> setUserBudget() async {
    String userUID = await getUserUID();

    return _repository.setUserBudget(userUID, double.tryParse(_financeValue.value));
  }

  Stream<QuerySnapshot> expenseList(String? userUID) => _repository.expensesList(userUID!);
  Stream<QuerySnapshot> lastExpense(String? userUID) => _repository.lastExpense(userUID!);

  Future<void> addNewExpense() async {
    String userUID = await getUserUID();

    print('userUID $userUID');
    print('Value: ${double.tryParse(_financeValue.value)}');

    await _repository.addNewExpense(userUID, double.tryParse(_financeValue.value));

    return _repository.updateTotal(userUID);
  }

  @override
  void dispose() async {
    await _financeValue.drain();
    _financeValue.close();
  }
}
