import 'package:flutter_bloc/flutter_bloc.dart';
import '../../main.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) {
      printLogs(message: change, title: bloc.runtimeType.toString());
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    printLogs(message: transition, title: bloc.runtimeType.toString());
  }
}
