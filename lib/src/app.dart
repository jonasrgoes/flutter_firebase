import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/src/blocs/authentication/authentication_bloc_provider.dart';
import 'package:flutter_firebase/src/root_page.dart';
import 'package:flutter_firebase/src/ui/authentication/login_page.dart';
import 'package:flutter_firebase/src/ui/home/finance_history_page.dart';
import 'package:flutter_firebase/src/ui/home/home_page.dart';
import 'package:flutter_firebase/src/utils/values/colors.dart';

import 'package:flutter_firebase/src/blocs/user_finance/user_finance_bloc_provider.dart';

class FlutterFirebase extends StatelessWidget {
  const FlutterFirebase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AuthenticationBlocProvider(
      child: UserFinanceBlocProvider(
        child: MaterialApp(
          title: 'FLutter Firebase',
          theme: theme.copyWith(
            colorScheme: theme.colorScheme.copyWith(primary: ColorConstant.colorMainPurple),
          ),
          //fontFamily: 'SF Pro Display'
          initialRoute: RootPage.routeName,
          routes: <String, Widget Function(BuildContext)>{
            RootPage.routeName: (BuildContext context) => const RootPage(),
            LoginPage.routeName: (BuildContext context) => const LoginPage(),
            HomePage.routeName: (BuildContext context) => const HomePage(),
            FinanceHistoryPage.routeName: (BuildContext context) => const FinanceHistoryPage()
          },
        ),
      ),
    );
  }
}
