import 'package:flutter/material.dart';
import 'package:we_chat_app/data/vos/moment_vo.dart';

import '../resources/dimens.dart';

class MomentImagesHorizontalListView extends StatelessWidget {
 MomentVO? mMoments;
 int index;


 MomentImagesHorizontalListView({super.key, required this.mMoments,required this.index});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(MARGIN_CARD_MEDIUM_2),
          child: Image.network(
            mMoments?.postImageLit?[index]??"",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
