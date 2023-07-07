import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_app/blocs/chat_bloc.dart';
import 'package:we_chat_app/data/vos/message_vo.dart';
import 'package:we_chat_app/resources/dimens.dart';
import 'package:we_chat_app/widgets/chat_head.dart';

import '../data/vos/user_vo.dart';
import '../resources/colors.dart';
import '../widgets/message_item_view.dart';

class ConvoPage extends StatefulWidget {
  final UserVO? userVO;

  ConvoPage({required this.userVO});

  @override
  State<ConvoPage> createState() => _ConvoPageState();
}

class _ConvoPageState extends State<ConvoPage> {
  int? selectedButton;
  MessageVO? messageVO;
  bool isOpenFunctionView = false;
  TextEditingController _controller = TextEditingController();
  FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatBloc(widget.userVO),
      child: Selector<ChatBloc, bool>(
        selector: (context, bloc) => bloc.isLoading,
        builder: (context, isLoading, child) => Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_outlined,
                size: 36,
                color: PRIMARY_COLOR,
              ),
            ),
            title: Row(
              children: [
                ChatHead(
                  userProfile: widget.userVO?.userProfile,
                  circleWidth: 45,
                  circleHeight: 45,
                  positionedTop: 30,
                  positionedLeft: 30,
                  whiteBgWidth: 16,
                  whiteBgHeight: 16,
                  greenBgWidth: 12,
                  greenBgHeight: 12,
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.userVO?.userName ?? "",
                      style: GoogleFonts.notoSansMyanmar(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: PRIMARY_COLOR),
                    ),
                    Text(
                      "Online",
                      style: GoogleFonts.notoSansMyanmar(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: PRIMARY_COLOR),
                    ),
                  ],
                )
              ],
            ),
            titleSpacing: 0,
            actions: const [
              Icon(
                Icons.more_vert,
                color: PRIMARY_COLOR,
                size: 33,
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(
                //   height: 650,
                //   child: ListView(
                //     shrinkWrap: true,
                //     physics: const AlwaysScrollableScrollPhysics(),
                //     children: [
                //       Center(
                //         child: Text(
                //           "Today",
                //           style: GoogleFonts.notoSansMyanmar(
                //             fontWeight: FontWeight.w400,
                //             fontSize: 14,
                //             color: const Color.fromRGBO(153, 153, 153, 1),
                //           ),
                //         ),
                //       ),
                //       const SizedBox(
                //         height: MARGIN_MEDIUM_2,
                //       ),
                //       Row(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           // ChatHead(
                //           //   circleWidth: 45,
                //           //   circleHeight: 45,
                //           //   positionedTop: 30,
                //           //   positionedLeft: 30,
                //           //   whiteBgWidth: 16,
                //           //   whiteBgHeight: 16,
                //           //   greenBgWidth: 12,
                //           //   greenBgHeight: 12, messageVO: widget.userVO,
                //           // ),
                //           const SizedBox(
                //             width: MARGIN_MEDIUM,
                //           ),
                //           Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Container(
                //                 color: const Color.fromRGBO(243, 243, 243, 1),
                //                 child: Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Column(
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.start,
                //                     children: [
                //                       Text(
                //                         "How are you?",
                //                         style: GoogleFonts.notoSansMyanmar(
                //                           fontWeight: FontWeight.w400,
                //                           fontSize: 16,
                //                           color: PRIMARY_COLOR,
                //                         ),
                //                       ),
                //                       const SizedBox(
                //                         height: MARGIN_SMALL,
                //                       ),
                //                       Text(
                //                         "12:30AM",
                //                         style: GoogleFonts.notoSansMyanmar(
                //                           fontWeight: FontWeight.w400,
                //                           fontSize: 8,
                //                           color: PRIMARY_COLOR,
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //               const SizedBox(
                //                 height: MARGIN_SMALL,
                //               ),
                //               Container(
                //                 color: const Color.fromRGBO(243, 243, 243, 1),
                //                 child: Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Column(
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.start,
                //                     children: [
                //                       Text(
                //                         "What do you do?",
                //                         style: GoogleFonts.notoSans(
                //                           fontWeight: FontWeight.w400,
                //                           fontSize: 16,
                //                           color: PRIMARY_COLOR,
                //                         ),
                //                       ),
                //                       const SizedBox(
                //                         height: MARGIN_SMALL,
                //                       ),
                //                       Text(
                //                         "12:30AM",
                //                         style: GoogleFonts.dmSans(
                //                           fontWeight: FontWeight.w400,
                //                           fontSize: 8,
                //                           color: PRIMARY_COLOR,
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           )
                //         ],
                //       ),
                //       const SizedBox(
                //         height: MARGIN_MEDIUM,
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.end,
                //         children: [
                //           Column(
                //             crossAxisAlignment: CrossAxisAlignment.end,
                //             children: [
                //               Container(
                //                 color: PRIMARY_COLOR,
                //                 child: Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Column(
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.end,
                //                     children: [
                //                       Text(
                //                         "I am chatting a robot",
                //                         style: GoogleFonts.dmSans(
                //                           fontWeight: FontWeight.w400,
                //                           fontSize: 15,
                //                           color: Colors.white,
                //                         ),
                //                       ),
                //                       const SizedBox(
                //                         height: MARGIN_SMALL,
                //                       ),
                //                       Row(
                //                         crossAxisAlignment:
                //                             CrossAxisAlignment.start,
                //                         children: [
                //                           Text(
                //                             "12:30AM",
                //                             style:
                //                                 GoogleFonts.notoSansMyanmar(
                //                               fontWeight: FontWeight.w400,
                //                               fontSize: 8,
                //                               color: Colors.white,
                //                             ),
                //                           ),
                //                           const SizedBox(
                //                             width: MARGIN_SMALL,
                //                           ),
                //                           Image.asset(
                //                             "assets/icons/right_icon.png",
                //                             width: 16,
                //                           ),
                //                         ],
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //               const SizedBox(
                //                 height: MARGIN_SMALL,
                //               ),
                //               Container(
                //                 color: PRIMARY_COLOR,
                //                 child: Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Column(
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.end,
                //                     children: [
                //                       Text(
                //                         "I am find and You",
                //                         style: GoogleFonts.dmSans(
                //                           fontWeight: FontWeight.w400,
                //                           fontSize: 15,
                //                           color: Colors.white,
                //                         ),
                //                       ),
                //                       Row(
                //                         crossAxisAlignment:
                //                             CrossAxisAlignment.start,
                //                         children: [
                //                           Text(
                //                             "12:30AM",
                //                             style:
                //                                 GoogleFonts.notoSansMyanmar(
                //                               fontWeight: FontWeight.w400,
                //                               fontSize: 8,
                //                               color: Colors.white,
                //                             ),
                //                           ),
                //                           const SizedBox(
                //                             width: MARGIN_SMALL,
                //                           ),
                //                           Image.asset(
                //                             "assets/icons/right_icon.png",
                //                             width: 16,
                //                           ),
                //                         ],
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ],
                //       ),
                //       const SizedBox(
                //         height: MARGIN_MEDIUM_2,
                //       ),
                //       Row(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           // ChatHead(
                //           //   circleWidth: 45,
                //           //   circleHeight: 45,
                //           //   positionedTop: 30,
                //           //   positionedLeft: 30,
                //           //   whiteBgWidth: 16,
                //           //   whiteBgHeight: 16,
                //           //   greenBgWidth: 12,
                //           //   greenBgHeight: 12,
                //           // ),
                //           const SizedBox(
                //             width: MARGIN_MEDIUM,
                //           ),
                //           Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Container(
                //                 color: const Color.fromRGBO(243, 243, 243, 1),
                //                 child: Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Column(
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.start,
                //                     children: [
                //                       Text(
                //                         "What is your name ?",
                //                         style: GoogleFonts.notoSansMyanmar(
                //                           fontWeight: FontWeight.w400,
                //                           fontSize: 16,
                //                           color: PRIMARY_COLOR,
                //                         ),
                //                       ),
                //                       const SizedBox(
                //                         height: MARGIN_SMALL,
                //                       ),
                //                       Text(
                //                         "12:30AM",
                //                         style: GoogleFonts.notoSansMyanmar(
                //                           fontWeight: FontWeight.w400,
                //                           fontSize: 8,
                //                           color: PRIMARY_COLOR,
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //               const SizedBox(
                //                 height: MARGIN_SMALL,
                //               ),
                //               Column(
                //                 crossAxisAlignment: CrossAxisAlignment.end,
                //                 children: [
                //                   SizedBox(
                //                     height: 104,
                //                     width: 186,
                //                     child: Image.network(
                //                       "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/Hardwell_2018_%28cropped%29.jpg/640px-Hardwell_2018_%28cropped%29.jpg",
                //                       fit: BoxFit.cover,
                //                     ),
                //                   ),
                //                   const SizedBox(
                //                     height: MARGIN_SMALL,
                //                   ),
                //                   Text(
                //                     "12:30AM",
                //                     style: GoogleFonts.dmSans(
                //                       fontWeight: FontWeight.w400,
                //                       fontSize: 8,
                //                       color: PRIMARY_COLOR,
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //               const SizedBox(
                //                 height: MARGIN_SMALL,
                //               ),
                //               Column(
                //                 crossAxisAlignment: CrossAxisAlignment.end,
                //                 children: [
                //                   SizedBox(
                //                     height: 115,
                //                     width: 164,
                //                     child: Image.network(
                //                       "https://allmusicspain.com/wp-content/uploads/2023/02/Dreambeacgh-Hardwell.jpg",
                //                       fit: BoxFit.cover,
                //                     ),
                //                   ),
                //                   const SizedBox(
                //                     height: MARGIN_SMALL,
                //                   ),
                //                   Text(
                //                     "12:30AM",
                //                     style: GoogleFonts.dmSans(
                //                       fontWeight: FontWeight.w400,
                //                       fontSize: 8,
                //                       color: PRIMARY_COLOR,
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ],
                //           )
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                Consumer<ChatBloc>(
                  builder: (context, bloc, child) => Expanded(
                    child: (bloc.messages?.isNotEmpty ?? false)
                        ? ListView.separated(
                            reverse: true,
                            scrollDirection: Axis.vertical,
                            itemCount: bloc.messages?.length ?? 0,
                            itemBuilder: (context, index) {
                              return MessageItemView(
                                  messageVo: bloc.messages?[index], bloc: bloc);
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                height: MARGIN_CARD_MEDIUM_2,
                              );
                            },
                          )
                        : Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: MARGIN_LARGE),
                              child: Text(
                                "No Messages with ${widget.userVO?.userName}",
                                style: const TextStyle(
                                  color: PRIMARY_COLOR,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
                Consumer<ChatBloc>(
                  builder: (context, bloc, child) => Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _controller
                                ..text = bloc.message
                                ..selection = TextSelection.collapsed(
                                    offset: _controller.text.length),
                              textInputAction: TextInputAction.send,
                              focusNode: focusNode,
                              onFieldSubmitted: (value) {
                                bloc.onSendMessage(
                                  widget.userVO ?? UserVO(),
                                );
                              },
                              onChanged: (message) {
                                bloc.onMessageChanged(message);
                              },
                              maxLines: 2,
                              decoration: InputDecoration(
                                  hintText: "Type a message ....",
                                  hintStyle: GoogleFonts.notoSansMyanmar(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color:
                                        const Color.fromRGBO(68, 68, 68, 0.5),
                                  ),
                                  focusedBorder: InputBorder.none,
                                  border: InputBorder.none),
                            ),
                          ),
                          const SizedBox(
                            width: MARGIN_MEDIUM,
                          ),
                          Column(
                            children: [
                              const SizedBox(
                                height: MARGIN_MEDIUM_2,
                              ),
                              GestureDetector(
                                onTap: () {
                                  bloc.onSendMessage(widget.userVO ?? UserVO());
                                },
                                child: Container(
                                  width: 38,
                                  height: 39,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: PRIMARY_COLOR,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.send,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            color: selectedButton == 0
                                ? PRIMARY_COLOR
                                : Colors.white,
                            child: IconButton(
                              onPressed: () async {
                                final ImagePicker _picker = ImagePicker();
                                final XFile? image = await _picker.pickImage(
                                    source: ImageSource.gallery);
                                if (image != null) {
                                  setState(() {
                                    selectedButton = 0;
                                  });
                                  // Handle the picked image here
                                } else {
                                  setState(() {
                                    selectedButton = null;
                                  });
                                }
                              },
                              icon: const Icon(Icons.image_outlined),
                              color: selectedButton == 0
                                  ? Colors.white
                                  : PRIMARY_COLOR,
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            color: selectedButton == 1
                                ? PRIMARY_COLOR
                                : Colors.white,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  selectedButton =
                                      selectedButton == 1 ? null : 1;
                                });
                              },
                              icon: const Icon(Icons.camera_alt_outlined),
                              color: selectedButton == 1
                                  ? Colors.white
                                  : PRIMARY_COLOR,
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            color: selectedButton == 2
                                ? PRIMARY_COLOR
                                : Colors.white,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  selectedButton =
                                      selectedButton == 2 ? null : 2;
                                });
                              },
                              icon: Image.asset(
                                "assets/icons/gif_icon.png",
                                color: selectedButton == 2
                                    ? Colors.white
                                    : PRIMARY_COLOR,
                              ),
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            color: selectedButton == 3
                                ? PRIMARY_COLOR
                                : Colors.white,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  selectedButton =
                                      selectedButton == 3 ? null : 3;
                                });
                              },
                              icon: const Icon(Icons.location_on_outlined),
                              color: selectedButton == 3
                                  ? Colors.white
                                  : PRIMARY_COLOR,
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            color: selectedButton == 4
                                ? PRIMARY_COLOR
                                : Colors.white,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  selectedButton =
                                      selectedButton == 4 ? null : 4;
                                });
                              },
                              icon: const Icon(Icons.mic),
                              color: selectedButton == 4
                                  ? Colors.white
                                  : PRIMARY_COLOR,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
