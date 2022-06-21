import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:single_page_app/logic/index_cubit.dart';
import 'package:single_page_app/presentation/pages/login_page.dart';
class menu_frag extends StatelessWidget {
  const menu_frag({
    Key? key,
    required this.my_blue,

  }) : super(key: key);

  final HexColor my_blue;
  final bool condition = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,

      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(' Menu',
              style: TextStyle(
                  color: my_blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 30


              ),
            ),
          ),
        ),
        Visibility(
          visible: !condition,
          child: SizedBox(
            height: 40,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 4, 4, 8),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(my_blue),
              minimumSize: MaterialStateProperty.all<Size>(Size(80,50)),
            ),
            onPressed: (){
              BlocProvider.of<IndexCubit>(context).setIndex(4);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Profil',style: TextStyle(
                color: Colors.orange,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
                ),
                Icon(Icons.account_circle,color: Colors.orange,size: 30,)
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(my_blue),
              minimumSize: MaterialStateProperty.all<Size>(Size(80,50)),
            ),
            onPressed: (){
              BlocProvider.of<IndexCubit>(context).setIndex(1);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Calendrier',style: TextStyle(
                    color: Colors.orange,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
                ),
               // Icon(Icons.account_circle,color: Colors.orange,size: 30,)
                ImageIcon(AssetImage('assets/calendar.png'),color: Colors.orange,),
              ],
            ),
          ),
        ),
        Visibility(
          visible: condition,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(my_blue),
                minimumSize: MaterialStateProperty.all<Size>(Size(80,50)),
              ),
              onPressed: (){
                BlocProvider.of<IndexCubit>(context).setIndex(5);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Statistique',style: TextStyle(
                      color: Colors.orange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                  ),
                  // Icon(Icons.account_circle,color: Colors.orange,size: 30,)
                  ImageIcon(AssetImage('assets/bar-chart.png'),color: Colors.orange,),
                ],
              ),
            ),
          ),
        ),

        Visibility(
          visible: condition,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(my_blue),
                minimumSize: MaterialStateProperty.all<Size>(Size(80,50)),
              ),
              onPressed: (){
                BlocProvider.of<IndexCubit>(context).setIndex(6);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Organiser Réunion',style: TextStyle(
                      color: Colors.orange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                  ),
                  // Icon(Icons.account_circle,color: Colors.orange,size: 30,)
                  ImageIcon(AssetImage('assets/meeting.png'),color: Colors.orange,),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: condition,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(my_blue),
                minimumSize: MaterialStateProperty.all<Size>(Size(80,50)),
              ),
              onPressed: (){
                BlocProvider.of<IndexCubit>(context).setIndex(7);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Définir un Planning Télétravail',style: TextStyle(
                      color: Colors.orange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                  ),
                  // Icon(Icons.account_circle,color: Colors.orange,size: 30,)
                  ImageIcon(AssetImage('assets/planning.png'),color: Colors.orange,),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(my_blue),
              minimumSize: MaterialStateProperty.all<Size>(Size(80,50)),
            ),
            onPressed: (){
              BlocProvider.of<IndexCubit>(context).setIndex(2);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Déclarer Maladie',style: TextStyle(
                    color: Colors.orange,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
                ),

                // Icon(Icons.account_circle,color: Colors.orange,size: 30,)
                ImageIcon(AssetImage('assets/doctor.png'),color: Colors.orange,),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(my_blue),
              minimumSize: MaterialStateProperty.all<Size>(Size(80,50)),
            ),
            onPressed: (){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Déconnexion',style: TextStyle(
                    color: Colors.orange,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
                ),

                // Icon(Icons.account_circle,color: Colors.orange,size: 30,)
                ImageIcon(AssetImage('assets/turn-off.png'),color: Colors.orange,),
              ],
            ),
          ),
        ),
      ],
    );
  }
}