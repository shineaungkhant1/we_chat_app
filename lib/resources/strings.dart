import 'package:flutter/cupertino.dart';


/// Auth
const LBL_LOGIN = "Login";
const LBL_REGISTER = "Register";
const LBL_EMAIL = "Email";
const HINT_EMAIL = "Please enter your email";
const LBL_PASSWORD = "Password";
const HINT_PASSWORD = "Please enter your password";
const LBL_USER_NAME = "User Name";
const HINT_USER_NAME = "Please enter your user name";
const LBL_ALREADY_HAVE_AN_ACCOUNT = "Already have an account?";
const LBL_DONT_HAVE_AN_ACCOUNT = "Dont't have an account?";
const LBL_OR = "OR";

/// Post
const LBL_POST = "POST";

/// Font
const YORKIE_FONT="Yorkie";


FocusNode focusNodeOne = FocusNode();

FocusNode focusNodeTwo = FocusNode();

FocusNode focusNodeThree = FocusNode();

FocusNode focusNodeFour = FocusNode();

TextEditingController textEditingControllerOne = TextEditingController();
TextEditingController textEditingControllerTwo = TextEditingController();
TextEditingController textEditingControllerThree = TextEditingController();
TextEditingController textEditingControllerFour = TextEditingController();


List<FocusNode> focusNodeList = [
  focusNodeOne,
  focusNodeTwo,
  focusNodeThree,
  focusNodeFour,
];

List<TextEditingController> textEditingControllerList = [
  textEditingControllerOne,
  textEditingControllerTwo,
  textEditingControllerThree,
  textEditingControllerFour,

];
