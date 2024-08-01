import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kriscent_socail_media/controllers/profile/user_controller.dart';
import 'package:kriscent_socail_media/controllers/reels/reels_controller.dart';
import 'package:kriscent_socail_media/models/reels/reel_model.dart';
import 'package:kriscent_socail_media/models/profile/user_model.dart';
import 'package:kriscent_socail_media/view/utils/app_widgets/reels/reel_item_widget.dart';
import 'package:kriscent_socail_media/view/utils/app_widgets/textfields/custom_textfiled.dart';
import 'package:kriscent_socail_media/view/utils/extensions/app_extensions.dart';
import 'package:video_player/video_player.dart';


class ReelPageView extends StatefulWidget {
  @override
  _ReelPageViewState createState() => _ReelPageViewState();
}

class _ReelPageViewState extends State<ReelPageView> {
  ReelsController reelController = Get.put(ReelsController());
  UserController userController = Get.put(UserController());
  Map<int, VideoPlayerController> _videoControllers = {};

  @override
  Widget build(BuildContext context) {
    var sizes = MediaQuery.of(context).size; // Use MediaQuery to get screen size

    return Obx(() {
      if (reelController.isLoading) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      } else if (reelController.allReelsList.isEmpty) {
        return const Center(
          child: Text('No Reels Availavle'),
        );
      }
      return PageView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: reelController.allReelsList.length,
        itemBuilder: (context, index) {
          var currentReel = reelController.allReelsList[index];
          if (!_videoControllers.containsKey(index)) {
            _videoControllers[index] =
                VideoPlayerController.network(currentReel.video ?? '')
                  ..initialize().then((_) {
                    setState(() {}); // Rebuild to show video player

                  });
          }
          VideoPlayerController videoController = _videoControllers[index]!;
          return ReelItemWidget(
            videoController: videoController,
            reelController: reelController,
            currentReel: currentReel,
            onCommentTap: () {
              openCommentDialog(context: context, reel: currentReel);
            }, userController: userController,
          );
        },
      );
    });
  }

  @override
  void dispose() {
    _videoControllers.values.forEach((controller) {
      controller.dispose();
    });
    super.dispose();
  }

  void openCommentDialog(
      {required BuildContext context, required ReelModel reel}) {
    showModalBottomSheet(
      context: context,
      // isScrollControlled: true,
      showDragHandle: true,
      enableDrag: true,
      backgroundColor: const Color(0xfff2f2f2),

      scrollControlDisabledMaxHeightRatio: 3 / 4,
      constraints: BoxConstraints(
        minHeight: 400,
        maxHeight: context.screenHeight,
        minWidth: context.screenWidth,
      ),
      builder: (context) {
        return Obx(
          () => Column(
            children: [
              const PhysicalModel(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 18.0),
                      child: Text("Comments"),
                    ),
                    CloseButton(
                      color: Colors.red,
                    )
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: reel.comments?.isEmpty == true
                    ? const Center(
                        child: Text("No Comments Available"),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(bottom: 20),
                        shrinkWrap: true,
                        itemCount: reel.comments?.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var currentComment =
                              reel.comments?.reversed.toList()[index];

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: StreamBuilder<UserModel>(
                                stream: reelController.reelAuthorData(
                                    currentComment?.commentAuthorId),
                                builder: (context, snapshot) {
                                  var author = snapshot.data;
                                  return ListTile(
                                    shape: 10.shapeBorderRadius,
                                    leading: PhysicalModel(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50),
                                      elevation: 5,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                author?.profileImage ?? '',
                                            width: 45,
                                            height: 45,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                const CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      "${author?.name}",
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    subtitle: Text("${currentComment?.text}"),
                                  );
                                }),
                          );
                        },
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: CustomTextFiled(
                            controller: reelController.commentController,
                            iconData: Icons.comment,
                            hint: 'Enter Comment here')),
                    IconButton(
                        onPressed: () async {
                          reelController.uploadComment(reel);
                        },
                        icon: reelController.isCommentLoading
                            ? const Center(child: CupertinoActivityIndicator())
                            : const Icon(
                                CupertinoIcons.arrow_right_circle_fill,
                                size: 45,
                              ))
                  ],
                ),
              ),
              SizedBox(
                height: context.mediaQuery.viewInsets.bottom,
                width: context.width,
              )
            ],
          ),
        );
      },
    );
  }
}

