import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:single_page_app/logic/index_cubit.dart';
import 'package:single_page_app/presentation/widget/email_field_widget.dart';
import 'package:single_page_app/presentation/widget/password_field_widget.dart';
import 'home.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200],
      body: SafeArea(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Image(
                  image: AssetImage('assets/upper-corner.png',),
                 // alignment: Alignment.topLeft,

                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(image: AssetImage('assets/logo-sofia-tech.png')),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: EmailFieldWidget(controller: emailController),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PasswordFieldWidget(controller: passwordController),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ElevatedButton(onPressed: ()async{
                    if(formKey.currentState!.validate()){
                        await signIn(emailController.text, passwordController.text);
                    }
                  }, child: Text('Connexion'),style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(HexColor('#003A70')),
                  ),
                  ),
                ),
                Image(
                  image: AssetImage('assets/bottom-corner.png'),
                  //alignment: Alignment.bottomRight,
                ),
              ],
            ),
          )
      ),
    );
  }
  signIn(String email, String pass) async {
    print('you are inside the function !!!! ');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print('you are after shared pref !!!! ');
    Map data = {
      'email': email,
      'password': pass
    };
    Map<String, String> customHeaders = {
      "content-type": "application/json; charset=UTF-8"
    };
    var jsonResponse = null;
    String str = json.encode(data);
    final phone_uri = Uri.parse('http://192.168.100.102:3001/collaborateur/login');
    final new_uri = Uri.parse('http://192.168.137.1:3001/collaborateur/login');
    try{var response = await http.post(new_uri,headers: customHeaders, body: str);
    if(response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if(jsonResponse != null) {
        print(jsonResponse);
        sharedPreferences.setString("email", jsonResponse['email']);
        sharedPreferences.setString("token", jsonResponse['token']);
        sharedPreferences.setString("admin", jsonResponse['admin'].toString());
        sharedPreferences.setString("equipe", jsonResponse['equipe']);
        sharedPreferences.setString("username", jsonResponse['username']);
        sharedPreferences.setString("image_url", jsonResponse['image_url']);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => BlocProvider(create: (context) => IndexCubit(),child: Home())), (Route<dynamic> route) => false);
      }
    }
    else {
      print(response.body);
    }
    }catch(exception ){
      print(exception);
    }
    print('you are after try catch !!!! ');
  }
}
