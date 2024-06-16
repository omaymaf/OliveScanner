


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_olivier/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:project_olivier/features/user_auth/presentation/pages/login_page.dart';
import 'package:project_olivier/features/user_auth/presentation/widgets/form_container_widget.dart';
import 'package:project_olivier/global/common/toast.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final FirebaseAuthServices _auth =FirebaseAuthServices();

  TextEditingController _usernamecontroller=TextEditingController();
  TextEditingController _emailcontroller=TextEditingController();
  TextEditingController _passwordcontroller=TextEditingController();
  bool isSigningUp=false;

  @override
  void dispose() {
    _usernamecontroller.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Sign Up",style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold),),
              SizedBox(
                height: 30,
              ),
              FormContainerWidget(
                controller: _usernamecontroller,
                hintText: "UserName",
                isPasswordField: false,
              ),
              SizedBox(height: 10,),
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
              SizedBox(height: 30,),
              GestureDetector(
                onTap: _signUp,
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: isSigningUp? CircularProgressIndicator(color: Colors.white,): Text("Sign Up",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )) ,

                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account ?"),
                  SizedBox(width: 5,),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                            (route) => false,
                      );
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }


  void _signUp() async{
    setState(() {
      isSigningUp=true;
    });
    String username= _usernamecontroller.text;
    String email = _emailcontroller.text;
    String password =_passwordcontroller.text;

    User? user =await _auth.signUpWithEmailAndPassword(email, password);

    setState(() {
      isSigningUp=false;
    });
    if(user != null){
      showToast(message: "User is Successfuly created");
      Navigator.pushNamed(context, "/home");
    }else{
      showToast(message:"Some Error happend");
    }
  }
}
