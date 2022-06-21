import 'package:equatable/equatable.dart';

class Meeting extends Equatable {
  DateTime date_deb;
  DateTime date_fin;
  String salle;
  String titre;
  String organisateur;
 List <String> invites;
 Meeting({required this.date_deb,required this.date_fin, required this.salle,
   required this.titre,required this.organisateur,required this.invites});

  @override
  // TODO: implement props
  List<Object?> get props => [date_deb,date_fin,salle,titre,organisateur,invites];
}