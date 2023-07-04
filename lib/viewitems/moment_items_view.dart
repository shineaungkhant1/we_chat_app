import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:we_chat_app/data/vos/moment_vo.dart';
import 'package:we_chat_app/resources/colors.dart';

import '../resources/dimens.dart';
import '../resources/images.dart';
import '../widgets/moment_images_horizontal_list_view.dart';
import 'profile_image_view.dart';
import 'favourite_icon_and_save_icon_animation.dart';

class MomentItemsView extends StatelessWidget {
  final MomentVO? mMoments;
  final Function(int) onTapDelete;



  const MomentItemsView({super.key, required this.mMoments,required this.onTapDelete});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16,top: 24,bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               ProfileImageView(
                profileImage: mMoments?.profilePicture ?? "",
              ),
              const SizedBox(
                width: MARGIN_MEDIUM_2,
              ),
               NameLocationAndTimeAgoView(
                userName:mMoments?.userName??"",
              ),
              const Spacer(),
              MoreButtonView(
                onTapDelete: () {
                  onTapDelete(mMoments?.id ?? 0);
                },
                onTapEdit: () {
                },
              ),
            ],
          ),
        ),
         Padding(
          padding: const EdgeInsets.only(left: 17,bottom: 12),
          child: PostDescriptionView(
            description:mMoments?.description??"",
          ),
        ),
          Visibility(visible:((mMoments?.postImageLit??[]).isNotEmpty),child: PostImageView(mMoment:mMoments)),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
          Padding(
              padding: const EdgeInsets.only(left: 15,bottom: 12),
            child: Row(
            children: [
              const FavouriteIconAnimation(),
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.message,
                    color: PRIMARY_COLOR,
                  ),
                  Text("2",style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: PRIMARY_COLOR
                  ),)
                ],
              ),
              const SizedBox(
                width: MARGIN_MEDIUM,
              ),
              const SaveIconAnimation()
            ],
        ),
          )
      ],
    );
  }
}

class NameLocationAndTimeAgoView extends StatelessWidget {
  final String userName;

  const NameLocationAndTimeAgoView({
    Key? key,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          userName,
          style: GoogleFonts.notoSansMyanmar(
            fontSize: 16,
            color: PRIMARY_COLOR,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM,
        ),
         Text(
          "15 min ago",
          style: GoogleFonts.notoSansMyanmar(
            fontSize: 12,
            color: PRIMARY_COLOR,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class MoreButtonView extends StatelessWidget {
  final Function onTapDelete;
  final Function onTapEdit;

  const MoreButtonView({
    Key? key,
    required this.onTapDelete,
    required this.onTapEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      padding: EdgeInsets.zero,
      icon: const Icon(
        Icons.more_horiz,
        color: Colors.grey,
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: () {
            onTapEdit();
          },
          value: 1,
          child: const Text("Edit"),
        ),
        PopupMenuItem(
          onTap: () {
            onTapDelete();
          },
          value: 2,
          child: const Text("Delete"),
        )
      ],
    );
  }
}

class PostDescriptionView extends StatelessWidget {
  final String description;

  const PostDescriptionView({
    Key? key,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: const TextStyle(
        fontSize: TEXT_REGULAR,
        color: PRIMARY_COLOR,
      ),
    );
  }
}

class PostImageView extends StatelessWidget {

  MomentVO? mMoment;


  PostImageView({super.key, required this.mMoment});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
      ),
      height:200,
      child: ListView.builder(
        shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index){
          if(mMoment?.postImageLit?.isNotEmpty??false) {
            return MomentImagesHorizontalListView(mMoments: mMoment,index: index,);
          }
          // if(mMoment?.postVideoList?.isNotEmpty??false)
          //   return Mome

      },
        itemCount: (mMoment?.postImageLit?.isNotEmpty??false)?mMoment?.postImageLit?.length:mMoment?.postVideoList?.length,
      ),
    );
  }
}