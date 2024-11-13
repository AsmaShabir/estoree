





import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';


import '../data/network/base_api_service.dart';
import '../data/network/network_api_service.dart';
import '../model/auth_model.dart';
import '../utils/routes/routes_name.dart';

class AuthRepository{

  BaseApiService apiService =NetworkApiResponse();
  final _auth = FirebaseAuth.instance;
  final _firestore=FirebaseFirestore.instance;
  // Future<dynamic>loginApi(dynamic data) async{
  //   try{
  //     dynamic response =await apiService.getPostApiResponse(AppUrl.loginEndPoint, data);
  //     return response;
  //   }
  //   catch(e){
  //     throw e;
  //   }
  // }
  // Future<dynamic>SignUpApi(dynamic data) async{
  //   try{
  //     dynamic response =await apiService.getPostApiResponse(AppUrl.registerApiEndPoint, data);
  //     return response;
  //   }
  //   catch(e){
  //     throw e;
  //   }
  // }

  Future<UserCredential?> signUp(String email,String password,String name,context)async{
    try{
      final credentials=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final user = credentials.user;
      if(user!=null){
        await _firestore.collection('users').doc(user.uid).set({
          'uid':user.uid,
          'email':user.email,
          'name':name,
          'imageUrl':user.photoURL??'',
        });
        Navigator.pushNamed(context, routesName.home);
      }

    }
    catch(e){
      throw e;
    }

  }

  Future<UserCredential?>login(String email,String password)async{
    try{
      final credentials= await _auth.signInWithEmailAndPassword(email: email, password: password);

      return credentials;
    }
    catch(e){
      throw e;
    }
  }

  Future<void>signOut()async{
    await _auth.signOut();

  }


  Future<void> saveUserToFirestore({uid,name,email,imageUrl,Activity,goals,healthMetrics,progress,context}) async {
    try {
      // Get Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Reference to the user's document
      DocumentReference userDoc =
      firestore.collection('users').doc(uid);

      // Check if the user document already exists
      final docSnapshot = await userDoc.get();

      // If the user document does not exist, create a new one
      if (!docSnapshot.exists) {
        await userDoc.set({
          'name': name,
          'email': email,
          'imageUrl': imageUrl,
          'uid': uid,
          'signInMethod': 'google',
          'timestamp': FieldValue.serverTimestamp(),

        });

        print('User credentials saved to Firestore');
      }
    } catch (e) {
      print('Error saving user to Firestore: $e');
    }
  }

}