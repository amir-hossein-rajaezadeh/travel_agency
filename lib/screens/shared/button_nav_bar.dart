import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_agency/cubit/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:video_player/video_player.dart';
import '../../cubit/app_cubit.dart';
import '../../utils/my_colors.dart';

class ButtonNavBarWidget extends StatelessWidget {
  const ButtonNavBarWidget(
      {required this.state, this.videoPlayerController, super.key});
  final AppState state;
  final VideoPlayerController? videoPlayerController;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 30, left: 30, bottom: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(
              state.selectedNavBar == 0
                  ? CupertinoIcons.house_fill
                  : CupertinoIcons.house,
              size: 30,
            ),
            onPressed: () {
              videoPlayerController!.pause();
              context
                  .read<AppCubit>()
                  .changeBottomNavbarSelectedIndex(0, context);
            },
            color: state.selectedNavBar == 0
                ? MyColors.mediumOrange
                : Colors.white,
          ),
          const Icon(
            Iconsax.document,
            size: 30,
            color: Colors.white,
          ),
          GestureDetector(
            onTap: () {
              context.read<AppCubit>()
                ..changeBottomNavbarSelectedIndex(2, context)
                ..resetStateValues();
            },
            child: state.selectedNavBar == 2
                ? Image.asset(
                    'assets/icon/search.png',
                    color: MyColors.darkOrange,
                    width: 30,
                  )
                : const Icon(
                    CupertinoIcons.search,
                    color: Colors.white,
                    size: 30,
                  ),
          ),
          const Icon(
            Iconsax.ticket,
            size: 30,
            color: Colors.white,
          ),
          const Icon(
            CupertinoIcons.person,
            size: 30,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
