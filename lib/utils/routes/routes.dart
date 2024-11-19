
import 'package:estoree/utils/routes/routes_name.dart';
import 'package:estoree/view/NavigationScreens/homeScreen.dart';
import 'package:flutter/material.dart';
import '../../view/auth/login_view.dart';
import '../../view/auth/signupView.dart';

import '../../view/splash_screen.dart';

class routes{
  static Route<dynamic>generateRoute(RouteSettings settings){

    switch(settings.name){
      case routesName.splash:
        return MaterialPageRoute(builder: (BuildContext context)=>SplashView());
      case routesName.signUp:
        return MaterialPageRoute(builder: (BuildContext context)=>signup());
      case routesName.login:
        return MaterialPageRoute(builder: (BuildContext context)=>loginView());
      case routesName.home:
        return MaterialPageRoute(builder: (BuildContext context)=>homeScreen());
    // case routesName.shimmerLoading:
    //   return MaterialPageRoute(builder: (BuildContext context)=>dataLoading());
    // case routesName.sentryproj:
    //   return MaterialPageRoute(builder: (BuildContext context)=>SentryView());
    // case routesName.dioApi:
    //   return MaterialPageRoute(builder: (BuildContext context)=>DioApi());
    // case routesName.location:
    //   return MaterialPageRoute(builder: (BuildContext context)=>locationView());
    // case routesName.list:
    //   return MaterialPageRoute(builder: (BuildContext context)=>ListList());
    //
    // case routesName.view:
    //   final arg=settings.arguments as thisViewModel;
    //   return MaterialPageRoute(builder: (BuildContext context)=>Thisview(viewModel:arg));
    // case routesName.login:
    //   return MaterialPageRoute(builder: (BuildContext context)=>loginView());
    // case routesName.signup:
    //   return MaterialPageRoute(builder: (BuildContext context)=>signUpView());
      default:
        return MaterialPageRoute(builder: (_){
          return Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }


  }
}