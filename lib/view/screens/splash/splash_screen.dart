import 'package:flutter/material.dart';
import 'package:go_shop/utils/images.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../providers/providers.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read(splashProvider).init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              Images.splash,
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
