import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:parkour_app/bloc/cubits/space_cubit.dart';
import 'package:parkour_app/view/custom_drawer.dart';

import 'slot.dart';

class AvailableSpaces extends StatefulWidget {
  const AvailableSpaces({Key? key}) : super(key: key);

  @override
  State<AvailableSpaces> createState() => _AvailableSpacesState();
}

class _AvailableSpacesState extends State<AvailableSpaces> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 33,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                  onPressed: () {
                    ZoomDrawer.of(context)!.toggle();
                  },
                  icon: Icon(
                    Icons.menu,
                    color: Colors.black,
                  )),
            ),
            SizedBox(
              height: 54,
            ),
            Text(
              "Select preferred space",
              style: TextStyle(
                  color: Color(0xFF757F8C),
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 14,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: EdgeInsets.only(left: 26, top: 6),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border:
                        Border.all(color: Color(0xFFA6AAB499).withOpacity(0.6)),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 4,
                        spreadRadius: 0,
                        color: Colors.black.withOpacity(0.25),
                      )
                    ]),
                width: MediaQuery.of(context).size.width,
                height: 316,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "5 slots available",
                      style: TextStyle(
                          color: Color(0xFF3B414B),
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        BlocBuilder<SpaceCubit, int>(builder: (context, state) {
                          return Column(
                            children: List.generate(3, (index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: Slot(
                                  row: index + 1,
                                  set: 0,
                                ),
                              );
                            }),
                          );
                        }),
                        const SizedBox(
                          width: 28,
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xFFA6AAB4))),
                              height: 253,
                              width: 0,
                            ),
                            Column(
                              children: const [
                                ImageIcon(
                                  AssetImage("assets/icons/black_car.png"),
                                  size: 24,
                                ),
                                SizedBox(
                                  height: 91,
                                ),
                                ImageIcon(
                                  AssetImage("assets/icons/black_car.png"),
                                  size: 24,
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 28,
                        ),
                        BlocBuilder<SpaceCubit, int>(builder: (context, state) {
                          print("state changed");
                          return Column(
                            children: List.generate(3, (index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: Slot(
                                  row: index + 1,
                                  set: 1,
                                ),
                              );
                            }),
                          );
                        }),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
