import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_app/blocs/contact_bloc.dart';
import 'package:we_chat_app/pages/add_new_contact_page.dart';
import 'package:we_chat_app/pages/add_new_group_page.dart';
import 'package:we_chat_app/pages/convo_page.dart';
import 'package:we_chat_app/resources/dimens.dart';
import 'package:we_chat_app/widgets/a_to_z.dart';
import 'package:we_chat_app/widgets/group_list.dart';
import '../data/vos/user_vo.dart';
import '../resources/colors.dart';
import '../resources/strings.dart';
import '../viewitems/contact_chat_head_and_name_vertical_list_view.dart';
import '../widgets/active_now_chat_head_with_white_square_bg.dart';
import '../widgets/contact_search_bar.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  UserVO? userVO;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContactBloc(userVO??UserVO()),
      child: Consumer<ContactBloc>(
        builder: (context, bloc, child) {

          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              title:  Row(
                children: [
                  const Text(
                    "Contacts",
                    style: TextStyle(
                      fontFamily: YORKIE_FONT,
                      fontWeight: FontWeight.w600,
                      fontSize: 34,
                      color: PRIMARY_COLOR,
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: MARGIN_MEDIUM_2,
                      ),
                      Text(
                        "( ${bloc.contactUsers?.length.toString() ?? "0"} )",
                        style: const TextStyle(
                          fontFamily: YORKIE_FONT,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
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
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const AddNewContactPage(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.person_add_alt_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ContactSearchBar(),
                      const SizedBox(
                        height: MARGIN_MEDIUM,
                      ),
                      Text(
                        "Groups(5)",
                        style: GoogleFonts.notoSansMyanmar(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: PRIMARY_COLOR),
                      ),
                      const SizedBox(
                        height: MARGIN_MEDIUM_3,
                      ),
                      SizedBox(
                        height: 80,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AddNewGroupPage()));
                          },
                          child: GroupList(),
                        ),
                      ),
                      const SizedBox(
                        height: MARGIN_LARGE,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: MARGIN_MEDIUM,
                                vertical: MARGIN_MEDIUM),
                            child: Column(
                              children: [
                                Expanded(
                                  child: (bloc.alphabetsStartByName
                                              ?.isNotEmpty ??
                                          false)
                                      ? ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: bloc.alphabetsStartByName
                                                  ?.length,
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  top: MARGIN_MEDIUM_2),
                                              child:
                                                  GestureDetector(
                                                    onTap: (){
                                                      _navigateToChatRoomPage(context, bloc.contactUsers?[index]);
                                                    },
                                                    child: ContactChatHeadAndNameVerticalListView(
                                                isAddNewGroupPage: false, user: bloc.contactUsers?[index],
                                              ),
                                                  ),
                                            );
                                          },
                                        )
                                      : const Center(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: MARGIN_LARGE),
                                            child: Text(
                                              "No Contacts Found",
                                              style: TextStyle(
                                                color:PRIMARY_COLOR,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // const SizedBox(
                      //   height: MARGIN_MEDIUM_3,
                      // ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.circular(12),
                      //   ),
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(
                      //         horizontal: MARGIN_MEDIUM, vertical: MARGIN_MEDIUM),
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Text(
                      //           "A",
                      //           style: GoogleFonts.notoSansMyanmar(
                      //               fontWeight: FontWeight.w700,
                      //               fontSize: 16,
                      //               color: PRIMARY_COLOR),
                      //         ),
                      //         Column(
                      //           children: [
                      //             SizedBox(
                      //               height: 160,
                      //               child: ListView.builder(
                      //                 shrinkWrap: true,
                      //                 physics:
                      //                     const NeverScrollableScrollPhysics(),
                      //                 scrollDirection: Axis.vertical,
                      //                 itemCount: 2,
                      //                 itemBuilder: (context, index) {
                      //                   return Padding(
                      //                     padding: EdgeInsets.only(
                      //                         top: MARGIN_MEDIUM_2),
                      //                     child:
                      //                         ContactChatHeadAndNameVerticalListView(
                      //                       isAddNewGroupPage: false,
                      //                     ),
                      //                   );
                      //                 },
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: MARGIN_MEDIUM_3,
                      // ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.circular(12),
                      //   ),
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(
                      //         horizontal: MARGIN_MEDIUM, vertical: MARGIN_MEDIUM),
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Text(
                      //           "D",
                      //           style: GoogleFonts.notoSansMyanmar(
                      //               fontWeight: FontWeight.w700,
                      //               fontSize: 16,
                      //               color: PRIMARY_COLOR),
                      //         ),
                      //         Column(
                      //           children: [
                      //             SizedBox(
                      //               height: 230,
                      //               child: ListView.builder(
                      //                 shrinkWrap: true,
                      //                 scrollDirection: Axis.vertical,
                      //                 physics:
                      //                     const NeverScrollableScrollPhysics(),
                      //                 itemCount: 3,
                      //                 itemBuilder: (context, index) {
                      //                   return Padding(
                      //                     padding: EdgeInsets.only(
                      //                         top: MARGIN_MEDIUM_2),
                      //                     child:
                      //                         ContactChatHeadAndNameVerticalListView(
                      //                       isAddNewGroupPage: false,
                      //                     ),
                      //                   );
                      //                 },
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  // const Positioned(
                  //   right: 0,
                  //   top: 225,
                  //   child: AtoZRow(),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
 void _navigateToChatRoomPage(BuildContext context,UserVO? user){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>ConvoPage(userVO: user,),),);
 }