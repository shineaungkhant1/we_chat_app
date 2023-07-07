import 'package:flutter/material.dart';

import '../blocs/chat_bloc.dart';
import '../data/vos/message_vo.dart';
import '../data/vos/user_vo.dart';

class ChatHead extends StatelessWidget {
  double? circleWidth;
  double? circleHeight;
  double? positionedTop;
  double? positionedLeft;
  double? whiteBgWidth;
  double? whiteBgHeight;
  double? greenBgWidth;
  double? greenBgHeight;

  String? userProfile;

  ChatHead(
      {super.key,
      required this.circleWidth,
      required this.circleHeight,
      required this.positionedTop,
      required this.positionedLeft,
      required this.whiteBgWidth,
      required this.whiteBgHeight,
      required this.greenBgWidth,
      required this.greenBgHeight,
      required this.userProfile});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: circleWidth,
          height: circleHeight,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.network(
           userProfile??"",
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: positionedTop,
          left: positionedLeft,
          child: Container(
            width: whiteBgWidth,
            height: whiteBgHeight,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Center(
              child: Container(
                width: greenBgWidth,
                height: greenBgHeight,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
