import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:single_page_app/models/collaborateur.dart';
import 'package:flutter/material.dart';

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();

}
class _UserListPageState extends State<UserListPage> {
   List<Collaborateur_item> selectedContacts = <Collaborateur_item>[] ;
   List<Collaborateur_item> contacts = <Collaborateur_item>[] ;
@override
  void initState() {
    // TODO: implement initState
  WidgetsBinding.instance!.addPostFrameCallback((_) => setState(()async {
    contacts = await getCollaborateurs();
  }));
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Multi Selection ListView"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              FutureBuilder(future: getCollaborateurs(),
                builder: (BuildContext context, AsyncSnapshot<List<Collaborateur_item>>snapshot){
                  if (snapshot.hasData){

                    return Expanded(
                      child: Container(
                        height: 300,
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context,index){
                            return ContactItem(
                              contacts[index].collaborateur,
                              contacts[index].isSelected,
                              index,
                            );
                          },
                        ),
                      ),
                    );
                  }else {

                    return Text('sorry no Data ');
                  }
                },
              ),
             /* Expanded(
                child: ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (BuildContext context, int index) {
                      // return item
                      return ContactItem(
                        contacts[index].name,
                        contacts[index].phoneNumber,
                        contacts[index].isSelected,
                        index,
                      );
                    }),
              ),*/
              selectedContacts.length > 0 ? Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 10,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent)
                    ),

                    child: Text(
                      "Valider",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context,selectedContacts);
                    },
                  ),
                ),
              ): Container(),
            ],
          ),
        ),
      ),
    );
  }
  Widget ContactItem(
      Collaborateur collaborateur, bool isSelected, int index) {
    return ListTile(
      title: Text(
        collaborateur.username,
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text("équipe "+collaborateur.equipe),
      trailing: isSelected
          ? Icon(
        Icons.check_circle,
        color: Colors.green[700],
      )
          : Icon(
        Icons.check_circle_outline,
        color: Colors.grey,
      ),
      onTap: () {
        setState(() {
         contacts[index].isSelected = !contacts[index].isSelected;
          if (contacts[index].isSelected == true) {
            selectedContacts.add(Collaborateur_item(collaborateur:collaborateur,isSelected: true));
          } else if (contacts[index].isSelected == false) {
            selectedContacts
                .removeWhere((element) => element.collaborateur.username == contacts[index].collaborateur.username);
          }
        });
      },
    );
  }
}
Future <List<Collaborateur_item>>getCollaborateurs()async{

  final uri = Uri.parse('http://192.168.100.102:3001/collaborateur/list_collaborateurs');
  final new_uri = Uri.parse('http://192.168.137.1:3001/collaborateur/list_collaborateurs');
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var token = sharedPreferences.getString('token') as String;
  Map<String, String> customHeaders = {
    "content-type": "application/json; charset=UTF-8",
    "Authorization": token
  };
  List <Collaborateur_item> collaborateurs = <Collaborateur_item>[];
  try{
    var response = await http.get(new_uri,headers: customHeaders);
    var jsonResponse = json.decode(response.body);
    for (final e in jsonResponse){
      collaborateurs.add(
          Collaborateur_item(collaborateur: Collaborateur(username:e['username'] ,equipe:e['equipe'] ,email:e['email'] ,admin:e['admin']),
              isSelected: false)
          );
    }
    print('this is the list length collaborateurs  -->  '+collaborateurs.length.toString());
    print(jsonResponse);
  }
  catch(exception ){
    print('this is the exception '+exception.toString());
  }

  return collaborateurs;
}