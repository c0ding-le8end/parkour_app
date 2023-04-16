import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:intl/intl.dart';
import 'package:parkour_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:parkour_app/bloc/data_bloc/user_bloc.dart';
import 'package:parkour_app/data/auth_repo.dart';
import 'package:parkour_app/data/data_repo.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BookingDetails extends StatefulWidget {
  const BookingDetails({Key? key}) : super(key: key);

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  late String checkInTime;
  late String checkOutTime;
  late int billAmount;
  late Timer _timer;
  bool overtime=false;
  Duration? timeDifference;

  @override
  void initState() {
    checkInTime = RepositoryProvider.of<AuthRepo>(context)
        .userModel!
        .startTimeOfPreviousBooking!;
    checkOutTime = RepositoryProvider.of<AuthRepo>(context)
        .userModel!
        .endTimeOfPreviousBooking!;
    billAmount=RepositoryProvider.of<AuthRepo>(context).userModel!.billAmountOfPreviousBooking!;


print(checkOutTime);
    timer();
    super.initState();
  }

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
            const SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.center,
              child: QrImage(
                data:
                    "${RepositoryProvider.of<AuthRepo>(context).userModel!.details!.userId!} ${RepositoryProvider.of<DataRepo>(context).otp}",
                version: QrVersions.auto,
                size: 150.0,
              ),
            ),
            const SizedBox(
              height: 51,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.only(left: 26, top: 6, right: 26),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: const Color(0xFFA6AAB499).withOpacity(0.6)),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 4),
                        blurRadius: 4,
                        spreadRadius: 0,
                        color: Colors.black.withOpacity(0.25),
                      )
                    ]),
                width: MediaQuery.of(context).size.width,
                height: 316,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 11,
                    ),
                    const Text(
                      "Booking Details",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Color(0xFF3B414B)),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Row(children: [
                      const Text(
                        "Check-in Time",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0xFF757F8C)),
                      ),
                      const Spacer(),
                      Text(
                        DateFormat('h:mm a')
                            .format(DateTime.parse(checkInTime)),
                        style: const TextStyle(
                            color: Color(0xFF3B414B),
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      )
                    ]),
                    const SizedBox(
                      height: 14,
                    ),
                    Row(children: [
                      const Text(
                        "Check-out Time",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0xFF757F8C)),
                      ),
                      const Spacer(),
                      Text(
                        DateFormat('h:mm a')
                            .format(DateTime.parse(checkOutTime)),
                        style: const TextStyle(
                            color: Color(0xFF3B414B),
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      )
                    ]),
                    SizedBox(
                      height: 14,
                    ),
                    Row(children: [
                      const Text(
                        "Time Remaining",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0xFF757F8C)),
                      ),
                      const Spacer(),
                      if (DateTime.parse(checkInTime)
                              .compareTo(DateTime.now()) <
                          0 &&DateTime.parse(checkOutTime)
                          .compareTo(DateTime.now()) >
                          0&&timeDifference!=null)
                        Text(
                          "${timeDifference!.inHours.toString().padLeft(2, '0')}:${(timeDifference!.inMinutes % 60).toString().padLeft(2, '0')}:${(timeDifference!.inSeconds % 60).toString().padLeft(2, '0')}",
                          style: const TextStyle(
                              color: Color(0xFF3B414B),
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        )
                      else
                      if(DateTime.parse(checkOutTime)
                          .compareTo(DateTime.now()) <
                          0&&timeDifference!=null)
                        Text(
                          "${timeDifference!.inHours.toString().padLeft(2, '0')}:${(timeDifference!.inMinutes % 60).toString().padLeft(2, '0')}:${(timeDifference!.inSeconds % 60).toString().padLeft(2, '0')}",
                          style: const TextStyle(
                              color: Color(0xFF3B414B),
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        )
                    ]),
                    SizedBox(
                      height: 36,
                    ),
                    Row(children: [
                      const Text(
                        "Bill amount",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0xFF757F8C)),
                      ),
                      const Spacer(),
                      Text(
                        "₹$billAmount",
                        style: TextStyle(
                            color: overtime?Colors.red:Colors.green,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                            fontSize: 18),
                      )
                    ]),
                    SizedBox(height: 18,),
                    Container(
                      height: 56,
                      width: 343,
                      decoration:
                      BoxDecoration(color:Color(0xFF613EEA), boxShadow: [
                          BoxShadow(offset: Offset(0, 4), blurRadius: 4, spreadRadius: 0)
                      ]),
                      child: TextButton(
                        onPressed: () {
                          BlocProvider.of<BookBloc>(context).add(Finished());
                        },
                        child: const Text(
                          "Pay amount",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                      ),
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

  timer() {
    _timer=Timer.periodic(Duration(seconds: 1), (timer) {


      if (DateTime.now().compareTo(DateTime.parse(checkOutTime)) >= 0) {
        timeDifference = DateTime.now().difference(DateTime.parse(checkOutTime));
       setState(() {
         overtime=true;
         billAmount=DateTime.now().difference(DateTime.parse(checkOutTime)).inSeconds;
       });
        // print("83-authController ${cancelTimer.value}");
      }
      else
        {
          setState(() {
            timeDifference = DateTime.parse(checkOutTime).difference(DateTime.now());
          });
        }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
