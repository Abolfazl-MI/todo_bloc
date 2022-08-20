part of 'theme_cubit_cubit.dart';

abstract class ThemeCubitState extends Equatable {
  const ThemeCubitState();

  @override
  List<Object> get props => [];
}

class LightThemeCubitState extends ThemeCubitState {}
class DarkThemeCubitState extends ThemeCubitState {}

