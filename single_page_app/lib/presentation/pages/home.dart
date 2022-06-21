import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:single_page_app/logic/index_cubit.dart';
import 'package:single_page_app/presentation/fragments/absence_frag.dart';
import 'package:single_page_app/presentation/fragments/calendar_frag.dart';
import 'package:single_page_app/presentation/fragments/maladie_frag.dart';
import 'package:single_page_app/presentation/fragments/meeting_frag.dart';
import 'package:single_page_app/presentation/fragments/menu_frag.dart';
import 'package:single_page_app/presentation/fragments/planning_frag.dart';
import 'package:single_page_app/presentation/fragments/profil_frag.dart';
import 'package:single_page_app/presentation/fragments/stats_frag.dart';
import 'package:single_page_app/presentation/widget/bottom_nav_bar.dart';


import '../widget/meeting_container.dart';
import '../fragments/home_frag.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var my_blue = HexColor('#003A70');


  @override
  Widget build(BuildContext context) {
    var device_height = MediaQuery
        .of(context)
        .size
        .height;
    var device_width = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.grey[200],
          title: Image(
            image: AssetImage('assets/logo-sofia-tech.png'), width: 100,),
          actions: [IconButton(
            icon: Image(image: AssetImage('assets/user.png'),
            ),
            onPressed: () {
              BlocProvider.of<IndexCubit>(context).setIndex(4);
            },
          ),
            IconButton(
              icon: Image(image: AssetImage('assets/bell.png'),
              ),
              onPressed: () {},
            ),
          ],
        ),


        body: Column(
          children: [
            BlocBuilder<IndexCubit, IndexState>(
              builder: (context, state) {
                if(state.indexValue==0) {
                  return home_page(
                      my_blue: my_blue, device_width: device_width);
                }
                if(state.indexValue==1){
                  return calendar_frag(my_blue: my_blue);
                }
                if(state.indexValue==2){
                  return maladie_frag();
                }
                if(state.indexValue==3){
                  return menu_frag(my_blue: my_blue);
                }
                if(state.indexValue==4){
                  return Profil_frag();
                }
                if(state.indexValue==5){
                  return Stats_frag();
                }
                if(state.indexValue==6){
                  return Meeting_frag();
                }
                if(state.indexValue==7){
                  return Planning_frag();
                }
                if(state.indexValue==8){
                  return Absence_frag();
                }
                throw Exception('Some error');
              },
            ),
            Expanded(child: BottomNavBarV2(),flex: 1,),
          ],
        )
    );
  }

}





