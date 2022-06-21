import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  StreamSubscription connectivityStreamSubscription;
  Connectivity connectivity;
  InternetCubit({required this.connectivityStreamSubscription,required this.connectivity}) : super(InternetInitial()){
    monitorInternetConnection();
  }
  StreamSubscription<ConnectivityResult> monitorInternetConnection() {
    return connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
          if (connectivityResult == ConnectivityResult.wifi || connectivityResult == ConnectivityResult.mobile ) {
            emitInternetConnected();
          }  else if (connectivityResult == ConnectivityResult.none) {
            emitInternetDisconnected();
          }
        });
  }
  void emitInternetConnected() =>
      emit(InternetConnected());

  void emitInternetDisconnected() => emit(InternetDisconnected());

  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }

}
