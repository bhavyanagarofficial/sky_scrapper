import 'package:flutter/material.dart';
import 'package:sky_scrapper/Screen/ApiHelper/apiHelper.dart';
import 'package:sky_scrapper/Screen/Modal/homeModel.dart';
import 'package:sky_scrapper/Screen/View/homePage.dart';

class HomeProvider extends ChangeNotifier {
  HomeModel? homeModel;
  String search = 'surat';
  bool isOn = false;

  void searchLocation(String search){
    this.search = search;
    notifyListeners();
  }

  Future<HomeModel?> fromMap(String search) async {
    final data = await ApiHelper.apiHelper.fetchApiData(search);
    homeModel = HomeModel.fromJson(data);
    return homeModel;
  }

  void changeTemperature(){
    changeTemp = !changeTemp;
    notifyListeners();
  }

  void switchOnOff(value){
    isOn = value;
    notifyListeners();
  }

  // void updateDrawerPageColor(int isDay){
  //   isNightOrDay = isDay;
  //   print(isNightOrDay);
  //   notifyListeners();
  // }
}