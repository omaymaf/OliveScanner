import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import '../../../../global/common/toast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _image;
  Future getImage(ImageSource source) async{
    try{
      final image =await ImagePicker().pickImage(source: source);
      if(image == null) return;

      // final imageTemporary = File(image.path);
      final imagePermanent = await saveFilePermanently(image.path);




      setState(() {
        this._image=imagePermanent;
      });
    } on PlatformException catch(e){
      print('Failed to pick image: $e');
    }

  }

  Future<File> saveFilePermanently( String imagePath)async{
    final directory =await getApplicationDocumentsDirectory();
    final name =basename(imagePath);
    final image= File('${directory.path}/$name');


    return File(imagePath).copy(image.path);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Olivier Scanner'),
      ),
      body: Center(
        // child: ElevatedButton(
        //  onPressed: _openCamera,
        //  child: Text('Scanner les Olives'),
        // ),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 40,),
              _image != null ?  Image.file(_image!,width: 350,height: 350,fit: BoxFit.cover,): Image.asset("assets/images/Logo.jpg",width: 350,height: 350,),
              SizedBox(height: 40,),
              CustomButtom(
                Title: 'Pick From Gallery',
                icon: Icons.image_outlined,
                onClick: ()=> getImage(ImageSource.gallery),
              ),
              CustomButtom(
                Title: 'Pick From Camera',
                icon: Icons.camera,
                onClick: ()=> getImage(ImageSource.camera),
              ),

              SizedBox(height: 40,),
              GestureDetector(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  final GoogleSignIn _googleSignIn = GoogleSignIn();
                  await _googleSignIn.signOut();
                  showToast(message: "Successfully signed out");
                  Navigator.pushNamed(context, "/login");
                },
                child: Container(
                  height: 45,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(child: Text("Sign out",style: TextStyle(color: Colors.white),),),
                ),

              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget CustomButtom({
  required String Title,
  required IconData icon,
  required VoidCallback onClick,
}) {
  return Container(
    width: 280,
    child: ElevatedButton(
      onPressed: onClick,
      child: Row(
        children: [
          Icon(icon),
          SizedBox(
            width: 20,
          ),
          Text(Title)
        ],
      ),
    ),
  );
}
