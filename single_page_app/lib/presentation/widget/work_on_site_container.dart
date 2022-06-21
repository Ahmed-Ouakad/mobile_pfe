import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
class work_on_site_container extends StatefulWidget {
  const work_on_site_container({
    Key? key,
    required this.my_blue,
    required this.device_width,
  }) : super(key: key);

  final HexColor my_blue;
  final double device_width;

  @override
  _work_on_site_containerState createState() => _work_on_site_containerState();
}

class _work_on_site_containerState extends State<work_on_site_container> {
  Future <String?> getName()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return ( await sharedPreferences.getString('username'));
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: widget.my_blue,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image(
                image:AssetImage('assets/location.png'),
                width: (widget.device_width/5),
                color: Colors.orange,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder(
                    future: getName(),
                    builder: (BuildContext context,AsyncSnapshot<String?> snapshot){
                      if (snapshot.hasData){
                        return  Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:

                          Text('Bonjour '+ snapshot.data!,
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 18,
                            ),
                          ),
                        );

                      }else{
                        return Text('No data');
                      }
                    }
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text('Vous travaillez sur site aujourd\'hui',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

      ),
    );
  }
}
