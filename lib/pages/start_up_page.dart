import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:we_chat_app/pages/login_page.dart';
import 'package:we_chat_app/pages/otp_page.dart';
import 'package:we_chat_app/pages/sign_up_page.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/images.dart';
import '../resources/strings.dart';

class StartUpPage extends StatelessWidget {
  const StartUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              START_UP_LOGO,
              width: START_UP_LOGO_WIDTH,
            ),
            const SizedBox(
              height: TEXT_HEIGHT_FROM_START_UP_LOGO_BOTTOM,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: START_UP_PAGE_TEXT_AND_BUTTON_PADDING),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Text your friends and share moments",
                    style: TextStyle(
                        fontFamily: YORKIE_FONT,
                        fontSize: TEXT_FONT_SIZE_19,
                        color: SECONDARY_COLOR,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: MARGIN_SMALL,
                  ),
                  Text(
                    "End-to-end secured messaging app with Social Elements",
                    style: GoogleFonts.notoSans(
                      fontSize: TEXT_FONT_SIZE_12,
                      color: SECONDARY_COLOR,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: MARGIN_XXLARGE,
                  ),
                  const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(child: SignUpButton()),
                      SizedBox(
                        width: MARGIN_XXLARGE_2,
                      ),
                      Expanded(child: LoginButton()),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const OtpPage(),
          ),
        );
      },
      child: Container(
        width: BUTTON_BOX_WIDTH,
        height: BUTTON_BOX_HEIGHT,
        decoration: BoxDecoration(
          border: Border.all(color: PRIMARY_COLOR),
          borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
        ),
        child: const Center(
          child: Text(
            "Sign Up",
            style: TextStyle(
              color: PRIMARY_COLOR,
              fontFamily: YORKIE_FONT,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      },
      child: Container(
        width: BUTTON_BOX_WIDTH,
        height: BUTTON_BOX_HEIGHT,
        decoration: BoxDecoration(
          color: PRIMARY_COLOR,
          border: Border.all(color: PRIMARY_COLOR),
          borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
        ),
        child: const Center(
          child: Text(
            "Login",
            style: TextStyle(
              color: Colors.white,
              fontFamily: YORKIE_FONT,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
