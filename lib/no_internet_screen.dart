import 'package:flutter/material.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class NoInternetConnectionsScreen extends StatefulWidget {
  const NoInternetConnectionsScreen({Key? key}) : super(key: key);

  @override
  State<NoInternetConnectionsScreen> createState() =>
      _NoInternetConnectionsScreenState();
}

class _NoInternetConnectionsScreenState
    extends State<NoInternetConnectionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Center(
                  child: Image.asset("assets/images/ic_noInternet.png"),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No network connection',
              style: textStyle16Grey.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
