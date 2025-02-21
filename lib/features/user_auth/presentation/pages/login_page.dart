

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_olivier/features/user_auth/presentation/pages/sign_up_page.dart';
import 'package:project_olivier/features/user_auth/presentation/widgets/form_container_widget.dart';
import 'package:project_olivier/global/common/toast.dart';

import '../../firebase_auth_implementation/firebase_auth_services.dart';
import 'forgot_pwd_page.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isSigning =false;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseAuthServices _auth =FirebaseAuthServices();
  TextEditingController _emailcontroller=TextEditingController();
  TextEditingController _passwordcontroller=TextEditingController();

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login",style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold),),
              SizedBox(
                height: 30,
              ),
              FormContainerWidget(
                controller: _emailcontroller,
                hintText: "Email",
                isPasswordField: false,
              ),
              SizedBox(height: 10,),
              FormContainerWidget(
                controller: _passwordcontroller,
                hintText: "Password",
                isPasswordField: true,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap:(){
                        Navigator.push(context,MaterialPageRoute(builder: (context){
                          return ForgotPasswordPage();
                        },
                        ),
                        );
                      },
                      child: Text("Forgot Password?",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),


                  ],
                ),
              ),
              SizedBox(height: 10,),

              GestureDetector(
                onTap:_signIn,
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child:_isSigning? CircularProgressIndicator(color: Colors.white,):
                      Text("Login",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )) ,

                ),
              ),
              SizedBox(height: 10,),
              GestureDetector(
                onTap:(){
                  _signInWithGoogle();
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.google,color: Colors.white,),
                          SizedBox(width: 5,),
                          Text("Sign In With Google",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )) ,

                ),
              ),
              SizedBox(
                height: 20,
              ),
              //test
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account ?"),
                  SizedBox(width: 5,),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                            (route) => false,
                      );
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _signIn() async{
    setState(() {
      _isSigning=true;
    });
    String email = _emailcontroller.text;
    String password =_passwordcontroller.text;

    User? user =await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      _isSigning=false;
    });

    if(user != null){
      showToast(message: "User is Successfuly signedIn");
      Navigator.pushNamed(context, "/home");
    }else{
      showToast(message: "Some Error occured");
    }
  }

  _signInWithGoogle() async {
    if (kIsWeb) {
      // Connexion avec pop-up pour le web
      try {
        UserCredential userCredential = await _firebaseAuth.signInWithPopup(GoogleAuthProvider());
        if (userCredential.user != null) {
          print("Firebase sign-in successful");
          Navigator.pushNamed(context, "/home");
        } else {
          print("Couldn't sign in with Firebase");
          showToast(message: "Couldn't sign in. Please try again.");
        }
      } catch (e) {
        print("Error signing in with Google: $e");
        showToast(message: "Couldn't sign in. Error: $e");
      }
    } else {
      // Connexion pour mobile
      try {
        final GoogleSignIn _googleSignIn = GoogleSignIn();
        final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

        if (googleSignInAccount != null) {
          final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

          final AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken,
          );

          UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
          if (userCredential.user != null) {
            print("Firebase sign-in successful");
            Navigator.pushNamed(context, "/home");
          } else {
            print("Couldn't sign in with Firebase");
            showToast(message: "Couldn't sign in. Please try again.");
          }
        } else {
          print("Google sign-in was canceled");
          showToast(message: "Google sign-in was canceled.");
        }
      } catch (e) {
        print("Error signing in with Google: $e");
        showToast(message: "Couldn't sign in. Error: $e");
      }
    }
  }




}
