import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:single_page_app/models/collaborateur.dart';

part 'collaborateurs_list_state.dart';

class CollaborateursListCubit extends Cubit<CollaborateursListState> {
  CollaborateursListCubit() : super(CollaborateursListLoading()){

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
    var response = await http.get(uri,headers: customHeaders);
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
