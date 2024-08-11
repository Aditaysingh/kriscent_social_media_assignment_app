import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kriscent_socail_media/controllers/reels/reels_controller.dart';
import 'package:kriscent_socail_media/view/screens/reels/show_all_reels_screen.dart';
import 'package:kriscent_socail_media/view/utils/app_widgets/reels/grid_reel_widget.dart';
import 'package:kriscent_socail_media/view/utils/app_widgets/textfields/custom_textfiled.dart';
import 'package:kriscent_socail_media/view/utils/sizes/size.dart';
import 'package:video_player/video_player.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ReelsController reelsController = Get.put(ReelsController());
  final Map<int, VideoPlayerController> _videoControllers = {};

  @override
  void dispose() {
    _videoControllers.forEach((index, controller) {
      controller.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var sizes = AppSizes(context: context);
    return Scaffold(
      body: SafeArea(
        child: Obx(
              () => Column(
            children: [
              CustomTextFiled(
                onChanged: (text) {
                  reelsController.performSearch(text);
                },
                controller: reelsController.reelSearchController,
                hint: 'Search..',
                iconData: Icons.search,
              ),
              SizedBox(
                height: sizes.getHeight * 0.02,
              ),
              Expanded(
                child: reelsController.searchedReelsList.isEmpty
                    ? const Center(
                  child: Text("No Reels Available"),
                )
                    : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.6,
                    crossAxisSpacing: 2,
                  ),
                  itemCount: reelsController.searchedReelsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var currentReel =
                    reelsController.searchedReelsList[index];
                    if (!_videoControllers.containsKey(index)) {
                      _videoControllers[index] = VideoPlayerController
                          .network(currentReel.video ?? '')
                        ..initialize().then((_) {
                          if (mounted) {
                            setState(() {}); // Rebuild to show video player
                          }
                        });
                    }
                    VideoPlayerController videoController =
                    _videoControllers[index]!;

                    return GridVideoItem(
                      videoController: videoController,
                      onItemTap: () {
                        Get.to(() => ShowAllReelPostsScreen(
                          reelsList: reelsController.searchedReelsList,
                          pageController: PageController(initialPage: index),
                          title: 'Searched Reels',
                          videoControllers: _videoControllers,
                        ));
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
