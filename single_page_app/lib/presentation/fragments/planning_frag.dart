import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:single_page_app/models/collaborateur.dart';
import 'package:single_page_app/models/contact_model.dart';
import 'package:http/http.dart' as http;
class Planning_frag extends StatefulWidget {
  @override
  _Planning_fragState createState() => _Planning_fragState();
}

class _Planning_fragState extends State<Planning_frag> {
  List<Collaborateur_item> selectedContacts = <Collaborateur_item>[] ;
  var my_blue = HexColor('#003A70');
  //------------------------------------------
  late DateTime date_deb;
  bool date_changed = false;
  String getDateString(){
    if (date_changed==false){
      return'choisir la date du planning';
    }
    return(date_deb.year.toString()+'-'+date_deb.month.toString()+'-'+date_deb.day.toString());
  }
  //------------------------------------------
  String usersSelectText(){
    if (selectedContacts.isEmpty){
      return 'choisir les collaborateurs';
    }
    else {
      final text = selectedContacts.map((contact)=>contact.collaborateur.username).join(',');
      return text;
    }
  }
  @override
  Widget build(BuildContext context) {

    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
    Padding(
    padding: const EdgeInsets.all(8.0),
    child: Center(
    child: Text('Définir planning télétravail',
    style: TextStyle(
    color: my_blue,
    fontWeight: FontWeight.bold,
    fontSize: 30
          ),
        ),
      ),
    ),
    Padding(
    padding: const EdgeInsets.all(4.0),
    child: Text('Date du planning',
    style: TextStyle(
    color: my_blue,
    fontWeight: FontWeight.bold,
    fontSize: 20
        ),
      ),
    ),
    Padding(
    padding: const EdgeInsets.only(left: 10,right: 10),
    child: ElevatedButton(
    onPressed: () async{
    await pickDate(context);
    },
    child: Text(getDateString()),
    style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
            ),
          ),
        ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text('Liste des collaborateurs',
              style: TextStyle(
                  color: my_blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: ElevatedButton(
              onPressed: ()async{
                final list_contacrts = await  Navigator.pushNamed(context,'/user_list');
                if (list_contacrts==null)
                  return;
                setState(() {
                  selectedContacts = list_contacrts as List<Collaborateur_item>;
                });
              },
              child: Text(usersSelectText()),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB( 10,20,10,10),
            child: ElevatedButton(
              onPressed: ()async{
               await function(context);
              },
              child: Text('Enregistrer',style: TextStyle(
                  fontSize: 20
              ),
              ),
              style: ButtonStyle(

                backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
              ),
            ),
          ),
      ]
    );
  }
  Future pickDate (BuildContext context)async{
    final initialDate = DateTime.now();
    final newDate= await showDatePicker(context: context,
        initialDate: date_changed? date_deb : initialDate,
        firstDate:DateTime(DateTime.now().year-2) ,
        lastDate: DateTime(DateTime.now().year+5)
    );
    if (newDate == null){
      return;
    }
    setState(() {
      date_deb = newDate;
      date_changed= true;
    });
  }
  Future<void>function (BuildContext context)async  {
    final uri = Uri.parse('http://192.168.100.102:3001/planning/create_planning');
    final new_uri = Uri.parse('http://192.168.137.1:3001/planning/create_planning');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token') as String;
    Map<String, String> customHeaders = {
      "content-type": "application/json; charset=UTF-8",
      "Authorization": token
    };
    List <String> names = <String>[];
    for (final elem in selectedContacts){
      names.add(elem.collaborateur.username);
    }
    //selectedContacts.map((contact)=>names.add(contact.collaborateur.username));
    Map<String, dynamic> customBody = {
      "collaborateurs":names,
      "date_deb":getDateString()+" 00:00",
      "date_fin":getDateString()+" 23:00"
    };
    String data = json.encode(customBody);
    try {

     var response = await http.post(uri,headers: customHeaders,body: data);
     if(response.statusCode == 200) {
      final snackBar = SnackBar(
        content: const Text('Planning crée avec succés'),

      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
     }else{
       final snackBar = SnackBar(
         content: const Text('Problème'),

       );
       ScaffoldMessenger.of(context).showSnackBar(snackBar);
     }

    }catch(e){
      print (e);
    }

  }
}