import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyblindglish/models/reto.dart';

class RetoCubit extends Cubit<Reto?> {
  RetoCubit() : super(null);
  void setChallengeSelection(Reto reto) {
    emit(reto);
  }
}
