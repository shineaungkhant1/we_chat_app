import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_app/blocs/login_bloc.dart';
import 'package:we_chat_app/pages/moment_page.dart';
import 'package:we_chat_app/pages/otp_page.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/images.dart';
import 'package:we_chat_app/utils/extensions.dart';
import 'package:we_chat_app/viewitems/bottom_nav_bar_view.dart';

import '../resources/dimens.dart';
import '../resources/strings.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_outlined,
                size: 38,
                color: PRIMARY_COLOR,
              ),
            ),
          ),
          body: Selector<LoginBloc, bool>(
            selector: (context, bloc) => bloc.isLoading,
            builder: (context, isLoading, child) => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 38),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: MARGIN_MEDIUM_3,
                    ),
                    const Text(
                      "Welcome !",
                      style: TextStyle(
                          fontFamily: YORKIE_FONT,
                          fontSize: 30,
                          color: PRIMARY_COLOR,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: MARGIN_MEDIUM,
                    ),
                    Text(
                      "Login to continue",
                      style: GoogleFonts.notoSansMyanmar(
                          fontSize: 13,
                          color: const Color.fromRGBO(17, 58, 93, 0.7),
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: MARGIN_XXLARGE,
                    ),
                    Image.asset(PEOPLE_LOGO),
                    const SizedBox(
                      height: MARGIN_XLARGE,
                    ),
                    Consumer<LoginBloc>(
                      builder: (context, bloc, child) => EmailField(
                        bloc: bloc,
                      ),
                    ),
                    const SizedBox(
                      height: MARGIN_XLARGE,
                    ),
                    const PhoneNumberField(),
                    const SizedBox(
                      height: MARGIN_MEDIUM_3,
                    ),
                    Consumer<LoginBloc>(
                      builder: (context, bloc, child) => PasswordField(
                        bloc: bloc,
                      ),
                    ),
                    const SizedBox(
                      height: MARGIN_MEDIUM_3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forgot Password",
                          style: GoogleFonts.notoSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: SECONDARY_COLOR),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: MARGIN_XXLARGE_2,
                    ),
                    Consumer<LoginBloc>(
                      builder: (context, bloc, child) =>
                          LoginButton(bloc: bloc),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

class LoginButton extends StatelessWidget {
  LoginBloc bloc;

  LoginButton({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        bloc
            .onTapLogin()
            .then(
              (_) => navigateToScreen(
                context,
                const BottomNavBarView(),
              ),
            )
            .catchError(
              (error) => showSnackBarWithMessage(
                context,
                error.toString(),
              ),
            );
      },
      child: Center(
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
      ),
    );
  }
}

class PasswordField extends StatelessWidget {
  LoginBloc bloc;

  PasswordField({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 330,
      child: TextField(
        onChanged: (password) => bloc.onPasswordChanged(password),
        obscureText: true,
        decoration: InputDecoration(
          hintText: "Enter Your Password",
          hintStyle: GoogleFonts.notoSans(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: const Color.fromRGBO(136, 136, 136, 1),
          ),
        ),
      ),
    );
  }
}

class PhoneNumberField extends StatelessWidget {
  const PhoneNumberField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Enter Your Phone Number",
          style: GoogleFonts.notoSans(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: const Color.fromRGBO(136, 136, 136, 1),
          ),
        ),
        SizedBox(
          width: 300,
          height: 28,
          child: TextField(
            keyboardType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(11),
            ],
            cursorColor: SECONDARY_COLOR,
            decoration: const InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: SECONDARY_COLOR),
              ),
            ),
            style: const TextStyle(
              fontFamily: YORKIE_FONT,
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: SECONDARY_COLOR,
            ),
          ),
        ),
      ],
    );
  }
}

class EmailField extends StatelessWidget {
  LoginBloc bloc;

  EmailField({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Enter Your Email",
          style: GoogleFonts.notoSans(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: const Color.fromRGBO(136, 136, 136, 1),
          ),
        ),
        SizedBox(
          width: 300,
          height: 28,
          child: TextField(
            onChanged: (email) => bloc.onEmailChanged(email),
            cursorColor: SECONDARY_COLOR,
            decoration: const InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: SECONDARY_COLOR),
              ),
            ),
            style: const TextStyle(
              fontFamily: YORKIE_FONT,
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: SECONDARY_COLOR,
            ),
          ),
        ),
      ],
    );
  }
}
