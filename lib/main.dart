import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:loggy/loggy.dart';
import 'package:qik_pharma_mobile/core/api/network_info.dart';
import 'package:qik_pharma_mobile/no_internet_screen.dart';

import 'package:qik_pharma_mobile/features/splash/splash_screen.dart';
import 'package:qik_pharma_mobile/providers.dart';

//arpan.ladell@foundtoo.com
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Loggy.initLoggy();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final streamController = StreamController<bool>.broadcast();
  StreamSubscription? subscription;
  NetworkInfoImpl networkInfo = NetworkInfoImpl(DataConnectionChecker());

  bool isInternet = false;

  @override
  void initState() {
    super.initState();

    try {
      subscription = Connectivity().onConnectivityChanged.listen(null);

      subscription?.onData((result) async =>
          streamController.add(await networkInfo.isConnected));
    } on Exception catch (e) {
      logDebug(e.toString());
    }

    streamController.onCancel = () {
      subscription?.cancel();
      streamController.close();
    };
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers,
      child: StyledToast(
        locale: const Locale('en', 'US'),
        textStyle: const TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        borderRadius: BorderRadius.circular(10),
        toastPositions: StyledToastPosition.bottom,
        toastAnimation: StyledToastAnimation.slideFromLeft,
        reverseAnimation: StyledToastAnimation.slideToRightFade,
        curve: Curves.easeIn,
        reverseCurve: Curves.linear,
        duration: const Duration(seconds: 5),
        dismissOtherOnShow: true,
        animDuration: Duration.zero,
        fullWidth: true,
        isHideKeyboard: true,
        child: MaterialApp(
          title: 'qikPharma',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Inter',
          ),
          builder: (context, widget) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.0)),
              child: widget!,
            );
          },
          home: StreamBuilder<bool>(
            stream: streamController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!) {
                  return const SplashScreen();
                }

                return const NoInternetConnectionsScreen();
              }
              return Scaffold(
                body: Center(
                  child: Image.asset(
                    "assets/images/logo.png",
                    scale: 3,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
