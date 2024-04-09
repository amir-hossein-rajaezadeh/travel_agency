import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_agency/cubit/app_cubit.dart';
import 'package:travel_agency/cubit/app_state.dart';
import 'package:travel_agency/models/category_list.dart';
import 'package:travel_agency/models/place_list.dart';
import 'package:travel_agency/screens/shared/button_nav_bar.dart';
import 'package:travel_agency/utils/my_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  late VideoPlayerController _videoController;
  final PageController _pageController = PageController();

  late AnimationController _controller;
  late Animation<double> _scaleXAnimation;
  late Animation<double> _scaleYAnimation;

  @override
  void initState() {
    initAnimations();
    initVideoPlayer(placeList[0].placeVideo, true);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _videoController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        bool selected = state.borderRadius == 1;
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      height: state.isSelected ? 12 : 0,
                    ),
                    buildVideoPlayerWidget(selected, context),
                  ],
                ),
                buildNavBarWidget(size, state),
              ],
            ),
          ),
        );
      },
    );
  }

  Expanded buildVideoPlayerWidget(bool selected, BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onLongPress: () {
          selected ? _controller.reverse() : _controller.forward();
          context.read<AppCubit>().videoLongPress();
        },
        child: PageView.builder(
          onPageChanged: (value) async {
            _videoController.dispose();
            initVideoPlayer(placeList[value].placeVideo, false);
          },
          controller: _pageController,
          itemCount: placeList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final placeItem = placeList[index];
            return AnimatedBuilder(
              builder: (context, child) {
                return Transform.scale(
                  scaleX: _scaleXAnimation.value,
                  scaleY: _scaleYAnimation.value,
                  alignment: Alignment.topCenter,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(selected ? 25 : 0),
                    child: _videoController.value.isInitialized
                        ? Stack(
                            children: [
                              Center(
                                child: VideoPlayer(_videoController),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(bottom: 55, left: 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      placeItem.name,
                                      style: GoogleFonts.pridi(
                                          color: MyColors.lightGrey,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 40),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(right: 20),
                                      height: 80,
                                      child: Text(
                                        placeItem.desc,
                                        style: GoogleFonts.pridi(
                                                color: const Color.fromARGB(
                                                    255, 160, 169, 188),
                                                fontSize: 15)
                                            .copyWith(
                                          overflow: TextOverflow.fade,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 15),
                                      height: 32,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ListView.separated(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                placeItem.hashtags.length,
                                            itemBuilder: (context, index) {
                                              return buildHashtagItemWidget(
                                                  placeItem.hashtags[index]);
                                            },
                                            separatorBuilder:
                                                (BuildContext context,
                                                        int index) =>
                                                    Container(
                                              width: 5,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 16),
                                            child: buildHashtagItemWidget(
                                              placeItem.additionalHashtagNums
                                                  .toString(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                  ),
                );
              },
              animation: _controller,
            );
          },
        ),
      ),
    );
  }

  Column buildNavBarWidget(Size size, AppState state) {
    return Column(
      children: [
        buildTopAppBarWidget(size),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: ButtonNavBarWidget(
            state: state,
            videoPlayerController: _videoController,
          ),
        )
      ],
    );
  }

  Container buildTopAppBarWidget(Size size) {
    return Container(
      margin: const EdgeInsets.only(top: 30, left: 30),
      width: size.width,
      height: 40,
      child: ListView.separated(
        itemCount: categoryList.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: index == 2 ? MyColors.darkOrange : Colors.transparent,
              border: Border.all(
                color: index == 2 ? Colors.transparent : Colors.grey,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: buildTopAppbarItemWidget(index),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            width: 6,
          );
        },
      ),
    );
  }

  Container buildTopAppbarItemWidget(int index) {
    return Container(
      child: index > 1
          ? Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                categoryList[index],
                style: GoogleFonts.pridi(color: Colors.white, fontSize: 14),
              ),
            )
          : Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Icon(
                index == 0 ? CupertinoIcons.list_bullet : CupertinoIcons.search,
                color: Colors.white,
              ),
            ),
    );
  }

  Container buildHashtagItemWidget(String hastagTitle) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: MyColors.veryDarkGrey,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 9),
          child: Text(
            hastagTitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.pridi(fontSize: 12, color: Colors.white),
          ),
        ),
      ),
    );
  }

  void initVideoPlayer(String videoAssetsPath, bool isFromInitState) {
    _videoController = VideoPlayerController.asset(videoAssetsPath)
      ..initialize().then((_) async {
        _videoController.setLooping(true);
        setState(() {
          _videoController.play().then((value) async {
            context.read<AppCubit>().videoLongPress();
            await Future.delayed(
              const Duration(milliseconds: 200),
            );
            if (isFromInitState) {
              _controller.forward();
            } else {
              _controller.reverse();
            }
          });
        });
      });
  }

  void initAnimations() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleXAnimation = Tween<double>(begin: 1, end: 0.90).animate(_controller);
    _scaleYAnimation = Tween<double>(begin: 1, end: 0.99).animate(_controller);
  }
}
