import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:parkour_app/data/api_provider.dart';
import 'package:parkour_app/data/user_model.dart';
//contains all the api calls related to authentication
class AuthRepo {
  UserModel? userModel;
  final _controller = StreamController<bool>();
  final storage=const FlutterSecureStorage();
  AndroidOptions getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );
  Stream<bool> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    var jwt=await storage.read(key: 'jwt',aOptions: getAndroidOptions());

    print(jwt);
    bool isSignedIn = await storage.containsKey(key: 'jwt',aOptions: getAndroidOptions());

    if (isSignedIn == false) {
      print("working");
    }
    else
      {try
      {
        Response data=await ApiProvider().validate(jwt!);
        userModel= UserModel.fromJson(jsonDecode(data.body));
      }
     catch(e)
    {
      print(e);
      isSignedIn=false;
      storage.delete(key: 'jwt',aOptions: getAndroidOptions());
    }
      }
    print(isSignedIn);
    yield isSignedIn;
    yield* _controller.stream;
  }

  void login(String email, String password) async {
    try {
      ApiProvider provider = ApiProvider();

      Response response= await provider.loginUser(email, password);
      userModel=UserModel.fromJson(json.decode(response.body));
      storage.write(key: 'jwt', value: response.headers['authorization'],aOptions: getAndroidOptions());
      storage.write(key: 'userData', value:response.body);
      print("here");
      _controller.add(true);

    } catch (e) {
      print(e);
    }
  }

  void logOut() async {
    try {
      ApiProvider provider = ApiProvider();
       await provider.logout();
       storage.delete(key: 'jwt',aOptions: getAndroidOptions());
      storage.delete(key: 'userData',aOptions: getAndroidOptions());
      _controller.add(false);
      userModel=null;
    } catch (e) {
      print(e);
    }
  }

  void signUp(String name, String phoneNumber, String email, String password) async
  {
    try {
      ApiProvider provider = ApiProvider();
      Response response= await provider.signUpUser(name,phoneNumber,email, password);
      userModel=UserModel.fromJson(jsonDecode(response.body));
      storage.write(key: 'jwt', value: response.headers['Authorization'],aOptions: getAndroidOptions());
      storage.write(key: 'userData', value:response.body);
      _controller.add(true);
    } catch (e) {
      print(e);
    }
  }
}
