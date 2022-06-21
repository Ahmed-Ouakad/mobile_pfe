part of 'collaborateurs_list_cubit.dart';

@immutable
abstract class CollaborateursListState {}

class CollaborateursListLoading extends CollaborateursListState {
  CollaborateursListLoading();
}
class CollaborateursListLoaded extends CollaborateursListState {
  final List<Collaborateur_item> contacts;
  CollaborateursListLoaded({required this.contacts});
}
class CollaborateursListError extends CollaborateursListState {
  CollaborateursListError();
}

