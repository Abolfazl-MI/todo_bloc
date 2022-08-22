import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class NoteObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    print('on create called');
    // TODO: implement onCreate
    log('${bloc} had created');
    super.onCreate(bloc);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    // TODO: implement onEvent
    super.onEvent(bloc, event);
    log('$bloc had add $event');
  }
}
