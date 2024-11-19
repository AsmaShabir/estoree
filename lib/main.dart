


import 'package:estoree/utils/routes/routes.dart';
import 'package:estoree/utils/routes/routes_name.dart';
import 'package:estoree/view/auth/signupView.dart';
import 'package:estoree/view/bottomNavigationBar/bottomNavigationBar.dart';
import 'package:estoree/view_model/auth_view_model.dart';
import 'package:estoree/view_model/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();
    return MultiProvider(
      providers: [

        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demoo',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:StreamBuilder<User?>(
          stream: authService.authStateChanges,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return bottomNavigationBar();
            } else {
              return  signup();
            }
          },
        ),
        initialRoute: routesName.splash,
        onGenerateRoute: routes.generateRoute,
      ),
    );
  }
}

