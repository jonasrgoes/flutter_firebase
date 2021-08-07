import 'dart:async';

import 'package:flutter_firebase/src/resources/repository.dart';
import 'package:flutter_firebase/src/utils/prefs_manager.dart';
import 'package:flutter_firebase/src/utils/validator.dart';
import 'package:flutter_firebase/src/utils/values/string_constants.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_firebase/src/blocs/bloc.dart';

class AuthenticationBloc implements Bloc {
  final _repository = Repository();
  final _email = BehaviorSubject<String>();
  final _displayName = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _isSignedIn = BehaviorSubject<bool>();

  Stream<String> get email => _email.stream.transform(_validateEmail);
  Stream<String> get displayName => _displayName.stream.transform(_validateDisplayName);
  Stream<String> get password => _password.stream.transform(_validatePassword);
  Stream<bool> get signInStatus => _isSignedIn.stream;

  // Change data
  void Function(String) get changeEmail => _email.sink.add;
  void Function(String) get changeDisplayName => _displayName.sink.add;
  void Function(String) get changePassword => _password.sink.add;
  void Function(bool) get showProgressBar => _isSignedIn.sink.add;

  final _validateEmail = StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (Validator.validateEmail(email)) {
      sink.add(email);
    } else {
      sink.addError(StringConstants.emailValidateMessage);
    }
  });

  final _validatePassword = StreamTransformer<String, String>.fromHandlers(handleData: (password, sink) {
    if (Validator.validatePassword(password)) {
      sink.add(password);
    } else {
      sink.addError(StringConstants.passwordValidateMessage);
    }
  });

  final _validateDisplayName = StreamTransformer<String, String>.fromHandlers(handleData: (displayName, sink) {
    if (displayName.length > 5) {
      sink.add(displayName);
    } else {
      sink.addError(StringConstants.displayNameValidateMessage);
    }
  });

  bool validateEmailAndPassword() {
    if (_email.valueOrNull != null &&
        _email.value.isNotEmpty &&
        _email.value.contains("@") &&
        _password.valueOrNull != null &&
        _password.value.isNotEmpty &&
        _password.value.length > 5) {
      return true;
    }
    return false;
  }

  void saveCurrentUserDisplayName(SharedPreferences prefs) {
    print("SAVED DISPLAYNAME: " + _displayName.value);
    PrefsManager prefsManager = PrefsManager();
    prefsManager.setCurrentUserDisplayName(prefs, _displayName.value);
  }

  bool validateDisplayName() {
    return _displayName.value.isNotEmpty && _displayName.value.length > 5;
  }

  // Firebase methods
  Future<int> loginUser() async {
    showProgressBar(true);
    int response = await _repository.loginWithEmailAndPassword(_email.value, _password.value);
    showProgressBar(false);
    return response;
  }

  Future<int> registerUser() async {
    showProgressBar(true);
    int response = await _repository.signUpWithEmailAndPassword(_email.value, _password.value, _displayName.value);
    showProgressBar(false);
    return response;
  }

  @override
  void dispose() async {
    await _email.drain();
    _email.close();
    await _displayName.drain();
    _displayName.close();
    await _password.drain();
    _password.close();
    await _isSignedIn.drain();
    _isSignedIn.close();
  }
}
