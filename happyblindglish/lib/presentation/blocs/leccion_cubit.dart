import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyblindglish/models/leccion.dart';

class LeccionCubit extends Cubit<Leccion?> {
  LeccionCubit() : super(null);
  void setLessonSelection(Leccion leccion) {
    emit(leccion);
  }
}
