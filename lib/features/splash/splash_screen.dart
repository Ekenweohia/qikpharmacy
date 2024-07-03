import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/features/splash/cubit/splash_cubit.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_navigator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _authStatus();
  }

  void _authStatus() async {
    final cubit = BlocProvider.of<SplashCubit>(context);
    cubit.authStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashLoaded) {
            QikPharmaNavigator.pushReplacement(context, state.route);
            return;
          }
        },
        child: Center(
          child: Image.asset(
            "assets/images/logo.png",
            scale: 3,
          ),
        ),
      ),
    ));
  }
}
