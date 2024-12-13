import 'package:flutter/material.dart';
import '../ApiHelper/apiHelper.dart';
import '../Modal/homeModel.dart';
import '../View/searchLocation.dart';

class SearchProvider extends ChangeNotifier {
  HomeModel? homeModel;
  String search = 'mumbai';

  void searchLocation(String location){
    search = location;
    isShow = true;
    notifyListeners();
  }

  void showWholeList(){
    isShow = false;
    notifyListeners();
  }

  void searchLocationOnly(String location){
    search = location;
    notifyListeners();
  }

  Future<HomeModel?> fromMap(String search) async {
    final data = await ApiHelper.apiHelper.fetchApiData(search);
    homeModel = HomeModel.fromJson(data);
    return homeModel;
  }
}