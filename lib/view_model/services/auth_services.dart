import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../repo/auth_repo.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/utils.dart';

class AuthService {
  final repo =AuthRepository();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Stream<User?> get authStateChanges => _auth.authStateChanges();

// Google Sign-in method
  Future<UserCredential?> signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com'); // Check for internet connection

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // User canceled the sign-in
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase
      UserCredential googleCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      return googleCredential;
    } catch (e) {
      log('Error in Google sign-in: $e');
      return null;
    }
  }

// Handle Google sign-in button click
  Future<void> handleGoogleButtonClick(BuildContext context) async {
    try {
      // Sign in with Google
      UserCredential? userCred = await signInWithGoogle();
      if (userCred == null) {
        Utils.snackBar("Google sign-in was canceled", context);
        return;
      }

      // Check if user already exists in Firestore
      final userDoc = await FirebaseFirestore.instance.collection("users").doc(userCred.user!.uid).get();
      if (!userDoc.exists) {
        // If user does not exist, save to Firestore
        await repo.saveUserToFirestore(
          uid: userCred.user!.uid,
          email: userCred.user!.email ?? "No Email",
          name: userCred.user!.displayName ?? "No Name",
          imageUrl: userCred.user!.photoURL ?? "",
          context: context,
        );
        Utils.snackBar("Account created successfully!", context);
      } else {
        Utils.snackBar("Welcome back!", context);
      }

      // Navigate to home screen after successful sign-in or account creation
      Navigator.pushNamed(context, routesName.home);
    } catch (e) {
      log("Failed to create Account: $e");
      Utils.snackBar("An error occurred during Google sign-in. Please try again.", context);
    }
  }


  // Sign out from Google
  Future<void> signOutGoogle(context) async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamed(context, routesName.login);
  }

// signOut(context)async{
//   Utils.flushBarErrorMessage("Logging Out...",context);
//   try{
//     await FirebaseAuth.instance.signOut();
//     Navigator.popUntil(context, (route) => route.isFirst);
//     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>loginView()));
//     log("Logged out log");
//   }
//   catch(e){
//     // VxToast.show(context, msg: e.toString());
//   }
// }
}