import 'dart:convert';
import 'package:shimmer/shimmer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:single_page_app/models/meeting.dart';
import 'package:single_page_app/presentation/widget/meeting_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:single_page_app/presentation/widget/remote_work_container.dart';
import 'package:single_page_app/presentation/widget/work_on_site_container.dart';
import 'package:http/http.dart' as http;
class home_page extends StatefulWidget {
  const home_page({
    Key? key,
    required this.my_blue,
    required this.device_width,
  }) : super(key: key);

  final HexColor my_blue;
  final double device_width;

  @override
  _home_pageState createState() => _home_pageState();

}

class _home_pageState extends State<home_page> {


  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,

        children: [

          FutureBuilder(future: RemoteWorkOrNot(context),
            builder: (BuildContext context, AsyncSnapshot<bool>snapshot){
          if (snapshot.hasData){
            if(snapshot.data==true){
              return remote_work_container(my_blue: widget.my_blue, device_width:widget.device_width);
            }else{
              return work_on_site_container(my_blue: widget.my_blue, device_width: widget.device_width);
            }
          }else {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[200]!,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  color: Colors.white,
                ),
              ),
            );
          }
          },
          ),



          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Mes Réunions',
              style: TextStyle(
                  color: widget.my_blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 24
              ),
            ),
          ),
          FutureBuilder(future: getMeetings(),
            builder: (BuildContext context, AsyncSnapshot<List<Meeting>>snapshot){
              if (snapshot.hasData){
                return Expanded(
                  child: Container(
                    height: 300,
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context,index){
                        return meeting_container( meeting : snapshot.data![index]);
                      },
                    ),
                  ),
                );
              }else {
                return  Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[200]!,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 100,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[200]!,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 100,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),

         // meeting_container(my_blue: widget.my_blue, device_width: widget.device_width),
         // meeting_container(my_blue: widget.my_blue, device_width: widget.device_width),

        ],
      ),
    );
  }
}
Future<bool> RemoteWorkOrNot (BuildContext context)async{
  final phone_uri = Uri.parse('http://192.168.100.102:3001/planning/my_planning_for_today');
  final new_uri = Uri.parse('http://192.168.137.1:3001/planning/my_planning_for_today');
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var token = sharedPreferences.getString('token') as String;
  var username = sharedPreferences.getString('username') as String;
  Map<String, String> customHeaders = {
    "content-type": "application/json; charset=UTF-8",
    "Authorization": token
  };
  DateTime date = new DateTime.now();
  String msg = date.year.toString()+'-'+date.month.toString()+'-'+date.day.toString()+' '+date.hour.toString()+':'+date.minute.toString();
  Map data = {
    "date": msg,
    "username":username
  };
  String str = json.encode(data);
  var jsonResponse;
  try{
    var response = await http.post(new_uri,headers: customHeaders,body: str);
    jsonResponse = json.decode(response.body);
      print(jsonResponse);
      return Future<bool>.value(jsonResponse['result'] );
  }catch(exception ){
    print('this is the exception '+exception.toString());
    return true;
  }
}
Future <List<Meeting>>getMeetings()async{
  final uri = Uri.parse('http://192.168.100.102:3001/meeting/my_next_meetings');
  final new_uri = Uri.parse('http://192.168.137.1:3001/meeting/my_next_meetings');
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var token = sharedPreferences.getString('token') as String;
  var username = sharedPreferences.getString('username') as String;
  Map<String, String> customHeaders = {
    "content-type": "application/json; charset=UTF-8",
    "Authorization": token
  };
  DateTime date = new DateTime.now();
  String msg = date.year.toString()+'-'+date.month.toString()+'-'+date.day.toString()+' '+date.hour.toString()+':'+date.minute.toString();
  Map data = {
    "date": msg,
    "username":username
  };
  String str = json.encode(data);

  List <Meeting> my_meetings = <Meeting>[];
  try{
    var response = await http.post(new_uri,headers: customHeaders,body: str);
   var jsonResponse = json.decode(response.body);
    for (final e in jsonResponse){
      List <String> invites = <String>[];
      for(final element in e['invites']){
        invites.add(element.toString());
      }
      my_meetings.add(Meeting(date_deb:DateTime.parse(e['date_deb']) ,date_fin:DateTime.parse(e['date_fin']) ,salle:e['salle'] as String ,titre:e['titre']as String ,organisateur:e['organisateur']as String ,invites:invites ));
    }
    print('this is the list length -->  '+my_meetings.length.toString());
    print(jsonResponse);

  }
  catch(exception ){
    print('this is the exception '+exception.toString());
  }
  return my_meetings;
}
