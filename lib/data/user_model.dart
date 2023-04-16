class UserModel {
  String? startTimeOfPreviousBooking;
  String? endTimeOfPreviousBooking;
  int? billAmountOfPreviousBooking;

  Details? details;

  UserModel(
      {this.startTimeOfPreviousBooking,
      this.endTimeOfPreviousBooking,
      this.details,
      this.billAmountOfPreviousBooking});

  UserModel.fromJson(Map<String, dynamic> json) {
    startTimeOfPreviousBooking =
        json['start_time_of_previous_booking'];
    endTimeOfPreviousBooking =
        json['end_time_of_previous_booking'];
    billAmountOfPreviousBooking=json['bill_amount_of_previous_booking'];
    details =
        json['details'] != null ? Details.fromJson(json['details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['start_time_of_previous_booking'] =
        this.startTimeOfPreviousBooking;
    data['end_time_of_previous_booking'] =
        this.endTimeOfPreviousBooking;
    data['bill_amount_of_previous_booking']=this.billAmountOfPreviousBooking;
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    return data;
  }
}

class Details {
  String? email;
  String? name;
  List<ParkingHistory>? parkingHistory;
  String? statusOfLastBooking;
  String? userId;

  Details(
      {this.email,
      this.name,
      this.parkingHistory,
      this.statusOfLastBooking,
      this.userId});

  Details.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    if (json['parking_history'] != null) {
      parkingHistory = <ParkingHistory>[];
      json['parking_history'].forEach((v) {
        parkingHistory!.add(new ParkingHistory.fromJson(v));
      });
    }
    statusOfLastBooking = json['status_of_last_booking'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    if (this.parkingHistory != null) {
      data['parking_history'] =
          this.parkingHistory!.map((v) => v.toJson()).toList();
    }
    data['status_of_last_booking'] = this.statusOfLastBooking;
    data['user_id'] = this.userId;
    return data;
  }
}

class ParkingHistory {
  String? date;
  String? endTime;
  String? startTime;
  String? statusOfParking;
  String? slotId;
  int? cost;

  ParkingHistory(
      {this.date,
      this.endTime,
      this.startTime,
      this.statusOfParking,
      this.slotId,this.cost});

  ParkingHistory.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    endTime = json['end_time'];
    startTime = json['start_time'];
    statusOfParking = json['status_of_parking'];
    slotId = json['slot_id'];
    cost=json['cost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['end_time'] = this.endTime;
    data['start_time'] = this.startTime;
    data['status_of_parking'] = this.statusOfParking;
    data['slot_id'] = this.slotId;
    data['cost']=this.cost;
    return data;
  }
}
