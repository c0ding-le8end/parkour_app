import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkour_app/data/auth_repo.dart';
import 'package:parkour_app/data/data_repo.dart';

abstract class BookingEvent
{}

class Booked extends BookingEvent
{
final DateTime checkInTime;
final DateTime checkOutTime;

  Booked(this.checkInTime, this.checkOutTime);
}
class Finished extends BookingEvent
{}

abstract class BookingState
{
}
class SuccessfullyBooked extends BookingState
{
  final bool errorState;

  SuccessfullyBooked({this.errorState=false});
}
class UnsuccessfullyBooked extends BookingState
{}
class FinishedState extends BookingState
{}

class Unknown extends BookingState
{}
class BookBloc extends Bloc<BookingEvent, BookingState> {

  BookBloc(this._repository, this._authRepo) :super(Unknown()) {
    on<Booked>((event, emit) async{
      String? jwt=await _authRepo.storage.read(key: 'jwt',aOptions: _authRepo.getAndroidOptions());
      bool success=await _repository.book(jwt!,checkInTime:event.checkInTime.toString(),checkOutTime:event.checkOutTime.toString());
      if(success)
        {
          _authRepo.userModel?.startTimeOfPreviousBooking=event.checkInTime.toString();
          _authRepo.userModel?.endTimeOfPreviousBooking=event.checkOutTime.toString();
          _authRepo.userModel?.billAmountOfPreviousBooking=event.checkOutTime.difference(event.checkInTime).inHours * 20;
          emit(SuccessfullyBooked());
        }
      else
        {
          emit(UnsuccessfullyBooked());
        }
    });
    on<Finished>((event, emit) async{
      String? jwt=await _authRepo.storage.read(key: 'jwt',aOptions: _authRepo.getAndroidOptions());
      bool success=await _repository.book(jwt!,status: "finished");
      if(success)
      {
        emit(FinishedState());
      }
      else
      {
        emit(SuccessfullyBooked(errorState: true));
      }
    });

  }


  final DataRepo _repository;
  final AuthRepo _authRepo;
  late StreamSubscription<bool> _authenticationStatusSubscription;

}