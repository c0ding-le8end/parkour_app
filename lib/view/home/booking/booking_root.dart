import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkour_app/bloc/data_bloc/user_bloc.dart';
import 'package:parkour_app/data/auth_repo.dart';
import 'package:parkour_app/view/errorDialog.dart';
import 'package:parkour_app/view/home/booking/booking_details.dart';

import 'booking.dart';

class BookingRoot extends StatefulWidget {
  const BookingRoot({Key? key}) : super(key: key);

  @override
  State<BookingRoot> createState() => _BookingRootState();
}

class _BookingRootState extends State<BookingRoot> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookBloc,BookingState>(
        listener:(context,state)
        {
          if(state is UnsuccessfullyBooked)
            {
showErrorDialog(context);
            }
          if(state is SuccessfullyBooked&& state.errorState==true)
            {
showAlertDialog(context);
            }
        },builder: (context,state)
    {
      if(state is SuccessfullyBooked || RepositoryProvider.of<AuthRepo>(context).userModel!.details!.statusOfLastBooking=="booked")
      {
        print("builder executed for SuccessfullyBooked");
        //for working on the aadhaar api comment out the code from line 42 to line 47
        return BookingDetails();
      }
      if(state is UnsuccessfullyBooked)
      {
        print("unauthenticated state reached");
        return const Booking();
      }
      else if(state is Unknown){
        return const Booking();
      }
      else{
        return Scaffold(body:Container());
      }
    });
  }
}
