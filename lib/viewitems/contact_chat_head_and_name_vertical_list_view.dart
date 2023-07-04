import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:we_chat_app/resources/dimens.dart';

import '../data/vos/user_vo.dart';
import '../resources/colors.dart';

class ContactChatHeadAndNameVerticalListView extends StatefulWidget {
  bool isAddNewGroupPage;
  final UserVO? user;

  ContactChatHeadAndNameVerticalListView(
      {super.key,
      this.isAddNewGroupPage = false,
      required this.user,
     });

  @override
  State<ContactChatHeadAndNameVerticalListView> createState() =>
      _ContactChatHeadAndNameVerticalListViewState();
}

class _ContactChatHeadAndNameVerticalListViewState
    extends State<ContactChatHeadAndNameVerticalListView> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Row(
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
                widget.user?.userProfile??"",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: MARGIN_XLARGE,
            ),
            Text(
              widget.user?.userName??"",
              style: GoogleFonts.notoSansMyanmar(
                color: PRIMARY_COLOR,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              width: MARGIN_XXLARGE_3 + 48,
            ),
            Visibility(
              visible: widget.isAddNewGroupPage,
              child: CircularCheckbox(
                value: isSelected,
                activeColor: SECONDARY_COLOR,
                onChanged: (value) {
                  setState(() {
                    isSelected = value!;
                  });
                },
              ),
            ),
          ],
        ),
        Positioned(
          top: 40,
          left: 42,
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
      ],
    );
  }
}

class CircularCheckbox extends StatelessWidget {
  final bool value;
  final Color activeColor;
  final ValueChanged<bool?>? onChanged;

  const CircularCheckbox({
    Key? key,
    required this.value,
    required this.activeColor,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged?.call(!value);
      },
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: value ? activeColor : Colors.grey,
            width: 2.0,
          ),
          color: value ? activeColor : Colors.transparent,
        ),
        child: value
            ? const Icon(
                Icons.check,
                size: 16.0,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}
