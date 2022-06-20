import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/core/theme/color_theme.dart';
import 'package:notes/core/theme/text_theme.dart';

class OnboardScreen extends StatelessWidget {
  const OnboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(16),
          child: TextButton(
            onPressed: () {
              GoRouter.of(context).go('/login');
            },
            child: Text(
              key: const Key("onboard_login_button"),
              "Mulai",
              style: ThemeText.bodyStyle,
            ),
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: ThemeColor.accentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              minimumSize: const Size(double.infinity, 48),
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/images/green_paper.png"),
          Text("NotApp",
              style: ThemeText.alternativeStyle.copyWith(fontSize: 36)),
          Text(
            "Aplikasi catatan yang super mudah dan tersinkronisasi dengan Cloud. Buka dimanapun, kapanpun, kemanapun selalu siap untukmu.",
            style: ThemeText.bodyStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
