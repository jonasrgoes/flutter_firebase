import 'package:flutter/material.dart';

import 'user_finance_bloc.dart';

class UserFinanceBlocProvider extends InheritedWidget {
  final bloc = UserFinanceBloc();

  UserFinanceBlocProvider({Key? key, required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static UserFinanceBloc of(BuildContext context) {
    return (context
            .dependOnInheritedWidgetOfExactType<UserFinanceBlocProvider>())!
        .bloc;
  }
}
