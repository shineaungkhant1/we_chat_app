import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_app/blocs/register_bloc.dart';
import 'package:we_chat_app/pages/login_page.dart';
import 'package:we_chat_app/pages/otp_page.dart';
import 'package:we_chat_app/pages/start_up_page.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimens.dart';
import 'package:we_chat_app/resources/images.dart';
import 'package:we_chat_app/resources/strings.dart';
import 'dart:io';

import 'package:we_chat_app/utils/extensions.dart';
import 'package:we_chat_app/viewitems/bottom_nav_bar_view.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool agreedToTerms = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterBloc(),
      child: Scaffold(

        body: Selector<RegisterBloc, bool>(
          selector: (context, bloc) => bloc.isLoading,
          builder: (context, isLoading, child) => SingleChildScrollView(
            child: Stack(
              children:[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50,),
                      child: IconButton(
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          const Text(
                            "Hi !",
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
                            "Create a new account",
                            style: GoogleFonts.notoSansMyanmar(
                                fontSize: 18,
                                color: const Color.fromRGBO(17, 58, 93, 0.7),
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: MARGIN_MEDIUM,
                          ),
                          Text(
                            "Profile",
                            style: GoogleFonts.notoSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromRGBO(136, 136, 136, 1),
                            ),
                          ),
                          const SizedBox(
                            height: MARGIN_MEDIUM + 3,
                          ),
                          Consumer<RegisterBloc>(
                            builder: (context, bloc, child) => UploadProfile(
                              bloc: bloc,
                            ),
                          ),
                          const SizedBox(
                            height: MARGIN_MEDIUM_3,
                          ),
                          Consumer<RegisterBloc>(
                            builder: (context, bloc, child) => PhoneNumberField(bloc: bloc),
                          ),
                          const SizedBox(
                            height: MARGIN_MEDIUM_3,
                          ),
                          Consumer<RegisterBloc>(
                            builder: (context, bloc, child) => EmailField(bloc: bloc),
                          ),
                          const SizedBox(
                            height: MARGIN_MEDIUM_3,
                          ),
                          Consumer<RegisterBloc>(
                              builder: (context, bloc, child) =>
                                  AccountNameField(bloc: bloc)),
                          const SizedBox(
                            height: MARGIN_MEDIUM_3,
                          ),
                          Text(
                            "Date of Birth",
                            style: GoogleFonts.notoSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromRGBO(136, 136, 136, 1),
                            ),
                          ),
                          const SizedBox(
                            height: MARGIN_MEDIUM,
                          ),
                          Consumer<RegisterBloc>(
                            builder: (context, bloc, child) => DateOfBirthSelector(
                              bloc: bloc,
                            ),
                          ),
                          const SizedBox(
                            height: MARGIN_MEDIUM_3,
                          ),
                          Text(
                            "Gender",
                            style: GoogleFonts.notoSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromRGBO(136, 136, 136, 1),
                            ),
                          ),
                          Consumer<RegisterBloc>(
                            builder: (context, bloc, child) => GenderSelector(
                              bloc: bloc,
                            ),
                          ),
                          const SizedBox(
                            height: MARGIN_MEDIUM_3,
                          ),
                          SizedBox(
                            width: 300,
                            child: Consumer<RegisterBloc>(
                              builder: (context, bloc, child) =>
                                  PasswordField(bloc: bloc),
                            ),
                          ),
                          const SizedBox(
                            height: MARGIN_LARGE,
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: agreedToTerms,
                                activeColor: SECONDARY_COLOR,
                                onChanged: (value) {
                                  setState(() {
                                    agreedToTerms = value!;
                                  });
                                },
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Agree to ',
                                  style: GoogleFonts.notoSansMyanmar(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: const Color.fromRGBO(6, 39, 67, 0.5)),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Terms and Services',
                                      style: GoogleFonts.notoSansMyanmar(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                          color: SECONDARY_COLOR),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: MARGIN_XXLARGE_2,),
                          Consumer<RegisterBloc>(
                            builder: (context, bloc, child) => Center(
                              child: SignUpButton(
                                bloc: bloc,
                              ),
                            ),
                          ),
                          SizedBox(height: MARGIN_XXLARGE_3,),
                        ],
                      ),
                    ),
                  ],
                ),
                const Positioned(
                      top: 50,
                      right:-75,
                      child: GreenCircle(),
                    ),
                    Positioned(
                      bottom: 20,
                      right: 15,
                      child: Image.asset(
                        CURLY_LINE_LOGO,
                        width: 30,
                      ),
                    ),
                    Positioned(
                      bottom: 140,
                      right: 0,
                      child: Image.asset(
                        SEMI_CIRCLE_LOGO,
                        width: 22,
                      ),
                    ),
                    Positioned(
                      bottom: 50,
                      left: 15,
                      child: Image.asset(
                        TRIANGLE_LOGO,
                        width: 26,
                      ),
                    ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}

