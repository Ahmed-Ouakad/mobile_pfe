import 'dart:io';

import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profil_frag extends StatefulWidget{
  @override
  _Profil_fragState createState() => _Profil_fragState();
}

class _Profil_fragState extends State<Profil_frag> {
  TextEditingController old_pwd_Controller = TextEditingController();
  TextEditingController new_pwd_Controller = TextEditingController();
  TextEditingController conf_new_pwd_Controller = TextEditingController();

  var my_blue = HexColor('#003A70');
  final formKey = GlobalKey<FormState>();
  File? image;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [

        image != null?
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: CircleAvatar(
              radius: 62,
              backgroundColor: my_blue,
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.blueAccent,
                child: ClipOval(
                  child: Image.file(image!,
                    width: 120,
                    height: 120,
                  fit:BoxFit.cover ,
                  ),
                ),

              ),
            ),
          ):
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image(image:AssetImage('assets/user.png') ,
            width: 120,
            height: 120,
          ),
        ),
        Center(
          child: TextButton(
            onPressed: () {
              showDialog<void>(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Changer la photo de profil'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: const <Widget>[
                          Text('Veuillez choisir l\'emplacement de l\'image.'),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Annuler'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Gallerie'),
                        onPressed: ()async {
                          Navigator.of(context).pop();
                          await pickGalleryImage();

                        },
                      ),
                      TextButton(
                        child: const Text('Camera'),
                        onPressed: () async{
                          Navigator.of(context).pop();
                          await pickCameraImage();

                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Text('Changer la photo de profil',style: TextStyle(
             color:  my_blue
            ),
            ),
          ),
        ),

        SizedBox(
          height: 10,
        ),
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text('Changer le mot de passe',style: TextStyle(
                    color:  Colors.blueAccent,
                  fontSize: 20
                ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: old_pwd_Controller,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'mot de passe actuel',
                    labelStyle: TextStyle(
                      color: Colors.blueAccent,
                    ),
                    enabledBorder:OutlineInputBorder(
                      borderSide: const BorderSide(color:Colors.blueAccent , width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color:Colors.blueAccent , width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    suffixIcon: old_pwd_Controller.text.isEmpty
                        ? Container(width: 0)
                        : IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => old_pwd_Controller.clear(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: new_pwd_Controller,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'nouveau mot de passe',
                    labelStyle: TextStyle(
                      color: Colors.blueAccent,
                    ),
                    enabledBorder:OutlineInputBorder(
                      borderSide: const BorderSide(color:Colors.blueAccent , width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color:Colors.blueAccent , width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    suffixIcon: new_pwd_Controller.text.isEmpty
                        ? Container(width: 0)
                        : IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => new_pwd_Controller.clear(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: conf_new_pwd_Controller,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'confirmer nouveau mot de passe',
                    labelStyle: TextStyle(
                      color: Colors.blueAccent,
                    ),
                    enabledBorder:OutlineInputBorder(
                      borderSide: const BorderSide(color:Colors.blueAccent , width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color:Colors.blueAccent , width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    suffixIcon: conf_new_pwd_Controller.text.isEmpty
                        ? Container(width: 0)
                        : IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => conf_new_pwd_Controller.clear(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: ElevatedButton(
                  onPressed: (){},
                  child: Text('Enregistrer'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                  ),
                ),
              ),
            ],
          ),
        ),

      ],
    );
  }
  Future pickGalleryImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
      });
     await sendFile();
    }on PlatformException catch(e){
      print(e);
    }
  }
  Future pickCameraImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
      });
      await sendFile();
    }on PlatformException catch(e){
      print(e);
    }
  }
 Future <void> sendFile()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token') as String;
    var email = sharedPreferences.getString('email') as String ;
    Map<String, String> customHeaders = {
      //"content-type": "application/json; charset=UTF-8",
      "Authorization": token
    };
    final uri = Uri.parse('http://192.168.137.1:3001/collaborateur/add_image');
   http.MultipartRequest request = http.MultipartRequest('POST',uri);
   request.headers.addAll(customHeaders);
   request.fields['email']= email;
   request.files.add(await http.MultipartFile.fromPath('photo_profile',image!.path));
   var response = await request.send();
   if (response.statusCode == 200){
     print("file uploaded !!!!");
   }
  }
}
