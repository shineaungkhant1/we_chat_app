import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:we_chat_app/resources/dimens.dart';
import 'package:we_chat_app/widgets/contact_search_bar.dart';

import '../resources/colors.dart';
import '../resources/strings.dart';
import '../viewitems/contact_chat_head_and_name_vertical_list_view.dart';
import '../widgets/a_to_z.dart';
import '../widgets/active_now_chat_head_with_white_square_bg.dart';

class AddNewGroupPage extends StatefulWidget {
  const AddNewGroupPage({super.key});

  @override
  State<AddNewGroupPage> createState() => _AddNewGroupPageState();
}

class _AddNewGroupPageState extends State<AddNewGroupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(19.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Image.asset(
              "assets/icons/cancel_icon.png",
            ),
          ),
        ),
        title: const Text(
          "New Group",
          style: TextStyle(
              fontFamily: YORKIE_FONT,
              fontWeight: FontWeight.w600,
              fontSize: 24,
              color: PRIMARY_COLOR),
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 60,
                height: 32,
                decoration: BoxDecoration(
                  color: PRIMARY_COLOR,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Create",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: YORKIE_FONT,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body:  SingleChildScrollView(
        child: Stack(
          children:[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:MARGIN_LARGE,vertical:MARGIN_MEDIUM),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Group Name",
                    style: GoogleFonts.notoSansMyanmar(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: PRIMARY_COLOR),
                  ),
                  const SizedBox(
                    height: 30,
                    child: TextField(
                      decoration: InputDecoration(
                          focusColor: PRIMARY_COLOR,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: PRIMARY_COLOR
                              )
                          )
                      ),
                    ),
                  ),
                  const SizedBox(height: MARGIN_MEDIUM_2,),
                  const ContactSearchBar(),
                  const SizedBox(height: MARGIN_MEDIUM_3,),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: ActiveNowChatHeadWithWhiteSquareBg(),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: MARGIN_MEDIUM_3,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: MARGIN_MEDIUM, vertical: MARGIN_MEDIUM),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Favourites(2)",
                            style: GoogleFonts.notoSansMyanmar(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: PRIMARY_COLOR),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 160,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: 2,
                                  itemBuilder: (context, index) {
                                    return  Padding(
                                      padding:
                                      EdgeInsets.only(top: MARGIN_MEDIUM_2),
                                      child:
                                      ContactChatHeadAndNameVerticalListView(isAddNewGroupPage: true,  user: null,),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: MARGIN_MEDIUM_3,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: MARGIN_MEDIUM, vertical: MARGIN_MEDIUM),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "A",
                            style: GoogleFonts.notoSansMyanmar(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: PRIMARY_COLOR),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 160,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: 2,
                                  itemBuilder: (context, index) {
                                    return  Padding(
                                      padding:
                                      EdgeInsets.only(top: MARGIN_MEDIUM_2),
                                      child:
                                      ContactChatHeadAndNameVerticalListView(isAddNewGroupPage: true, user: null, ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: MARGIN_MEDIUM_3,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: MARGIN_MEDIUM, vertical: MARGIN_MEDIUM),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "D",
                            style: GoogleFonts.notoSansMyanmar(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: PRIMARY_COLOR),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 230,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: 3,
                                  itemBuilder: (context, index) {
                                    return  Padding(
                                      padding:
                                      EdgeInsets.only(top: MARGIN_MEDIUM_2),
                                      child:
                                      ContactChatHeadAndNameVerticalListView(isAddNewGroupPage: true, user: null, ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Positioned(
              right: -10,
              top: 280,
              child: AtoZRow(),
            ),
          ]
        ),
      ),
    );
  }
}


