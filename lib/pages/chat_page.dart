import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:we_chat_app/pages/convo_page.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimens.dart';
import 'package:we_chat_app/resources/strings.dart';

import '../widgets/chat_head.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "Chats",
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
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  )),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              "Active Now",
              style: GoogleFonts.notoSansMyanmar(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: const Color.fromRGBO(17, 58, 93, 0.5),
              ),
            ),
          ),
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context)
                  .size
                  .width, // Set the maximum width to the screen width
            ),
            height: 100,
            child: ListView.builder(
              padding: const EdgeInsets.only(left: MARGIN_LARGE),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return const ActiveNowChatHead();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ConvoPage(),
                  ),
                );
              },
              child: Container(
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
                        greenBgHeight: 16,
                      ),
                      const SizedBox(
                        width: MARGIN_MEDIUM,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Martin Garrix",
                            style: GoogleFonts.notoSansMyanmar(
                              color: PRIMARY_COLOR,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "You sent a Video",
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
                            "5min",
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
              ),
            ),
          ),
          const SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Container(
              height: 88,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      width: MARGIN_MEDIUM,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Martin Garrix",
                          style: GoogleFonts.notoSansMyanmar(
                            color: PRIMARY_COLOR,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "You sent a Video",
                          style: GoogleFonts.notoSansMyanmar(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 114,
                    ),
                    const SizedBox(
                      height: MARGIN_MEDIUM,
                    ),
                    Text(
                      "12/2/2022",
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: PRIMARY_COLOR),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Container(
              height: 88,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
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
                    ),
                    const SizedBox(
                      width: MARGIN_MEDIUM,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Martin Garrix",
                          style: GoogleFonts.notoSansMyanmar(
                            color: PRIMARY_COLOR,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "You sent a Video",
                          style: GoogleFonts.notoSansMyanmar(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 114,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: MARGIN_MEDIUM,
                        ),
                        Text(
                          "13/2/2002",
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: PRIMARY_COLOR),
                        ),
                        const SizedBox(
                          height: MARGIN_MEDIUM_2,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: MARGIN_XLARGE_2,
                            ),
                            Image.asset(
                              "assets/icons/one_right_icon.png",
                              width: 14,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Container(
              height: 88,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
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
                        Positioned(
                          top: 45,
                          left: 30,
                          child: Container(
                            width: 33,
                            height: 15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: const Color.fromRGBO(241, 241, 241, 1),
                            ),
                            child: Center(
                              child: Text(
                                "15 mim",
                                style: GoogleFonts.inter(
                                    fontSize: 7, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: MARGIN_MEDIUM,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Martin Garrix",
                          style: GoogleFonts.notoSansMyanmar(
                            color: PRIMARY_COLOR,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "You sent a Video",
                          style: GoogleFonts.notoSansMyanmar(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 122.4,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: MARGIN_MEDIUM,
                        ),
                        Text(
                          "5/2/2022",
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: PRIMARY_COLOR),
                        ),
                        const SizedBox(
                          height: MARGIN_MEDIUM_2,
                        ),
                        const Row(
                          children: [
                            SizedBox(
                              width: MARGIN_XLARGE,
                            ),
                            Icon(
                              Icons.notifications_off_outlined,
                              size: 20,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ActiveNowChatHead extends StatelessWidget {
  const ActiveNowChatHead({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                "Martin Garrix",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.notoSansMyanmar(
                  color: PRIMARY_COLOR,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
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
