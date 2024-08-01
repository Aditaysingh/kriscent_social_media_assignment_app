import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kriscent_socail_media/controllers/auth/auth_controller.dart';
import 'package:kriscent_socail_media/controllers/profile/user_controller.dart';
import 'package:kriscent_socail_media/controllers/reels/reels_controller.dart';
import 'package:kriscent_socail_media/view/screens/followers/all_followers_screen.dart';
import 'package:kriscent_socail_media/view/screens/followings/all_followings_screen.dart';
import 'package:kriscent_socail_media/view/screens/profile/edit_profile_screen.dart';
import 'package:kriscent_socail_media/view/screens/profile/profile_setting_screen.dart';
import 'package:kriscent_socail_media/view/screens/reels/reel_upload_screen.dart';
import 'package:kriscent_socail_media/view/screens/reels/show_all_reels_screen.dart';
import 'package:kriscent_socail_media/view/utils/app_widgets/reels/grid_reel_widget.dart';
import 'package:kriscent_socail_media/view/utils/extensions/app_extensions.dart';
import 'package:kriscent_socail_media/view/utils/sizes/size.dart';
import 'package:video_player/video_player.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserController userController = Get.put(UserController());
  AuthController authController = Get.put(AuthController());

  ReelsController reelController = Get.put(ReelsController());

  Map<int, VideoPlayerController> _videoControllers = {};

  @override
  Widget build(BuildContext context) {
    var sizes = AppSizes(context: context);
    final UserController userController = Get.put(UserController());

    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: userController.user.name == null
                ? const CircularProgressIndicator()
                : Text(
                    userController.user.name ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
          );
        }),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Text("Upload",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 19),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  Get.to(ReelPostScreen());
                },
                icon: const Icon(Icons.add_box_outlined,size: 35,)),
          )
        ],
      ),
      body: Obx(() {
        if (userController.user.name == null) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: sizes.getHeight * 0.02),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            userController.user.profileImage?.isNotEmpty == true
                                ? NetworkImage(
                                    userController.user.profileImage ?? '')
                                : null,
                        child: userController.user.profileImage?.isEmpty == true
                            ? const Icon(Icons.person, size: 40)
                            : null,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          "${reelController.currentUserReels.length}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const Text(
                          "posts",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(()=>AllFollowersScreen());
                      },
                      child: Column(
                        children: [
                          Text(
                            "${userController.user.followers?.length}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const Text(
                            "followers",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(()=>AllFollowingsScreen());
                      },
                      child: Column(
                        children: [
                          Text(
                            "${userController.user.following?.length}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const Text(
                            "Following",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      authController.updateField();
                      Get.to(()=>const ProfileSettingScreen());
                    },
                    child: const Text('Account Setting'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      side: BorderSide(color: Colors.black.withOpacity(0.5)),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      authController.updateField();
                      Get.to(()=> EditProfileScreen());

                    },
                    child: const Text('Edit profile'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      side: BorderSide(color: Colors.black.withOpacity(0.5)),
                    ),
                  ),
                ],
              ),
              20.height,
              Divider(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 18.0, horizontal: 15),
                        child: Text(
                          "Posts",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      Expanded(
                        child: reelController.currentUserReels.isEmpty
                            ? const Center(
                                child: Text("No Reels Available"),
                              )
                            : GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 0.6,
                                  crossAxisSpacing: 2,
                                ),
                                itemCount:
                                    reelController.currentUserReels.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var currentReel =
                                      reelController.currentUserReels[index];
                                  if (!_videoControllers.containsKey(index)) {
                                    _videoControllers[index] =
                                        VideoPlayerController.network(
                                            currentReel.video ?? '')
                                          ..initialize().then((_) {
                                            setState(() {});
                                          });
                                  }
                                  VideoPlayerController videoController =
                                      _videoControllers[index]!;
                                  return GridVideoItem(videoController: videoController, onItemTap: () {
                                    Get.to(() =>
                                        ShowAllReelPostsScreen(
                                          reelsList: reelController
                                              .currentUserReels,
                                          pageController:
                                          PageController(
                                              initialPage:
                                              index),
                                          title: 'My Reels',
                                          videoControllers:
                                          _videoControllers,
                                        ));
                                  },);
                                },
                              ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}

