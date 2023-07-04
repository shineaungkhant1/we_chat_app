import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_app/blocs/add_new_moment_bloc.dart';
import 'package:we_chat_app/blocs/moment_bloc.dart';
import 'package:we_chat_app/pages/create_moment_page.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimens.dart';
import 'package:we_chat_app/resources/strings.dart';
import 'package:we_chat_app/viewitems/moment_items_view.dart';

const kAnimationDuration = Duration(milliseconds: 500);

class MomentPage extends StatelessWidget {

  const MomentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MomentBloc(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const Text(
            "Moments",
            style: TextStyle(
                fontFamily: YORKIE_FONT,
                fontWeight: FontWeight.w600,
                fontSize: 34,
                color: PRIMARY_COLOR),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 12.4,bottom: 12.4,right: 16),
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: PRIMARY_COLOR,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const CreateMomentPage()),
                    );
                  },
                  icon: Image.asset(
                    "assets/icons/add_moment_icon.png",
                    width: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
        body:Consumer<MomentBloc>(
          builder: (context,bloc,child)=> ListView.separated(
              itemBuilder: (context, index) {
                return MomentItemsView(mMoments: bloc.moment?[index], onTapDelete: (momentId){
                  bloc.onTapDeletePost(momentId);
                });
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: bloc.moment?.length??0),
        )
      ),
    );
  }
}
