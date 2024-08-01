import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kriscent_socail_media/controllers/reels/reels_controller.dart';
import 'package:kriscent_socail_media/view/utils/app_widgets/buttons/custom_button.dart';
import 'package:kriscent_socail_media/view/utils/app_widgets/textfields/custom_textfiled.dart';
import 'package:kriscent_socail_media/view/utils/app_widgets/pickers/video_picker_widget.dart';
import 'package:video_player/video_player.dart';
import '../../utils/sizes/size.dart';

class ReelPostScreen extends StatefulWidget {
  const ReelPostScreen({super.key});

  @override
  State<ReelPostScreen> createState() => _ReelPostScreenState();
}

class _ReelPostScreenState extends State<ReelPostScreen> {
  var reelController = Get.put(ReelsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'New Post ',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          Obx(
          ()=> TextButton(
                onPressed: () {
                  reelController.uploadReel();
                },
                child: (reelController.isLoading)
                    ? const Center(
                        child: CupertinoActivityIndicator(),
                      )
                    : const Text(
                        'POST',
                        style: TextStyle(fontSize: 18),
                      )),
          )
        ],
      ),
      body: Obx(
        () => ListView(
          children: [
            Column(
              children: [
                VideoPickerWidget(
                  video: reelController.videoFile,
                  onVideoPicked: (pickedVideo) {
                    reelController.updateVideoFile(pickedVideo);
                    reelController.updateVideoController;
                  },
                  videoPlayerController: reelController.videoFile != null
                      ? reelController.fileVideoController
                      : null,
                ),
                CustomTextFiled(
                  controller: reelController.titleController,
                  hint: 'Title',
                  iconData: Icons.title,
                ),
                CustomTextFiled(
                  controller: reelController.captionController,
                  hint: 'Caption',
                  iconData: Icons.title,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
