import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/src/resources/repository.dart';
import 'package:flutter_firebase/src/ui/authentication/login_page.dart';
import 'package:flutter_firebase/src/ui/home/home_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  static const String routeName = 'root_page';

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final Repository _repository = Repository();

  /// BREAKING: Version 0.18.0 - The FirebaseUser class has been renamed to User
  late Stream<User?> _currentUser;

  @override
  void initState() {
    _currentUser = _repository.onAuthStateChange;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _currentUser,
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        return snapshot.hasData ? const HomePage() : const LoginPage();
      },
    );
  }
}
