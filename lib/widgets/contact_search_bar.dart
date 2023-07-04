import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';

class ContactSearchBar extends StatelessWidget {
  const ContactSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromRGBO(17, 58, 93, 0.21),
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: MARGIN_MEDIUM,
          ),
          const Column(
            children: [
              SizedBox(
                height: MARGIN_MEDIUM,
              ),
              Icon(
                Icons.search,
                color: PRIMARY_COLOR,
                size: 26,
              ),
            ],
          ),
          const SizedBox(
            width: MARGIN_MEDIUM_2,
          ),
          Expanded(
            child: TextField(
              maxLines: 1,
              decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: GoogleFonts.notoSansMyanmar(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: const Color.fromRGBO(17, 58, 93, 0.5),
                  ),
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none),
            ),
          ),
          Column(
            children: [
              const SizedBox(
                height: MARGIN_MEDIUM,
              ),
              Image.asset(
                "assets/icons/cancel_icon.png",
                width: 12,
              ),
            ],
          ),
          const SizedBox(
            width: MARGIN_MEDIUM_3,
          ),
        ],
      ),
    );
  }
}