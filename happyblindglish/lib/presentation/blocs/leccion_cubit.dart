import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyblindglish/models/reto.dart';

class LeccionCubit extends Cubit<Reto?> {
  LeccionCubit() : super(null);
  void setChallengeSelection(Reto reto) {
    emit(reto);
  }
  
}
