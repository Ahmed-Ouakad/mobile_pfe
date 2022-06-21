import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:single_page_app/models/meeting.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class calendar_frag extends StatefulWidget {
  const calendar_frag({
    Key? key,
    required this.my_blue,
  }) : super(key: key);

  final HexColor my_blue;

  @override
  _calendar_fragState createState() => _calendar_fragState();
}

class _calendar_fragState extends State<calendar_frag> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Column(
        children: [
          FutureBuilder(future: getMeetings(),
            builder: (BuildContext context, AsyncSnapshot<List<Meeting>>snapshot){
              if (snapshot.hasData){
                return Expanded(
                  child: SfCalendar(
                    view: CalendarView.workWeek,
                    dataSource: MeetingDataSource(snapshot.data!),
                    timeSlotViewSettings: TimeSlotViewSettings(
                      startHour: 7,
                      endHour: 19,
                      timeIntervalHeight: 50,
                      timeTextStyle: TextStyle(
                        color: Colors.orange,
                      ),
                    ),
                    cellBorderColor: widget.my_blue,

                    todayHighlightColor:Colors.orange,
                    headerStyle: CalendarHeaderStyle(
                      backgroundColor: widget.my_blue,
                      textStyle: TextStyle(
                        color: Colors.orange,
                      ),
                    ),
                    viewHeaderStyle: ViewHeaderStyle(
                      backgroundColor: widget.my_blue,
                      dayTextStyle: TextStyle(
                        color: Colors.orange,
                      ),
                      dateTextStyle: TextStyle(
                        color: Colors.orange,
                      ),
                    ),
                  ),
                );
              }else {
                return Text('sorry no Data ');
              }
            },
          ),
        ],
      ),
    );
  }
}
Future <List<Meeting>>getMeetings()async{
  final uri = Uri.parse('http://192.168.100.102:3001/meeting/all_my_next_meetings');
  final new_uri = Uri.parse('http://192.168.137.1:3001/meeting/all_my_next_meetings');
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

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments =  source as List?;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].date_deb;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].date_fin;
  }

  @override
  String getSubject(int index) {
    return appointments![index].titre;
  }

  @override
  Color getColor(int index) {
    return Colors.red;
  }

  @override
  bool isAllDay(int index) {
    return false;
  }
}