import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
class maladie_frag extends StatefulWidget {
  const maladie_frag({
    Key? key,

  }) : super(key: key);

  @override
  _maladie_fragState createState() => _maladie_fragState();
}

class _maladie_fragState extends State<maladie_frag> {

  TextEditingController desc_Controller = TextEditingController();
  TextEditingController repos_Controller = TextEditingController();
  var my_blue = HexColor('#003A70');
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text('Déclarer Maladie',
                style: TextStyle(
                    color: my_blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 24
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(

              controller: desc_Controller,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'description des symptômes',
                hintStyle: TextStyle(
                  color: my_blue,
                ),
                enabledBorder:OutlineInputBorder(
                  borderSide: const BorderSide(color:Colors.blueAccent , width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color:Colors.blueAccent , width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                suffixIcon: desc_Controller.text.isEmpty
                    ? Container(width: 0)
                    : IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => desc_Controller.clear(),
                ),
              ),

            ),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: repos_Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'période de repos (en jours)',
                hintStyle: TextStyle(
                  color: my_blue,
                ),
                enabledBorder:OutlineInputBorder(
                  borderSide: const BorderSide(color:Colors.blueAccent , width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color:Colors.blueAccent , width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                suffixIcon: repos_Controller.text.isEmpty
                    ? Container(width: 0)
                    : IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => repos_Controller.clear(),
                ),
              ),
              validator: (val) => val != null && !isNumeric(val)
                  ? 'ce champ doit être numérique'
                  : null,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: ElevatedButton(
              onPressed: ()async{
                if(formKey.currentState!.validate()){
                  await Submit(desc_Controller.text, repos_Controller.text,context);
                }
              },
              child: Text('Enregistrer'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
              ),
            ),
          ),


        ],
      ),
    );
  }
}
bool isNumeric(String s) {

  try{
    double.parse(s);
    return true;
  }
  catch(e){
    return false;
  }
}
 Future<void> Submit(String symp,String repos,BuildContext context)async{
   final new_uri = Uri.parse('http://192.168.137.1:3001/maladie/create_maladie');
   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   var token = sharedPreferences.getString('token') as String;
   var equipe = sharedPreferences.getString('equipe')as String;
   Map<String, String> customHeaders = {
     "content-type": "application/json; charset=UTF-8",
     "Authorization": token
   };
   DateTime date = DateTime.now();
   String str_date = date.year.toString()+'-'+date.month.toString()+'-'+date.day.toString()+" 00:00";
   Map<String, String> customBody = {
     "date_dec":str_date,
     "symptomes":symp,
     "equipe":equipe,
     "duree_guerison":repos,

   };
   String data = json.encode(customBody);
   try {

     var response = await http.post(new_uri,headers: customHeaders,body: data);
     if(response.statusCode == 200) {
       final snackBar = SnackBar(
         content: const Text('maladie déclarée avec succés'),

       );
       ScaffoldMessenger.of(context).showSnackBar(snackBar);
     }else{
       print(response.body);
       final snackBar = SnackBar(
         content: const Text('Problème'),

       );
       ScaffoldMessenger.of(context).showSnackBar(snackBar);
     }

   }catch(e){
     print (e);

   }

 }

