import 'package:flutter/material.dart';

import 'widget/splash_view_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: const SplashViewBody()));
  }
}
