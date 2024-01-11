import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logging/logging.dart';
import 'package:weather_app/data/data_provider/data_provider.dart';
import 'package:weather_app/logic/bloc/weather_bloc/weather_bloc.dart';
import 'package:weather_app/presentation/screens/home/home_page.dart';

import 'logic/bloc_observer/bloc_observer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //bloc observer
  Bloc.observer = AppBlocObserver();
  //Dio Initialize
  DataProvider.initializeDio();
  //logging
  initRootLogger();
  
  //easyloading initilaize
  configLoading();
  runApp(const MyApp());
}

/// configure easyloading
void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions =
        false // important : it restrict user interaction while show loading.
    ..dismissOnTap = false;
}

/// initialize logger
void initRootLogger() {
  //<--
  if (kDebugMode) {
    Logger.root.level = Level.ALL;
  } else {
    Logger.root.level = Level.OFF;
  }
  Logger.root.onRecord.listen((record) {
// set ansi color code
    var start = '\x1b[90m';
    const end = '\x1b[0m';
    const white = '\x1b[37m';
    switch (record.level.name) {
      case 'INFO':
        start = '\x1b[32m';
      case 'WARNING':
        start = '\x1b[93m';
      case 'SEVERE':
        start = '\x1b[31m';
      case 'SHOUT':
        start = '\x1b[41m\x1b[93m';
    }
    final message = '$white${record.time}:$end$start${record.level.name}:---> '
        '${record.message}$end';
    print(message);
  });
}

/// root widget
class MyApp extends StatelessWidget {
  ///constructor
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 912),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Weather App',
          debugShowCheckedModeBanner: false,
          home: BlocProvider<WeatherBloc>(
            create: (context) => WeatherBloc(),
            child: HomePage(),
          ),
          builder: EasyLoading.init(),
        );
      },
    );
  }
}
