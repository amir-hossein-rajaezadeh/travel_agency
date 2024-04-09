import 'package:flutter/material.dart';
import 'package:travel_agency/cubit/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// A Cubit class for managing application state
class AppCubit extends Cubit<AppState> {
  // Initialize the AppCubit with a default AppState
  AppCubit()
      : super(
          const AppState(
              borderRadius: 0.87,
              isSelected: false,
              selectedNavBar: 2,
              profileSize: 0,
              flightCardSize: 0,
              showFlyInfoAnim: false,
              showtravelTextAnim: false),
        );

  // Method to handle long press event on a video
  void videoLongPress() {
    // Check if the video is already selected
    if (!state.isSelected) {
      // If not selected, change the border radius and set isSelected to true
      emit(
        state.copyWith(
            borderRadius: state.borderRadius == 1? 0.87 : 1, isSelected: true),
      );
    } else {
      // If selected, set isSelected to false and after a delay, change the border radius
      emit(
        state.copyWith(isSelected: false),
      );
      Future.delayed(const Duration(milliseconds: 600)).then(
        (value) => emit(
          state.copyWith(
            borderRadius: state.borderRadius == 1? 0.87 : 1,
          ),
        ),
      );
    }
  }

  // Method to reset state values
  void resetStateValues() {
    // Reset all state values to their default values
    emit(state.copyWith(
        borderRadius: 0.87,
        profileSize: 0,
        flightCardSize: 0,
        showtravelTextAnim: false,
        showFlyInfoAnim: false));
  }

  // Method to change the selected index of the bottom navigation bar
  void changeBottomNavbarSelectedIndex(int index, BuildContext context) {
    // Change the selectedNavBar value and navigate to the corresponding page
    emit(
      state.copyWith(selectedNavBar: index),
    );
    if (index == 0) {
      context.go('/homePage');
    } else if (index == 2) {
      context.go('/');
    }
  }

  // Method to initialize animations on the home page
  Future<void> initHomePageAnim(
    BuildContext context,
  ) async {
    // Reset state values
    resetStateValues();

    // After a delay, change the profileSize value
    await Future.delayed(
      const Duration(milliseconds: 950),
    );
    emit(
      state.copyWith(profileSize: 50),
    );

    // After another delay, set showtravelTextAnim to true
    await Future.delayed(
      const Duration(milliseconds: 800),
    ).then((value) {
      emit(
        state.copyWith(showtravelTextAnim: true),
      );
    });

    // After another delay, calculate the device width and set flightCardSize to it
    await Future.delayed(
      const Duration(milliseconds: 1600),
    ).then((value) {
      double deviceWidth = MediaQuery.of(context).size.width;
      emit(state.copyWith(flightCardSize: deviceWidth));
    });
  }
}