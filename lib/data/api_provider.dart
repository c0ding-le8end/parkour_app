import 'dart:convert';
import 'package:http/http.dart';

class ApiProvider {
  Future loginUser(String email, String password) async {
    Response response = await post(Uri.parse("http://10.0.2.2:5000/login"),
        body: {'email': email, 'password': password});
    if (response.statusCode == 200) {
      // print("we are here");
      print(response.body);
      return response;
    } else {
      // print("91-api.dart ${response.body}");
      throw Exception("Error recieving data");
    }
  }

  Future signUpUser(
      String name, String phoneNumber, String email, String password) async {
    Response response = await post(
        Uri.parse("http://10.0.2.2:5000/signup"), //api call
        body: {
          'name': name,
          'phone_number': phoneNumber,
          'email': email,
          'password': password
        });
    if (response.statusCode == 200) {
      // print("we are here");
      // print(response.headers);
      return response;
    } else {
      print(response.body);
      throw response.body;
    }
  }

  Future getData() async {
    Response response =
        await get(Uri.parse('http://10.0.2.2:5000/user'), headers: {});
    if (response.statusCode == 200) {
      print("response body is here${response.body}");
      return response.body;
    } else {
      // print("103-api.dart ${response.body}");
      throw Exception(response.body);
    }
  }
Future validate(String jwt)async
{
  Response response =
      await get(Uri.parse('http://10.0.2.2:5000/validate'), headers: {'Authorization': "Bearer " + jwt},);
  if(response.statusCode==200)
    {
      return response;
    }
  else
    {
      throw response.body;
    }
}
  Future book(String status,{String jwt="", String checkInTime="", String checkOutTime=""}) async {
    try {
      Response response = await post(Uri.parse("http://10.0.2.2:5000/book"),
          headers: {'Authorization': "Bearer " + jwt},
          body: {'checkInTime': checkInTime,'checkOutTime':checkOutTime});
      if (response.statusCode == 200) {
        print("we are here");
        return response.body;
      } else {
        throw response.body;
      }
    } catch (e) {
     print("provider catch executed");
    }
  }

  Future logout() async {
    try {
      Response response = await get(Uri.parse("http://10.0.2.2:5000/logout"));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw response.body;
      }
    } catch (e) {
      print(e);
    }
  }

  Future getAvailableSpaces() async {
    try {
      Response response =
          await get(Uri.parse("http://10.0.2.2:5000/getAvailableSpaces"));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw response.body;
      }
    } catch (e) {
      print(e);
    }
  }
}
