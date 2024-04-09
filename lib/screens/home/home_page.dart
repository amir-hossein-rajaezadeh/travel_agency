import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_agency/cubit/app_cubit.dart';
import 'package:travel_agency/cubit/app_state.dart';
import 'package:travel_agency/screens/shared/button_nav_bar.dart';
import 'package:travel_agency/utils/my_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final AnimationController _arrowUpDownController = AnimationController(
    duration: const Duration(milliseconds: 800),
    vsync: this,
  );
  late final AnimationController _flightDirectionController =
      AnimationController(
    duration: const Duration(milliseconds: 900),
    vsync: this,
  );
  late final AnimationController _travelTransferMethodController =
      AnimationController(
    duration: const Duration(milliseconds: 900),
    vsync: this,
  );
  late Animation<double> flightDirectionAnim =
      Tween<double>(begin: 0, end: 1).animate(_flightDirectionController);
  late final Animation<double> _arrowUpDownAnim =
      Tween<double>(begin: 0, end: 1).animate(_arrowUpDownController);
  late Animation<double> travelTransferMethodAnim =
      Tween<double>(begin: 0, end: 1).animate(_travelTransferMethodController);

  late final AnimationController _airplaneController = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );

  late final AnimationController _nameFadeTranstionController =
      AnimationController(
    duration: const Duration(milliseconds: 3000),
    vsync: this,
  );
  late final Animation<Offset> _airplaneAnim = Tween<Offset>(
    begin: const Offset(-0.6, 0.0),
    end: const Offset(2.5, 0.0),
  ).animate(_airplaneController);

  late final Animation<double> _nameFadeTranstion = Tween<double>(
    begin: 0.0,
    end: 1,
  ).animate(_nameFadeTranstionController);

  late final AnimationController _cardController = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  // defining the Offset of the animation
  late final Animation<double> _cardAnimation = CurvedAnimation(
    parent: _cardAnimation,
    curve: Curves.fastOutSlowIn,
  );
  @override
  void initState() {
    _cardController.forward();
    initFun(context);

    super.initState();
  }

  @override
  void dispose() {
    _airplaneController.dispose();
    _nameFadeTranstionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20, top: 20),
                            child: Row(
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 700),
                                  width: state.profileSize,
                                  height: state.profileSize,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      'assets/images/profile.jpeg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                FadeTransition(
                                  opacity: _nameFadeTranstion,
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 15),
                                    child: const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Hello,',
                                          style: TextStyle(
                                              color: MyColors.mediumGrey,
                                              fontSize: 14),
                                        ),
                                        Text(
                                          'AmirHossein',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 20, top: 18),
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: MyColors.mediumGrey),
                            ),
                            child: const Icon(
                              Iconsax.category5,
                              size: 18,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    if (state.showtravelTextAnim)
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(
                          top: 38,
                          left: 20,
                          right: 20,
                        ),
                        child: DefaultTextStyle(
                            style: GoogleFonts.pridi(
                                color: Colors.white,
                                height: 1,
                                fontSize: 30,
                                fontWeight: FontWeight.w600),
                            child: AnimatedTextKit(
                              isRepeatingAnimation: false,
                              pause: const Duration(milliseconds: 500),
                              animatedTexts: [
                                TypewriterAnimatedText(
                                    state.showtravelTextAnim
                                        ? 'Book your best\nand joyful vacation'
                                        : '',
                                    speed: const Duration(milliseconds: 80))
                              ],
                            )),
                      )
                    else
                      Container(
                        height: 97,
                      ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 20, right: 20, left: 20),
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          Column(
                            children: [
                              _buildFlyInfoWidget(
                                  size, 'St. Petersburg', 0, state),
                              _buildFlyInfoWidget(size, 'To', 1, state),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: _buildFlyInfoWidget(
                                        size, 'Date', 2, state),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Flexible(
                                    child: _buildFlyInfoWidget(
                                        size, 'Passengers', 3, state),
                                  )
                                ],
                              )
                            ],
                          ),
                          ScaleTransition(
                            scale: _arrowUpDownAnim,
                            alignment: Alignment.center,
                            child: Container(
                              margin:
                                  const EdgeInsets.only(bottom: 50, right: 20),
                              width: 35,
                              height: 35,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Icon(
                                  CupertinoIcons.arrow_up_arrow_down,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    _buildFlightDirectionWidget(size, state),
                    buildTravelTransferMethodWidget(size, state),
                  ],
                ),
                ButtonNavBarWidget(state: state)
              ],
            );
          },
        ),
      ),
    );
  }

  ScaleTransition buildTravelTransferMethodWidget(Size size, AppState state) {
    return ScaleTransition(
      scale: _travelTransferMethodController,
      child: Container(
        alignment: Alignment.center,
        width: size.width,
        margin: const EdgeInsets.only(right: 20, left: 20, top: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: MyColors.mediumBlue),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
              width: size.width,
              height: 85,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: MyColors.darkBlue),
              child: Container(
                margin: const EdgeInsets.only(top: 8, left: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Flight Ticket',
                        style: GoogleFonts.pridi(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500)),
                    Image.asset('assets/images/airplane.png'),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 8, right: 10, left: 12),
              child: Row(
                children: [
                  Flexible(
                    child: Container(
                      height: 90,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: MyColors.darkBlue),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 8, left: 12),
                            child: Text(
                              'Hotel',
                              style: GoogleFonts.pridi(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(18)),
                            child: Image.asset(
                              'assets/images/hotel.png',
                              alignment: Alignment.bottomRight,
                              height: 85,
                              width: 100,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Flexible(
                    child: Container(
                      width: size.width,
                      height: 90,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: MyColors.darkBlue),
                      child: Container(
                        width: size.width,
                        margin: const EdgeInsets.only(top: 8, left: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Transfer',
                              style: GoogleFonts.pridi(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.bottomRight,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(25)),
                                  child: Image.asset(
                                    'assets/images/car.png',
                                    alignment: Alignment.bottomRight,
                                    height: 60,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8)
          ],
        ),
      ),
    );
  }

  ScaleTransition _buildFlightDirectionWidget(Size size, AppState state) {
    return ScaleTransition(
      alignment: Alignment.center,
      scale: flightDirectionAnim,
      child: Container(
        alignment: Alignment.center,
        width: size.width,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              color: MyColors.darkOrange),
          margin: const EdgeInsets.only(right: 20, left: 20, top: 28),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 45,
                  height: 45,
                  margin: const EdgeInsets.only(left: 12, top: 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset('assets/images/airplane_logo.jpg',
                        fit: BoxFit.cover),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 12, top: 12),
                  child: Text(
                    '14 Octobr 2023',
                    style: GoogleFonts.pridi(
                        fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 30, left: 12),
                          child: Text(
                            'DME',
                            style: GoogleFonts.pridi(
                                fontSize: 35,
                                fontWeight: FontWeight.w800,
                                height: 1),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10, top: 3),
                          child: Text(
                            'Moscow, Russia',
                            style: GoogleFonts.pridi(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    SlideTransition(
                      position: _airplaneAnim,
                      child: const RotatedBox(
                        quarterTurns: 1,
                        child: Icon(
                          Iconsax.airplane5,
                          size: 28,
                          color: MyColors.mediumGrey,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 35, right: 12),
                          child: Text(
                            'LIS',
                            style: GoogleFonts.pridi(
                                fontSize: 35,
                                fontWeight: FontWeight.w800,
                                height: 1),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 12, top: 3),
                          child: Text(
                            'Lisbon, Portugal',
                            style: GoogleFonts.pridi(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFlyInfoWidget(
      Size size, String value, int index, AppState state) {
    return AnimatedContainer(
      duration: Duration(
          milliseconds: index == 0
              ? 1500
              : index == 1
                  ? 1650
                  : index == 2
                      ? 4500
                      : 4500),
      width: state.flightCardSize,
      height: 45,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: MyColors.mediumGrey),
      child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 12,
              ),
              if (index == 2 || index == 3)
                Row(
                  children: [
                    Icon(
                      index == 2 ? Iconsax.calendar_1 : CupertinoIcons.person_2,
                      color: MyColors.mediumGrey2,
                    ),
                    const SizedBox(
                      width: 0,
                    ),
                  ],
                ),
              const SizedBox(
                width: 5,
              ),
              Text(
                value,
                textAlign: TextAlign.left,
                style: GoogleFonts.pridi(
                    color: index == 0 ? Colors.white : MyColors.mediumGrey2,
                    fontSize: 17),
              ),
            ],
          )),
    );
  }

  Future<void> initFun(
    BuildContext context,
  ) async {
    context.read<AppCubit>().initHomePageAnim(
          context,
        );
    _nameFadeTranstionController.forward();
    await Future.delayed(const Duration(milliseconds: 5000));

    _arrowUpDownController.forward();
    _cardController.forward();

    await Future.delayed(const Duration(milliseconds: 900));
    _flightDirectionController.forward();

    await Future.delayed(const Duration(milliseconds: 550));
    _airplaneController.forward();

    await Future.delayed(const Duration(milliseconds: 500));
    _travelTransferMethodController.forward();
  }
}
