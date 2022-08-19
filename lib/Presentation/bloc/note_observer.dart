import 'package:flutter_bloc/flutter_bloc.dart';

class NoteObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    print('on create called');
    // TODO: implement onCreate
    super.onCreate(bloc);
  }
}
