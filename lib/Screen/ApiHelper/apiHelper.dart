import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class ApiHelper{
  static ApiHelper apiHelper = ApiHelper._();

  ApiHelper._();

  Future<Map> fetchApiData(String search) async {

    Uri url = Uri.parse("https://api.weatherapi.com/v1/forecast.json?key=62567fa7065a4e34911113108243007&q=$search");
    Response response = await http.get(url);

    if (response.statusCode == 200) {
      final json = response.body;
      final Map data = jsonDecode(json);
      return data;
    } else {
      return {};
    }
  }
}
