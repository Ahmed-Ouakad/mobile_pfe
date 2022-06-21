import 'package:equatable/equatable.dart';

class Collaborateur  extends Equatable{
  String username;
  String equipe;
  String email;
  bool admin;
 Collaborateur({required this.username,required this.equipe,required this.email,required this.admin});

  @override
  // TODO: implement props
  List<Object?> get props => [username,equipe,email,admin];
}
class Collaborateur_item {
   Collaborateur collaborateur;
   bool isSelected;
  Collaborateur_item({required this.collaborateur,required this.isSelected});
}