class GreenCircle extends StatelessWidget {
  const GreenCircle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 170,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.center,
          colors: [
            Color.fromRGBO(161, 255, 201, 0),
            Color.fromRGBO(126, 255, 181, 1),
            Color.fromRGBO(126, 255, 181, 1),
          ],
        ),
      ),
    );
  }
}

class PasswordField extends StatelessWidget {
  RegisterBloc bloc;

  PasswordField({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (password) => bloc.onPasswordChanged(password),
      obscureText: true,
      decoration: const InputDecoration(
        hintText: "Password",
      ),
    );
  }
}

class UploadProfile extends StatelessWidget {
  RegisterBloc bloc;

  UploadProfile({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (bloc.userProfile == null)
          ? GestureDetector(
              child: const CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(
                  "https://socialistmodernism.com/wp-content/uploads/2017/07/placeholder-image.png?w=640",
                ),
                radius: 50,
              ),
              onTap: () async {
                final ImagePicker picker = ImagePicker();
                // Pick an image
                final XFile? image =
                    await picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  bloc.onImageChosen(
                    File(image.path),
                  );
                }
              },
            )
          : CircleAvatar(
              radius: 50, // Set the desired radius value to make it bigger
              backgroundColor: Colors.transparent,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: FileImage(
                      bloc.userProfile ?? File(""),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
    );
  }
}

class SignUpButton extends StatelessWidget {
  RegisterBloc bloc;

  SignUpButton({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        bloc
            .onTapRegister()
            .then(
              (value) => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const BottomNavBarView(),),),
            )
            .catchError(
              (error) => showSnackBarWithMessage(
                context,
                error.toString(),
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
            "Sign Up",
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

class DateOfBirthSelector extends StatefulWidget {
  final RegisterBloc bloc;

  const DateOfBirthSelector({super.key, required this.bloc});

  @override
  _DateOfBirthSelectorState createState() => _DateOfBirthSelectorState();
}

class _DateOfBirthSelectorState extends State<DateOfBirthSelector> {
  String selectedDate = 'Day';
  String selectedMonth = 'Month';
  String selectedYear = 'Year';

  List<String> dates =
      ['Day'] + List.generate(31, (index) => (index + 1).toString());
  List<String> months = [
    'Month',
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  List<String> years =
      ['Year'] + List.generate(50, (index) => (2023 - index).toString());

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.white,
          child: DropdownButton<String>(
            value: widget.bloc.selectedDate,
            onChanged: (String? newValue) {
              setState(() {
                widget.bloc.selectedDate = newValue!;
              });
            },
            items: dates.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(
                    fontFamily: YORKIE_FONT,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: SECONDARY_COLOR,
                  ),
                ),
              );
            }).toList(),
            icon: const Icon(
              Icons.arrow_drop_down,
              color: SECONDARY_COLOR,
            ),
          ),
        ),
        const SizedBox(
          width: MARGIN_XLARGE,
        ),
        // Month
        Container(
          color: Colors.white,
          child: DropdownButton<String>(
            value: widget.bloc.selectedMonth,
            onChanged: (String? newValue) {
              setState(() {
                widget.bloc.selectedMonth = newValue!;
              });
            },
            items: months.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(
                    fontFamily: YORKIE_FONT,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: SECONDARY_COLOR,
                  ),
                ),
              );
            }).toList(),
            icon: const Icon(
              Icons.arrow_drop_down,
              color: SECONDARY_COLOR,
            ),
          ),
        ),
        const SizedBox(
          width: MARGIN_XLARGE,
        ),
        // Year
        Container(
          color: Colors.white,
          child: DropdownButton<String>(
            value: widget.bloc.selectedYear,
            onChanged: (String? newValue) {
              setState(() {
                widget.bloc.selectedYear = newValue!;
              });
            },
            items: years.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(
                    fontFamily: YORKIE_FONT,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: SECONDARY_COLOR,
                  ),
                ),
              );
            }).toList(),
            icon: const Icon(
              Icons.arrow_drop_down,
              color: SECONDARY_COLOR,
            ),
          ),
        ),
      ],
    );
  }
}

