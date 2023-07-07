import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:we_chat_app/data/vos/message_vo.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';
import 'chat_head.dart';

class RecentChatItemsView extends StatelessWidget {
  String? userProfile;
  String? userName;
  String? message;
  final MessageVO? messageVO;


  RecentChatItemsView(
      {super.key, required this.userProfile,required this.userName, required this.message,required this.messageVO});

  @override
  Widget build(BuildContext context) {

    DateFormat dateFormat = DateFormat("hh:mm a", "en_US");
    DateTime time = DateTime.fromMillisecondsSinceEpoch(int.parse(messageVO?.timeStamp.toString()??""));
    String timeString = dateFormat.format(time);

    return Container(
      height: 88,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white),
      child: Padding(
        padding:
        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ChatHead(
              circleWidth: 60,
              circleHeight: 60,
              positionedTop: 40,
              positionedLeft: 42,
              whiteBgWidth: 20,
              whiteBgHeight: 20,
              greenBgWidth: 16,
              greenBgHeight: 16, userProfile:userProfile ,
            ),
            const SizedBox(
              width: MARGIN_MEDIUM,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                 userName??"",
                  style: GoogleFonts.notoSansMyanmar(
                    color: PRIMARY_COLOR,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                Text(
                  message??"",
                  style: GoogleFonts.notoSansMyanmar(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 147.4,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: MARGIN_MEDIUM,
                ),
                Text(
                  timeString,
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: PRIMARY_COLOR),
                ),
                const SizedBox(
                  height: MARGIN_MEDIUM_2,
                ),
                Image.asset(
                  "assets/icons/right_icon.png",
                  width: 21,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
