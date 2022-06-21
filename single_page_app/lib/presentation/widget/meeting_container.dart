import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:single_page_app/models/meeting.dart';
class meeting_container extends StatefulWidget {
  const meeting_container({
    Key? key,
    required this.meeting
  }) : super(key: key);
 final Meeting meeting;

  @override
  _meeting_containerState createState() => _meeting_containerState();
}

class _meeting_containerState extends State<meeting_container> {
  var my_blue = HexColor('#003A70');

  @override

  Widget build(BuildContext context) {
    var device_width = MediaQuery
        .of(context)
        .size
        .width;
    DateTime date = widget.meeting.date_deb;
    String strDate = date.year.toString()+'-'+date.month.toString()+'-'+date.day.toString()
    +' '+date.hour.toString()+':'+date.minute.toString();
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(

        decoration: BoxDecoration(
          color: my_blue,
          borderRadius: BorderRadius.circular(10),
        ),

        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image(image:AssetImage('assets/meeting.png'),color: Colors.orange,width: (device_width/5)),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(widget.meeting.titre,style: TextStyle(color: Colors.orange,fontSize: 18),),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(CupertinoIcons.location,color: Colors.orange,),
                    Text(widget.meeting.salle,style: TextStyle(color: Colors.orange,fontSize: 14),),
                    SizedBox(width: device_width/10,),
                    Text(strDate,style: TextStyle(color: Colors.orange,fontSize: 14),),

                  ],
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
