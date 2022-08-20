

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_cubit_state.dart';

class ThemeCubitCubit extends Cubit<ThemeCubitState> {
  ThemeCubitCubit() : super(LightThemeCubitState());

  changeTheme() {
    if (state is LightThemeCubitState) {
      
      emit(DarkThemeCubitState());
    } else if (state is DarkThemeCubitState) {
      emit(LightThemeCubitState());
    } else {
      emit(LightThemeCubitState());
    }
  }
}
