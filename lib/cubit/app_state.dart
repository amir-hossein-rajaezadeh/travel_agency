import 'package:equatable/equatable.dart';

class AppState extends Equatable {
  final double borderRadius;
  final bool isSelected;
  final int selectedNavBar;
  final double profileSize;
  final double flightCardSize;
  final bool showtravelTextAnim;
  final bool showFlyInfoAnim;

  const AppState(
      {required this.borderRadius,
      required this.isSelected,
      required this.selectedNavBar,
      required this.profileSize,
      required this.flightCardSize,
      required this.showtravelTextAnim,
      required this.showFlyInfoAnim});

  AppState copyWith({
    double? borderRadius,
    bool? isSelected,
    int? selectedNavBar,
    double? profileSize,
    double? flightCardSize,
    bool? showtravelTextAnim,
    bool? showFlyInfoAnim,
  }) {
    return AppState(
        borderRadius: borderRadius ?? this.borderRadius,
        isSelected: isSelected ?? this.isSelected,
        selectedNavBar: selectedNavBar ?? this.selectedNavBar,
        profileSize: profileSize ?? this.profileSize,
        showFlyInfoAnim: showFlyInfoAnim ?? this.showFlyInfoAnim,
        flightCardSize: flightCardSize ?? this.flightCardSize,
        showtravelTextAnim: showtravelTextAnim ?? this.showtravelTextAnim);
  }

  @override
  List<Object?> get props => [
        borderRadius,
        isSelected,
        selectedNavBar,
        profileSize,
        flightCardSize,
        showFlyInfoAnim,
        showtravelTextAnim
      ];
}
