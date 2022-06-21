import 'package:charts_flutter/flutter.dart'as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:single_page_app/models/maladie_stats.dart';

class Stats_frag extends StatefulWidget{
  @override
  _Stats_fragState createState() => _Stats_fragState();
}

class _Stats_fragState extends State<Stats_frag> {
  var my_blue = HexColor('#003A70');
  final List<MaladieStats>data = [
    MaladieStats(equipe: 'mobile', nombre: 1),
    MaladieStats(equipe: 'embarqué', nombre: 3),
    MaladieStats(equipe: 'test', nombre: 2)
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<charts.Series<MaladieStats,String>> series = [
      charts.Series(
        id: 'suivi des maladies par équipes',
        data: data,
        domainFn: (MaladieStats series,_)=> series.equipe,
        measureFn: (MaladieStats series,_)=> series.nombre,
      )
    ];
   return Expanded(
     flex: 5,
     child: Column(
       children: [
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Center(
             child: Text('Statistiques',
               style: TextStyle(
                   color: my_blue,
                   fontWeight: FontWeight.bold,
                   fontSize: 24
               ),
             ),
           ),
         ),
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Center(
             child: Text('Statistiques des maladies',
               style: TextStyle(
                   color: Colors.blueAccent,
                   fontWeight: FontWeight.bold,
                   fontSize: 18
               ),
             ),
           ),
         ),
         Expanded(child: charts.BarChart(series,animate: true,)),
       ],
     ),
   );
  }
}