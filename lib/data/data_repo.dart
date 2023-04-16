import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:parkour_app/data/api_provider.dart';
import 'package:parkour_app/view/home/booking/slot.dart';
//contains all the api calls other than authentication
class DataRepo {
  Map<int, List<Space>> slots = {1:[],2:[],3:[]};
  Map columns = {1: "a", 2: "b", 3: "c", 4: "d", 5: "e", 6: "f"};
  List availableSpaces=[];
  final _controller = StreamController<bool>();
  Stream<bool> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));

    yield true;
    yield* _controller.stream;
  }
  String otp="";
  DataRepo() {
    List<Space> spaces;
    for (int i = 1; i <= 3; i++) {
      spaces = [];
      for (int j = 1; j <= 6; j++) {
        spaces.add(Space(i, j));
      }
      slots[i] = spaces;
      print(slots);
    }
    // getAvailableSpaces();
  }
  void getAvailableSpaces()
  async {
    Timer.periodic(Duration(seconds: 10), (timer) async{
      print("working");
      ApiProvider provider=ApiProvider();
      var data=await provider.getAvailableSpaces();
      availableSpaces=data['spaces'];

      for(var element in availableSpaces)
        {
          if(element['available']=="false")
            {
              slots[element['row']]![element['column']-1].spaceColor=Colors.red;
            }
          else
            {
              slots[element['row']]![element['column']-1].spaceColor=Colors.green;
            }

        }
      _controller.add(true);

    });
  }

  Future<bool> book(String jwt,{String checkInTime="",String checkOutTime="",String status="booked"}) async {
    try {
      ApiProvider provider = ApiProvider();

      var data= await provider.book(status,jwt: jwt,checkInTime: checkInTime,checkOutTime: checkOutTime);
      print("here again");
      otp=jsonDecode(data)['otp'];
      return true;
    } catch (e) {
      return false;
    }
  }
}