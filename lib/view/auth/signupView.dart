
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../utils/routes/routes_name.dart';
import '../../utils/utils.dart';
import '../../view_model/auth_view_model.dart';
import '../home_screen.dart';
import 'login_view.dart';


class signup extends StatefulWidget {

  signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {

  final nameController= TextEditingController();

  final emailController= TextEditingController();

  final passwordController= TextEditingController();

  bool _isObscured= true;



  // CreateAccount(context)async{
  //   try{
  //     UserCredential? user = await
  //     FirebaseAuth.instance.createUserWithEmailAndPassword
  //       (email: emailController.text.toString(),
  //         password: passwordController.text.toString());
  //
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar
  //       (content: Text('Your account has been created'),
  //       backgroundColor: Colors.green,)
  //     );
  //
  //     Navigator.push(context, MaterialPageRoute(builder: (context)=>homeScreen()));
  //
  //
  //   }
  //   on FirebaseAuthException catch(e){
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar
  //       (content: Text('Something Wrong!'),
  //       backgroundColor: Colors.red,));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Sign up',
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

              Text('Welcome!',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),),

              Text('To keep connected with us please signup with your\npersonal info',
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
                  child: TextField(controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
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
                    obscureText: _isObscured,
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: InputBorder.none,
                      suffixIcon: IconButton
                        (onPressed: (){
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                          icon: Icon(_isObscured? Icons.visibility_off : Icons.visibility,
                          )),
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
                    final name=nameController.text.trim().toString();

                    final password=passwordController.text.trim().toString();
                    final user= await authViewModel.signup(email, password,name,context);

                   // Navigator.pushNamed(context, routesName.home);
                    //Utils.flushBarErrorMessage('Account created!', context);

                  },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: Colors.green,


                    child: Text('Sign up',
                      style: TextStyle(
                          color: Colors.white
                      ),),
                  ),
                ),
              ),

              SizedBox(height: 100,),

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
                    child: MaterialButton(onPressed: (){

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
                      Text('already have an account?'),
                      SizedBox(width: 5,),
                      InkWell(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>loginView()));
                        },
                        child: Text('Login',
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
