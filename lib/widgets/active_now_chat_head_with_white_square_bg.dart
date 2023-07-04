import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../resources/colors.dart';

class ActiveNowChatHeadWithWhiteSquareBg extends StatelessWidget {
  const ActiveNowChatHeadWithWhiteSquareBg({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(
                      "https://djmag.com/sites/default/files/styles/djm_23_961x540_jpg/public/2022-12/313293606_687343572750643_8093509681171904781_n.jpg?itok=FEtOGQH6",
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: 100,
                    child: Text(
                      "Martin Garrix Martin Garrix Martin Garrix Martin Garrix Martin Garrix Martin Garrix",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.notoSansMyanmar(
                        color: PRIMARY_COLOR,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        height: 1.1
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 55,
          left: 65,
          child: Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Center(
              child: Container(
                width: 16,
                height: 16,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 95,
          child: Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
            child: Center(
              child:  Image.asset(
                "assets/icons/cancel_icon.png",
                width: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
