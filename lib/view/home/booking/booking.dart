import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:intl/intl.dart';
import 'package:parkour_app/bloc/data_bloc/user_bloc.dart';

//booking screen
class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  DateTime? checkInTime = DateTime.now();
  DateTime? checkOutTime = DateTime.now().add(const Duration(hours: 1));
bool validSlot=false;
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
              "Select preferred time",
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
                padding: const EdgeInsets.only(left: 26, top: 6, right: 26),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(children: [
                      const Text(
                        "Check-in Time",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0xFF757F8C)),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () async {
                            final TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              builder: (BuildContext context, Widget? child) {
                                return MediaQuery(
                                  data: MediaQuery.of(context)
                                      .copyWith(alwaysUse24HourFormat: false),
                                  child: child!,
                                );
                              },
                            );
                            if (picked != null &&
                                (picked.hour > TimeOfDay.now().hour ||
                                    picked.hour == TimeOfDay.now().hour &&
                                        picked.minute >
                                            TimeOfDay.now().minute)) {
                              print(picked.hour);
                              print(picked.minute);
                              setState(() {
                                checkInTime = DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day,
                                    picked.hour,
                                    picked.minute);
                              });
                              if(checkInTime!.compareTo(checkOutTime!)<0&&checkInTime!=DateTime.now())
                              {
                                setState(() {
                                  validSlot=true;
                                });
                              }
                              else
                              {
                                setState(() {
                                  validSlot=false;
                                });
                              }
                            } else {
                              setState(() {
                                checkInTime = DateTime.now();
                              });
                            }
                          },
                          icon: Icon(
                            Icons.edit_calendar,
                            size: 20,
                          )),
                      Text(
                        DateFormat('h:mm a').format(checkInTime!),
                        style: const TextStyle(
                            color: Color(0xFF3B414B),
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      )
                    ]),
                    Row(children: [
                      const Text(
                        "Check-out Time",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0xFF757F8C)),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () async {
                            final TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              builder: (BuildContext context, Widget? child) {
                                return MediaQuery(
                                  data: MediaQuery.of(context)
                                      .copyWith(alwaysUse24HourFormat: false),
                                  child: child!,
                                );
                              },
                            );
                            if (picked != null &&
                                (picked.hour > checkInTime!.hour ||
                                    picked.hour == checkInTime!.hour &&
                                        picked.minute > checkInTime!.minute)) {
                              setState(() {
                                checkOutTime = DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day,
                                    picked.hour,
                                    picked.minute);
                              });
                              if(checkInTime!.compareTo(checkOutTime!)<0&&checkInTime!=DateTime.now())
                              {
                                setState(() {
                                  validSlot=true;
                                });
                              }
                              else
                                {
                                  print("here");
                                  setState(() {
                                    validSlot=false;
                                  });
                                }
                            } else {
                              setState(() {
                                checkOutTime = DateTime.now();
                              });
                            }
                          },
                          icon: const Icon(
                            Icons.edit_calendar,
                            size: 20,
                          )),
                      Text(
                        DateFormat('h:mm a').format(checkOutTime!),
                        style: const TextStyle(
                            color: Color(0xFF3B414B),
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      )
                    ]),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 75,
            ),
            Container(
              height: 56,
              width: 343,
              decoration:
                   BoxDecoration(color: validSlot?Color(0xFF613EEA):Color(0xFF613EEA).withOpacity(0.4), boxShadow: [
                if(validSlot)
                     BoxShadow(offset: Offset(0, 4), blurRadius: 4, spreadRadius: 0)
              ]),
              child: TextButton(
                onPressed: () {
                  if(validSlot)
                    {
                      print(checkInTime);
                      print(checkOutTime);
                      BlocProvider.of<BookBloc>(context).add(Booked(checkInTime!,checkOutTime!));
                    }
                },
                child: const Text(
                  "Book Space",
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
    );
  }
}
