
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:single_page_app/models/collaborateur.dart';
import 'package:single_page_app/models/contact_model.dart';
import 'package:single_page_app/presentation/pages/user_list.dart';

class Meeting_frag extends StatefulWidget {
  @override
  _Meeting_fragState createState() => _Meeting_fragState();
}

class _Meeting_fragState extends State<Meeting_frag> {
  List<Collaborateur_item> selectedContacts = <Collaborateur_item>[] ;
  var my_blue = HexColor('#003A70');
  //--------------------------------------
  late DateTime date_deb;
  bool date_changed = false;
  String getDateString(){
    if (date_changed==false){
      return'choisir la date';
    }
    return(date_deb.year.toString()+'/'+date_deb.month.toString()+'/'+date_deb.day.toString());
  }
  //--------------------------------------
  late TimeOfDay heure_deb;
  bool heure_deb_changed=false;
  String getHeureDebString(){
    if (heure_deb_changed==false){
      return'choisir l\'heure de début';
    }
    return(heure_deb.hour.toString()+':'+heure_deb.minute.toString());
  }
  //----------------------------------------
  late TimeOfDay heure_fin;
  bool heure_fin_changed=false;
  String getHeureFinString(){
    if (heure_fin_changed==false){
      return'choisir l\'heure de fin';
    }
    return(heure_fin.hour.toString()+':'+heure_fin.minute.toString());
  }
  //----------------------------------------
  String usersSelectText(){
    if (selectedContacts.isEmpty){
      return 'choisir les collaborateurs';
    }
    else {
      final text = selectedContacts.map((contact)=>contact.collaborateur.username).join(',');
      return text;
    }
  }
  //-----------------------------------
  final List<String> salles = ['Java','Ruby','Python'];
  String? dropdownValue ='Java';
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
      flex:5,
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(' Organiser Réunion',
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
                child: Text('Date de la réunion',
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
                child: Text('Heure de Début',
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
                    await pickHeureDeb(context);
                  },
                  child: Text(getHeureDebString()),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text('Heure de fin',
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
                    await pickHeureFin(context);
                  },
                  child: Text(getHeureFinString()),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text('Date de la réunion',
                  style: TextStyle(
                      color: my_blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),
                ),
              ),
   /* Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButton<String>(
          value: dropdownValue,

          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(color: Colors.blueAccent),
          underline: Container(
          height: 2,
          color: Colors.blueAccent,
          ),
          onChanged: (String? newValue) {
          setState(() {
          dropdownValue = newValue!;

          });
          },
          items: salles.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
          );
          }).toList(),
          ),
      ),*/
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    focusColor: Colors.blueAccent,
                    hoverColor: Colors.blueAccent,
                    fillColor: Colors.blueAccent,



                  ),
                  hint: Text('choisr la salle de réunion',style: TextStyle(
                    color: Colors.blueAccent,
                  ),
                  ),
                  items: salles.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;

                    });
                  },
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
            ],
          ),
        ),
      ),
    );
  }
  //---------------------------------------------
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
  //----------------------------------------------
  Future pickHeureDeb (BuildContext context)async{
    final initialTime = TimeOfDay(hour: 9,minute: 0);
    final newHeure= await showTimePicker(

      context: context,
        initialTime: heure_deb_changed? heure_deb : initialTime,

    );
    if (newHeure == null){
      return;
    }
    setState(() {
      heure_deb = newHeure;
      heure_deb_changed= true;
    });
  }
  //-----------------------------------------------
  Future pickHeureFin (BuildContext context)async{
    final initialTime = TimeOfDay(hour: 9,minute: 0);
    final newH= await showTimePicker(

      context: context,
      initialTime: heure_fin_changed? heure_fin : initialTime,

    );
    if (newH == null){
      return;
    }
    setState(() {
      heure_fin = newH;
      heure_fin_changed= true;
    });
  }
  Future<void>function (BuildContext context)async  {
    final uri = Uri.parse('http://192.168.100.102:3001/meeting/create_meeting');
    final new_uri = Uri.parse('http://192.168.137.1:3001/meeting/create_meeting');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token') as String;
    var username = sharedPreferences.getString('username')as String;
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
      "organisateur":username,
      "invites":names,
      "salle":dropdownValue,
      "date_deb":getDateString()+' '+getHeureDebString(),
      "date_fin":getDateString()+' '+getHeureFinString()
    };
    String data = json.encode(customBody);
    try {

      var response = await http.post(new_uri,headers: customHeaders,body: data);
      if(response.statusCode == 200) {
        final snackBar = SnackBar(
          content: const Text('réunion crée avec succés'),

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