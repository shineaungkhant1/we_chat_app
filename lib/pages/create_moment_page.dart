import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:we_chat_app/blocs/add_new_moment_bloc.dart';
import 'package:we_chat_app/resources/strings.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../viewitems/profile_image_view.dart';
import 'moment_page.dart';

class CreateMomentPage extends StatefulWidget {
  const CreateMomentPage({super.key});

  @override
  State<CreateMomentPage> createState() => _CreateMomentPageState();
}

class _CreateMomentPageState extends State<CreateMomentPage> {
  List<dynamic> selectedImages = [];


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddNewMomentBloc(),
      child: Selector<AddNewMomentBloc, bool>(
        selector: (context, bloc) => bloc.isLoading,
        builder: (context, isLoading, child) => Scaffold(
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
              "New Moment",
              style: TextStyle(
                  fontFamily: YORKIE_FONT,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  color: PRIMARY_COLOR),
            ),
            actions: [
              Consumer<AddNewMomentBloc>(builder: (context,bloc,child)=>Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Container(
                    width: 60,
                    height: 32,
                    decoration: BoxDecoration(
                      color: PRIMARY_COLOR,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextButton(
                      onPressed: () {
                       bloc.onTapAddNewMoment().then((value){
                         Navigator.pop(context);
                       });
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
              ),)
            ],
          ),
          body: Stack(
            children: [
              const SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      ProfileImageAndNameView(),
                      SizedBox(
                        height: MARGIN_LARGE,
                      ),
                      AddNewMomentTextFieldView(),
                      SizedBox(
                        height: MARGIN_LARGE,
                      ),
                      PostDescriptionErrorView(),
                      SizedBox(
                        height: MARGIN_XXLARGE_3 + 200,
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20, left: 20),
                  child: Consumer<AddNewMomentBloc>(
                    builder: (context, bloc, child) => Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            List<dynamic> pickedItems = [];


                            final result = await FilePicker.platform.pickFiles(
                              type: FileType.media,
                              allowMultiple: true,
                            );

                            if (result != null && result.files.isNotEmpty) {
                              for (final file in result.files) {
                                if (file.extension == 'jpg' ||
                                    file.extension == 'png') {
                                 bloc.onChooseImage(File(file.path??""));
                                  pickedItems.add(File(file.path ?? ""));
                                } else if (file.extension == 'mp4' ||
                                    file.extension == 'mov') {
                                  bloc.onChooseVideo(File(file.path??""));
                                  final thumbnailPath =
                                      await VideoThumbnail.thumbnailFile(
                                    video: file.path ?? "",
                                    thumbnailPath:
                                        (await getTemporaryDirectory()).path,
                                    imageFormat: ImageFormat.PNG,
                                    maxHeight: 200,
                                    quality: 75,
                                  );
                                  print('Thumbnail path: $thumbnailPath');

                                  pickedItems.add(thumbnailPath);
                                }
                              }
                            }

                            if (pickedItems.isNotEmpty) {
                              setState(() {
                                selectedImages.addAll(pickedItems);
                                bloc.onImageChosen(selectedImages);
                              });

                            }
                          },
                          child: Container(
                            width: 108,
                            height: 108,
                            decoration: BoxDecoration(
                              border: Border.all(color: PRIMARY_COLOR),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: PRIMARY_COLOR,
                              size: 38,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 108,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListView.builder(
                              padding: EdgeInsets.only(left: 20),
                              scrollDirection: Axis.horizontal,
                              itemCount: selectedImages.length,
                              itemBuilder: (context, index) {
                                final item = selectedImages[index];
                                if (item is File) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: SizedBox(
                                      width: 108,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            Image.file(
                                              item,
                                              fit: BoxFit.cover,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else if (item is String) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: SizedBox(
                                      width: 108,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            Image.file(
                                              File(item),
                                              fit: BoxFit.cover,
                                            ),
                                            const Center(
                                              child: Icon(
                                                Icons.play_circle_filled,
                                                size: 48,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PostDescriptionErrorView extends StatelessWidget {
  const PostDescriptionErrorView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewMomentBloc>(
      builder: (context, bloc, child) => Visibility(
        visible: bloc.isAddNewMomentError,
        child: const Text(
          "Post should not be empty",
          style: TextStyle(
            color: Colors.red,
            fontSize: TEXT_REGULAR,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class AddNewMomentTextFieldView extends StatelessWidget {
  const AddNewMomentTextFieldView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewMomentBloc>(
      builder: (context, bloc, child) => SizedBox(
        height: 273,
        child: TextField(
          onChanged: (value){
            bloc.onNewPostTextChanged(value);
          },
          controller: TextEditingController(text: bloc.newMomentDescription),
          maxLines: 5,
          decoration: InputDecoration(
              hintText: "What's on your mind",
              hintStyle: GoogleFonts.notoSansMyanmar(
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: Colors.grey,
              ),
              focusedBorder: InputBorder.none,
              border: InputBorder.none),
        ),
      ),
    );
  }
}

class ProfileImageAndNameView extends StatelessWidget {
  const ProfileImageAndNameView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewMomentBloc>(
      builder: (context, bloc, child) => Row(
        children: [
          ProfileImageView(
            profileImage: bloc.profilePicture.isEmpty
                ? "https://www.citypng.com/public/uploads/preview/download-black-male-user-profile-icon-png-116371332534k5baafcll.png"
                : bloc.profilePicture,
          ),
          const SizedBox(
            width: MARGIN_MEDIUM,
          ),
          Text(bloc.userName,
              style: GoogleFonts.notoSansMyanmar(
                fontSize: 18,
                color: PRIMARY_COLOR,
                fontWeight: FontWeight.w700,
              )),
        ],
      ),
    );
  }
}
