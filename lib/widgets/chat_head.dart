import 'package:flutter/material.dart';

class ChatHead extends StatelessWidget {
 double? circleWidth;
 double? circleHeight;
 double? positionedTop;
 double? positionedLeft;
 double? whiteBgWidth;
 double? whiteBgHeight;
 double? greenBgWidth;
 double? greenBgHeight;


 ChatHead(
      {super.key,required this.circleWidth,
        required this.circleHeight,
        required this.positionedTop,
        required this.positionedLeft,
        required this.whiteBgWidth,
        required this.whiteBgHeight,
        required this.greenBgWidth,
        required this.greenBgHeight});

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
            "https://djmag.com/sites/default/files/styles/djm_23_961x540_jpg/public/2022-12/313293606_687343572750643_8093509681171904781_n.jpg?itok=FEtOGQH6",
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
