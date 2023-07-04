import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_app/pages/sign_up_page.dart';
import 'package:we_chat_app/utils/extensions.dart';
import 'package:we_chat_app/viewitems/bottom_nav_bar_view.dart';
import 'package:we_chat_app/pages/moment_page.dart';
import 'package:we_chat_app/resources/images.dart';

import '../blocs/otp_bloc.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  List<FocusNode> focusNodeList = [];
  List<TextEditingController> textEditingControllerList = [];

  @override
  void initState() {
    super.initState();
    focusNodeList = List.generate(4, (_) => FocusNode());
    textEditingControllerList = List.generate(4, (_) => TextEditingController());
  }

  @override
  void dispose() {
    for (var focusNode in focusNodeList) {
      focusNode.dispose();
    }
    for (var controller in textEditingControllerList) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OTPBloc(),
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: MARGIN_XLARGE_2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: MARGIN_MEDIUM_3,
                ),
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
                      fontSize: 13,
                      color: const Color.fromRGBO(17, 58, 93, 0.7),
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: MARGIN_XXLARGE,
                ),
                Center(
                  child: Image.asset(
                    PEOPLE_WITH_CALCULATOR_LOGO,
                    width: 236,
                  ),
                ),
                const SizedBox(
                  height: MARGIN_XLARGE,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(11),
                        ],
                        cursorColor: SECONDARY_COLOR,
                        decoration: InputDecoration(
                          hintText: "Enter Your Phone Number",
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
                    Column(
                      children: [
                        const SizedBox(
                          height: 18,
                        ),
                        Container(
                          width: 76,
                          height: 37,
                          decoration: BoxDecoration(
                            color: PRIMARY_COLOR,
                            border: Border.all(color: PRIMARY_COLOR),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: const Center(
                            child: Text(
                              "Get OTP",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: YORKIE_FONT,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: MARGIN_XLARGE,
                ),
                Consumer<OTPBloc>(
                  builder: (context, bloc, child) => OTPBox(
                    focusNodeList: focusNodeList,
                    textEditingControllerList: bloc.textEditControllerList,
                    onOTPChanged: (enteredOTP) {
                      bloc.setOTP(enteredOTP);
                    },
                  ),
                ),
                const SizedBox(
                  height: MARGIN_XLARGE,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text(
                      "Dont receive the OTP? ",
                      style: GoogleFonts.notoSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(153, 153, 153, 1),
                      ),
                    ),
                    Text(
                      " Resend Code",
                      style: GoogleFonts.notoSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: PRIMARY_COLOR,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: MARGIN_XLARGE,
                ),
                Consumer<OTPBloc>(
                  builder: (context, bloc, child) => VerifyButton(bloc: bloc),
                ),
                SizedBox(height:MARGIN_MEDIUM_3 ,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VerifyButton extends StatelessWidget {
  final OTPBloc bloc;

  const VerifyButton({Key? key, required this.bloc}) : super(key: key);

  Future<bool> verifyOTPAsync() async {
    final enteredOTP = bloc.textEditControllerList.map((controller) => controller.text).join('');
    print("EnterOTP==========================================>$enteredOTP");


    final snapshot = await FirebaseFirestore.instance.collection('otp').doc('S98htxpBD19It2Vv4DlD').get();
    final data = snapshot.data();

    String storedOTP = data?['code'].toString()??"";
    print("StoreOTP==========================================>$storedOTP");

    return enteredOTP == storedOTP;

  }

  void verifyOTP(BuildContext context) {
    bloc.onTapOTP().then((_) async {
      bool isOTPVerified = await verifyOTPAsync();
      print("Verify=============>$isOTPVerified");
      if (isOTPVerified) {
        navigateToScreen(context, const SignUpPage());
      } else {
        showSnackBarWithMessage(context, "Invalid OTP");
      }
    }).catchError((error) {
      showSnackBarWithMessage(context, error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        verifyOTP(context);
        // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BottomNavBarView()),);
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
              "Verify",
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




class OTPBox extends StatefulWidget {
  const OTPBox({
    Key? key,
    required this.focusNodeList,
    required this.textEditingControllerList,
    required this.onOTPChanged,
  }) : super(key: key);

  final List<FocusNode> focusNodeList;
  final List<TextEditingController> textEditingControllerList;
  final void Function(String) onOTPChanged;

  @override
  _OTPBoxState createState() => _OTPBoxState();
}

class _OTPBoxState extends State<OTPBox> {
  String getEnteredOTP() {
    return widget.textEditingControllerList
        .map((controller) => controller.text)
        .join();
  }

  void checkEnteredOTP() {
    String enteredOTP = getEnteredOTP();
    print("Entered OTP: $enteredOTP");
    widget.onOTPChanged(enteredOTP);
  }

  @override
  void initState() {
    super.initState();
    for (var controller in widget.textEditingControllerList) {
      controller.addListener(checkEnteredOTP);
    }
  }

  @override
  void dispose() {
    for (var controller in widget.textEditingControllerList) {
      controller.removeListener(checkEnteredOTP);
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          4,
              (index) => SizedBox(
            width: 45,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(219, 219, 219, 1.0),
                    offset: Offset(0, 3),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: TextField(
                focusNode: widget.focusNodeList[index],
                controller: widget.textEditingControllerList[index],
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                ],
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    widget.focusNodeList[index].unfocus();
                    if (index < widget.focusNodeList.length - 1) {
                      widget.focusNodeList[index + 1].requestFocus();
                    }
                  } else if (value.isEmpty) {
                    widget.focusNodeList[index].unfocus();
                    if (index > 0) {
                      widget.focusNodeList[index - 1].requestFocus();
                    }
                  }
                  checkEnteredOTP();
                },
                keyboardType: TextInputType.number,
                cursorColor: Colors.white,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "*",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
