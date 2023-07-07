import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

import 'package:we_chat_app/data/vos/message_vo.dart';
import 'package:we_chat_app/resources/colors.dart';

import 'package:we_chat_app/resources/dimens.dart';

import '../blocs/chat_bloc.dart';
import '../data/vos/user_vo.dart';
import 'chat_head.dart';

class MessageItemView extends StatelessWidget {
  MessageVO? messageVo;
  ChatBloc bloc;

  MessageItemView({super.key, required this.messageVo, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: (bloc.loggedInUserId == (messageVo?.userId ?? ""))
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        (bloc.loggedInUserId == (messageVo?.userId ?? ""))
            ? Container()
            : ChatHead(
                circleWidth: 30,
                circleHeight: 30,
                positionedTop: 40,
                positionedLeft: 42,
                whiteBgWidth: 20,
                whiteBgHeight: 20,
                greenBgWidth: 16,
                greenBgHeight: 16,
                userProfile: messageVo?.userProfile ?? "",
              ),
        const SizedBox(width: MARGIN_MEDIUM),
        Visibility(
          visible: ((messageVo?.message ?? "").isNotEmpty),
          child: MessageTextView(messageVo: messageVo, bloc: bloc,),
        ),
      ],
    );
  }
}

class MessageTextView extends StatelessWidget {
  const MessageTextView({super.key, required this.bloc,required this.messageVo});
  
  
  final ChatBloc? bloc;
  final MessageVO? messageVo;

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("hh:mm a", "en_US");
    DateTime time = DateTime.fromMillisecondsSinceEpoch(int.parse(messageVo?.timeStamp.toString()??""));
    String timeString = dateFormat.format(time);
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 1.5 / 3,
      ),
      decoration:  BoxDecoration(
        color: ((bloc?.loggedInUserId == (messageVo?.userId ?? "")))?PRIMARY_COLOR:const Color.fromRGBO(243, 243, 243, 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: ((bloc?.loggedInUserId == (messageVo?.userId ?? "")))?CrossAxisAlignment.end:CrossAxisAlignment.start,
          children: [
            Text(
              messageVo?.message ?? "",
              style:  TextStyle(
                color:((bloc?.loggedInUserId == (messageVo?.userId ?? "")))?const Color.fromRGBO(243, 243, 243, 1):PRIMARY_COLOR,
                fontSize: TEXT_REGULAR_2X,
              ),
            ),

            const SizedBox(height: MARGIN_SMALL,),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: ((bloc?.loggedInUserId == (messageVo?.userId ?? "")))?MainAxisAlignment.end:MainAxisAlignment.start,
              children: [
                Text(
                  timeString,
                  style: GoogleFonts.notoSansMyanmar(
                    fontWeight: FontWeight.w400,
                    fontSize: 8,
                    color: ((bloc?.loggedInUserId == (messageVo?.userId ?? "")))?Colors.white:Colors.grey,
                  ),
                ),
                const SizedBox(width: MARGIN_SMALL,),
                ((bloc?.loggedInUserId == (messageVo?.userId ?? "")))?Image.asset(
                  "assets/icons/right_icon.png",
                  width: 16,
                ):Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }

 
}
