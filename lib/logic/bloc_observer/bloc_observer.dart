import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utilities/constants.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    // TODO: implement onCreate
    super.onCreate(bloc);
    log.info("${bloc.runtimeType} Created !!!!");
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    // TODO: implement onChange
    super.onChange(bloc, change);
    log.info('${bloc.runtimeType} Changed To - $change');
  }
}
