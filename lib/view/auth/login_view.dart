
import 'package:estoree/view/auth/signupView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/routes/routes_name.dart';
import '../../utils/utils.dart';
import '../../view_model/auth_view_model.dart';
import '../../view_model/services/auth_services.dart';
import '../home_screen.dart';


class loginView extends StatefulWidget {


  loginView({super.key});

  @override
  State<loginView> createState() => _loginViewState();
}

class _loginViewState extends State<loginView> {
  final AuthService authService = AuthService();

  final emailController= TextEditingController();

  final passwordController= TextEditingController();

  bool _isObsecured= true;


  // loginToAccount()async{
  //   try{
  //     await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: emailController.text.toString(),
  //         password: passwordController.text.toString());
  //
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar
  //       (content: Text('Successfully logged in!'),
  //       backgroundColor: Colors.green,));
  //
  //     Navigator.push(context, MaterialPageRoute(builder: (context)=>homeScreen()));
  //
  //   }on FirebaseAuthException catch(e){
  //     ScaffoldMessenger.of(context).showSnackBar
  //       (SnackBar(content: Text('Something Wrong!'),
  //       backgroundColor: Colors.red,));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Log in',
          style: TextStyle(
            color: Colors.white,
          ),),
      ),
      body:
      Padding(padding: EdgeInsets.only(
          left: 15
      ),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),

              Text('Welcome Back!',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),),

              Text('To keep connected with us please login with your\npersonal info',
                style: TextStyle(
                    color: Colors.grey
                ),),

              SizedBox(height: 60,),

              Center(
                child: Container(padding: EdgeInsets.only(
                    left: 20
                ),
                  width: 370,height: 60,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextField(controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      border: InputBorder.none,

                    ),
                  ),
                ),
              ),

              SizedBox(height: 30,),

              Center(
                child: Container(padding: EdgeInsets.only(
                    left: 20
                ),
                  width: 370,height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade300
                  ),
                  child: TextField(
                    obscureText: _isObsecured,
                    controller: passwordController,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        border: InputBorder.none,
                        suffixIcon: IconButton(onPressed: (){
                          setState(() {
                            _isObsecured = !_isObsecured;
                          });
                        }, icon: Icon(_isObsecured? Icons.visibility_off: Icons.visibility))
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30,),

              // Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //   Row(
              //     children: [
              //       Icon(Icons.check_box_outline_blank),
              //       Text('Remember me?')
              //     ],
              //   ),
              //   InkWell(
              //     child: Text('Forgot Password?',
              //     style: TextStyle(
              //       color: Colors.green,
              //     ),),
              //   )
              // ],),
              //
              // SizedBox(height: 20,),

              Center(
                child: Container(width: 370,height: 60,
                  child: MaterialButton(onPressed: ()async{
                    final email=emailController.text.trim().toString();
                    final password=passwordController.text.trim().toString();
                    final user= await authViewModel.login(email, password,context);

                    Utils.snackBar('logged in successfully', context);
                    Navigator.pushNamed(context, routesName.home);
                  },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: Colors.green,


                    child: Text('Log in',
                      style: TextStyle(
                          color: Colors.white
                      ),),
                  ),
                ),
              ),

              SizedBox(height: 50,),

              Center(child:
              Text('Or continue with',
                style: TextStyle(
                    color: Colors.grey
                ),),),

              SizedBox(height: 20,),
              Center(
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade300,
                      border: Border.all(
                        width: 1.0,
                        color: Colors.grey,
                      ),

                    ),
                    width: 370,height: 60,
                    child: MaterialButton(onPressed: ()async{
                      await authService.handleGoogleButtonClick(context);
                      await  authViewModel.fetchData();
                      // Navigate to home screen if sign-in is successful
                      //Navigator.pushNamed(context, routesName.home);
                    },
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(height: 30,width: 30,

                              child: Image.network
                                ('https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/768px-Google_%22G%22_logo.svg.png',
                                fit: BoxFit.fill,)),

                          SizedBox(width: 10,),

                          Text('Sign in with Google',
                            style: TextStyle(
                                fontSize: 15
                            ),)

                        ],
                      ),)
                ),
              ),
              SizedBox(height: 20,),

              Container(
                child: Center(
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account?'),
                      SizedBox(width: 5,),
                      InkWell(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>signup()));
                        },
                        child: Text('Sign up',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 15
                          ),),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