class GenderSelector extends StatefulWidget {
  RegisterBloc bloc;

  GenderSelector({required this.bloc});

  @override
  State<GenderSelector> createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  String selectedGender = '';
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Radio<String>(
              value: 'Male',
              activeColor: SECONDARY_COLOR,
              autofocus: true,
              groupValue: widget.bloc.selectedGender,
              onChanged: (value) {
                setState(() {
                  widget.bloc.selectedGender = value!;
                });
              },
            ),
            const Text(
              'Male',
              style: TextStyle(
                fontFamily: YORKIE_FONT,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: SECONDARY_COLOR,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Radio<String>(
              value: 'Female',
              activeColor: SECONDARY_COLOR,
              groupValue: widget.bloc.selectedGender,
              onChanged: (value) {
                setState(() {
                  widget.bloc.selectedGender = value!;
                });
              },
            ),
            const Text(
              'Female',
              style: TextStyle(
                fontFamily: YORKIE_FONT,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: SECONDARY_COLOR,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Radio<String>(
              value: 'Other',
              activeColor: SECONDARY_COLOR,
              groupValue: widget.bloc.selectedGender,
              onChanged: (value) {
                setState(() {
                  widget.bloc.selectedGender = value!;
                });
              },
            ),
            const Text(
              'Other',
              style: TextStyle(
                fontFamily: YORKIE_FONT,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: SECONDARY_COLOR,
              ),
            ),
          ],
        ),
      ],
    );
  }
}


class PhoneNumberField extends StatelessWidget {
  RegisterBloc bloc;


  PhoneNumberField({required this.bloc});

  @override
  Widget build(BuildContext context) {
    return   Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Phone Number",
          style: GoogleFonts.notoSans(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: const Color.fromRGBO(136, 136, 136, 1),
          ),
        ),
        SizedBox(
          width: 230,
          child: TextField(
            onChanged: (phoneNumber) => bloc.onPhoneNumberChanged(phoneNumber),
            keyboardType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(11),
            ],
            cursorColor: SECONDARY_COLOR,
            decoration: InputDecoration(
              hintStyle: GoogleFonts.notoSansMyanmar(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Colors.grey),
              focusedBorder: const UnderlineInputBorder(
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
  RegisterBloc bloc;

  EmailField({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Email",
          style: GoogleFonts.notoSans(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: const Color.fromRGBO(136, 136, 136, 1),
          ),
        ),
        SizedBox(
          width: 300,
          height: 30,
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
                color: SECONDARY_COLOR),
          ),
        ),
      ],
    );
  }
}

class AccountNameField extends StatelessWidget {
  RegisterBloc bloc;

  AccountNameField({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Name",
          style: GoogleFonts.notoSans(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: const Color.fromRGBO(136, 136, 136, 1),
          ),
        ),
        SizedBox(
          width: 300,
          height: 30,
          child: TextField(
            onChanged: (userName) => bloc.onUserNameChanged(userName),
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
                color: SECONDARY_COLOR),
          ),
        ),
      ],
    );
  }
}
