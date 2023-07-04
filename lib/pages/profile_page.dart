import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:we_chat_app/blocs/profile_bloc.dart';
import 'package:we_chat_app/pages/start_up_page.dart';
import 'package:we_chat_app/viewitems/moment_items_view.dart';
import '../data/vos/user_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import 'package:we_chat_app/utils/extensions.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isImageTapped = false;

  UserVO? userVO;

  void showImageDialog(QrImageView qrImageView) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: SizedBox(
            height: 150,
            width: 150,
            child: Center(
              child: qrImageView,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileBloc(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            "Me",
            style: TextStyle(
              fontFamily: YORKIE_FONT,
              fontWeight: FontWeight.w600,
              fontSize: 34,
              color: PRIMARY_COLOR,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 8, right: 16, bottom: 8),
              child: Container(
                width: 40,
                decoration: BoxDecoration(
                  color: PRIMARY_COLOR,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => ProfileEditView());
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: PRIMARY_COLOR),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ProfileImageField(),
                            SizedBox(
                              width: MARGIN_MEDIUM_3,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                UserNameField(),
                                SizedBox(
                                  height: MARGIN_SMALL,
                                ),
                                PhoneNumberField(),
                                SizedBox(
                                  height: MARGIN_SMALL,
                                ),
                                DateOfBirthField(),
                                SizedBox(
                                  height: MARGIN_SMALL,
                                ),
                                GenderField(),
                              ],
                            )
                          ],
                        ),
                        const Positioned(
                          top: 100,
                          left: 5,
                          child: Icon(
                            Icons.image_outlined,
                            color: Colors.white,
                          ),
                        ),
                        Consumer<ProfileBloc>(
                          builder: (context, bloc, child) => Positioned(
                            top: 75,
                            left: 73,
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isImageTapped = true;
                                    print("QRCODE=======>${bloc.qrCode}");
                                  });
                                  showImageDialog(
                                    QrImageView(
                                      data: bloc.qrCode,
                                      version: QrVersions.auto,
                                      size: 150,
                                    ),
                                  );
                                },
                                child: QrImageView(
                                  data: bloc.qrCode,
                                  version: QrVersions.auto,
                                  size: 55,
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: MARGIN_MEDIUM_3,
                ),
                const Text(
                  "Bookmarked Moments",
                  style: TextStyle(
                      fontFamily: YORKIE_FONT,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: PRIMARY_COLOR,
                      decoration: TextDecoration.underline),
                ),
                const SizedBox(
                  height: MARGIN_MEDIUM_3,
                ),
                //const MomentItemsView(),
              ],
            ),
          ),
        ),
        floatingActionButton: Container(
            decoration: BoxDecoration(
                color: PRIMARY_COLOR, borderRadius: BorderRadius.circular(30)),
            child: Consumer<ProfileBloc>(
              builder: (context, bloc, child) => IconButton(
                onPressed: () {
                  bloc.onTapLogout().then(
                        (_) => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const StartUpPage(),
                          ),
                        ),
                      );
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
              ),
            )),
      ),
    );
  }
}

class GenderField extends StatelessWidget {
  const GenderField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileBloc>(
      builder: (context, bloc, child) => Row(
        children: [
          Image.asset(
            "assets/icons/direction_icon.png",
            width: 24,
          ),
          const SizedBox(
            width: MARGIN_MEDIUM,
          ),
          Text(
            bloc.gender,
            style: GoogleFonts.notoSansMyanmar(
                fontWeight: FontWeight.w400, fontSize: 14, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class DateOfBirthField extends StatelessWidget {
  const DateOfBirthField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileBloc>(
      builder: (context, bloc, child) => Row(
        children: [
          const Icon(
            Icons.calendar_month,
            color: Colors.white,
          ),
          const SizedBox(
            width: MARGIN_MEDIUM,
          ),
          Text(
            bloc.dateOfBirth,
            style: GoogleFonts.notoSansMyanmar(
                fontWeight: FontWeight.w400, fontSize: 14, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class PhoneNumberField extends StatelessWidget {
  const PhoneNumberField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileBloc>(
      builder: (context, bloc, child) => Row(
        children: [
          const Icon(
            Icons.phone_android,
            color: Colors.white,
          ),
          const SizedBox(
            width: MARGIN_MEDIUM,
          ),
          Text(
            bloc.phoneNumber,
            style: GoogleFonts.notoSansMyanmar(
                fontWeight: FontWeight.w400, fontSize: 14, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class UserNameField extends StatelessWidget {
  const UserNameField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileBloc>(
      builder: (context, bloc, child) => Text(
        bloc.userName,
        style: TextStyle(
            fontFamily: YORKIE_FONT,
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.white),
      ),
    );
  }
}

class ProfileImageField extends StatelessWidget {
  const ProfileImageField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileBloc>(
        builder: (context, bloc, child) => Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: 45,
                backgroundImage: NetworkImage(
                  (bloc.userProfile.isNotEmpty)
                      ? bloc.userProfile
                      : "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                ),
              ),
            ));
  }
}

class ProfileEditView extends StatelessWidget {
  const ProfileEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: 340,
        height: 410,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
          child: Column(
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
              const SizedBox(
                width: 300,
                height: 30,
                child: TextField(
                  cursorColor: SECONDARY_COLOR,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: SECONDARY_COLOR),
                    ),
                  ),
                  style: TextStyle(
                      fontFamily: YORKIE_FONT,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: SECONDARY_COLOR),
                ),
              ),
              const SizedBox(
                height: MARGIN_MEDIUM_3,
              ),
              Text(
                "Phone Number",
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
              // const DateOfBirthSelector(),
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
              // const GenderSelector(),
              const SizedBox(
                height: MARGIN_MEDIUM_3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: PRIMARY_COLOR),
                        borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
                      ),
                      child: const Center(
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: PRIMARY_COLOR,
                            fontFamily: YORKIE_FONT,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ProfilePage(),
                        ),
                      );
                    },
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        color: PRIMARY_COLOR,
                        border: Border.all(color: PRIMARY_COLOR),
                        borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
                      ),
                      child: const Center(
                        child: Text(
                          "Save",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: YORKIE_FONT,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
