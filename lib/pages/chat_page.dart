import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_app/blocs/chat_bloc.dart';
import 'package:we_chat_app/blocs/contact_bloc.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';
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
  UserVO? userVO;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContactBloc(userVO??UserVO()),
      child: Scaffold(
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
            Consumer<ContactBloc>(
              builder: (context, bloc, child) => Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context)
                      .size
                      .width, // Set the maximum width to the screen width
                ),
                height: 100,
                child: ListView.separated(
                  padding: const EdgeInsets.only(left: MARGIN_LARGE),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: bloc.alphabetsStartByName?.length ?? 0,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          _navigateToChatRoomPage(
                              context, bloc.contactUsers?[index]);
                        },
                        child:
                            ActiveNowChatHead(user: bloc.contactUsers?[index]));
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      width: MARGIN_LARGE,
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Placeholder(),
            ),
          ],
        ),
      ),
    );
  }
}

class ActiveNowChatHead extends StatelessWidget {
  final UserVO? user;

  ActiveNowChatHead({required this.user});

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
                user?.userProfile ?? "",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: Text(
                user?.userName ?? "",
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

void _navigateToChatRoomPage(BuildContext context, UserVO? user) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ConvoPage(
        userVO: user,
      ),
    ),
  );
}
