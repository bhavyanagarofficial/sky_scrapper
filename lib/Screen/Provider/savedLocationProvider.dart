import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedLocationProvider extends ChangeNotifier {
  List<String> savedWeatherList = [];

  Future<void> addToSavedLocation(
      String name,String region,String country, String status, dynamic temp,int isDay, dynamic maxtemp_c,dynamic mintemp_c) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool check = false;
    String data = "${name}_${region}_${country}_${status}_${temp}_${isDay}_${mintemp_c}_$maxtemp_c";
    for(int i=0; i<savedWeatherList.length; i++){
      if(savedWeatherList[i] == data){
        check =  true;
      }
    }
    if(!check){
      savedWeatherList.add(data);
    }
    Fluttertoast.showToast(
      msg: (check == false)
          ? 'Location add to favorites'
          : 'This location already exist',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16,
    );
    print(savedWeatherList);
    sharedPreferences.setStringList('weather', savedWeatherList);
    notifyListeners();
  }

  Future<void> getList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    savedWeatherList = sharedPreferences.getStringList('weather') ?? [];
  }

  SavedLocationProvider() {
    getList();
  }

  Future<void> removeFromSaved(int index) async {
    savedWeatherList.removeAt(index);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList('weather', savedWeatherList);
    notifyListeners();
  }
}
