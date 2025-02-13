import 'package:flutter_bloc/flutter_bloc.dart';

class TutorialPreferenceCubit extends Cubit<bool> {
  TutorialPreferenceCubit() : super(false);
  void toggleTutorialActivated(bool value) {
    emit(value);
  }
}
