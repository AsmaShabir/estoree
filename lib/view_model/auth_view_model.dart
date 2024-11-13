




import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../repo/auth_repo.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';

class AuthViewModel with ChangeNotifier{
  final repo= AuthRepository();
  final _auth = FirebaseAuth.instance;
  final _firestore=FirebaseFirestore.instance;
  User? _user;
  String? name;
  String? imageUrl="";
  String email='';
  List<dynamic>? Activity=[];
  List<dynamic>? goals=[];
  List<dynamic>? healthMetrics=[];
  List<dynamic>? progress=[];

  User? get user =>_user;
  AuthViewModel(){
    _auth.authStateChanges().listen((User? user){
      _user=user;
      notifyListeners();
    });

  }
  Future<void> signup(String email, String password, String name, BuildContext context) async {
    try {
      UserCredential? user = await repo.signUp(email, password, name,context);

      if (user == null) {
        Utils.snackBar('Failed to sign up. Please try again.', context);
      } else {
       // await repo.saveUserToFirestore();
        //Navigator.pushNamed(context, routesName.home);
        Utils.snackBar('Account created successfully', context);

        // Log statement to check if this point is reached
        print("Navigating to home screen...");

        // Navigate to the next screen
        // Ensure routesName.home is correct
      }
    } catch (e) {
      Utils.snackBar('An error occurred: $e', context);
    }
  }



  Future <void> login(emaill,password,context) async{
    UserCredential? user=  await repo.login(emaill, password);
    if(user==null){
      Utils.snackBar('fill the input fields', context);
    }
    else{
      await fetchData();
      Navigator.pushNamed(context, routesName.home);

    }
  }

  fetchData()async{
    var data= await fetchDatafromFirebase();
    name=data['name'];
    imageUrl=data['imageUrl'];
    email=data['email'];


    notifyListeners();
    print(name.toString());
  }

  fetchDatafromFirebase()async{
    try{
      var fetchedData= await FirebaseFirestore.instance.collection("users").doc(_auth.currentUser!.uid).get();
      print(fetchedData.toString());
      return fetchedData;
    }
    catch(e){
      log("User Not Loggedin");
    }
  }



}
