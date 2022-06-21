import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'index_state.dart';

class IndexCubit extends Cubit<IndexState> {
  IndexCubit() : super(IndexState(indexValue: 0,indexWasChanged: false));
  void setIndex(int i)=> emit(
    IndexState(indexValue: i,indexWasChanged: true)
  );

}
