import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_scrapper/Screen/Modal/homeModel.dart';
import '../Provider/homeProvider.dart';
import '../Provider/searchPageProvider.dart';

bool isShow = false;
TextEditingController controller = TextEditingController();

class SearchLocation extends StatelessWidget {
  HomeModel hm;

  SearchLocation({super.key, required this.hm});

  @override
  Widget build(BuildContext context) {
    SearchProvider searchProviderFalse =
        Provider.of<SearchProvider>(context, listen: false);
    SearchProvider searchProviderTrue =
        Provider.of<SearchProvider>(context, listen: true);
    HomeProvider homeProviderFalse =
        Provider.of<HomeProvider>(context, listen: false);
    HomeProvider homeProviderTrue =
    Provider.of<HomeProvider>(context, listen: true);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            (hm.current.isDay == 1)
                ? Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xff0659c6),
                          Color(0xff4389f3),
                        ],
                      ),
                    ),
                  )
                : Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xff19043D),
                          Color(0xff341152),
                        ],
                      ),
                    ),
                  ),
            Consumer<SearchProvider>(
              builder: (BuildContext context, value, Widget? child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(11, 15, 11, 10),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: width * 0.08),
                          Text(
                            'Search Location',
                            style: TextStyle(
                                fontSize: width * 0.048,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.map,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(11, 16, 11, 10),
                      child: TextField(
                        controller: controller,
                        cursorColor: Colors.white70,
                        style: const TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.none),
                        onChanged: (value) {
                          if (value != '') {
                            searchProviderFalse.searchLocation(value);
                          } else {
                            searchProviderFalse.showWholeList();
                          }
                        },
                        decoration: InputDecoration(
                            suffixIcon: const Icon(
                              Icons.my_location_outlined,
                              color: Colors.white,
                            ),
                            hintStyle: const TextStyle(color: Colors.white70),
                            hintText: 'City Name',
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.white70,
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(8)),
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.4)),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    (isShow)
                        ? FutureBuilder(
                            future: searchProviderFalse
                                .fromMap(searchProviderTrue.search),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                HomeModel? hm = snapshot.data;
                                print('Success');
                                return ListTile(
                                  onTap: () {
                                    homeProviderFalse.searchLocation(hm.location.name);
                                    // homeProviderFalse.updateDrawerPageColor(
                                    //     hm.current.isDay);
                                    Navigator.of(context).pop();
                                  },
                                  title: Text(
                                    hm!.location.name,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    '${hm.location.region}/${hm.location.country}',
                                    style:
                                        const TextStyle(color: Colors.white70),
                                  ),
                                  leading: const Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                  ),
                                  trailing: Text(
                                    '${hm.current.tempC.round().toString()}°',
                                    style: TextStyle(
                                        fontSize: width * 0.042,
                                        color: Colors.white),
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return Padding(
                                  padding: EdgeInsets.only(top: height * 0.28),
                                  child: Center(
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      'No Result Found !',
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: width * 0.04),
                                    ),
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: EdgeInsets.only(top: height * 0.28),
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white70,
                                    ),
                                  ),
                                );
                              }
                            },
                          )
                        : Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12),
                                    child: Text(
                                      'Popular Location',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: width * 0.042),
                                    ),
                                  ),
                                  FutureBuilder(
                                    future:
                                        searchProviderFalse.fromMap(homeProviderTrue.search),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        HomeModel? hm = snapshot.data;
                                        // for(int i=0; i<cities.length; i++){
                                        //   searchProviderFalse
                                        //       .searchLocation(cities[i]['city']);
                                        //   storeList.add(hm);
                                        // }
                                        // print(storeList.length);
                                        print('Success');
                                        return Column(
                                            children: List.generate(
                                                cities.length, (index) {
                                          return ListTile(
                                            onTap: () {
                                              homeProviderFalse.searchLocation(cities[index]['city']);
                                              print(hm!.location.name);
                                              // homeProviderFalse.updateDrawerPageColor(hm!.current.isDay);
                                              // print(hm!.current.isDay);
                                              Navigator.of(context).pop();
                                            },
                                            title: Text(
                                              cities[index]['city'],
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            subtitle: Text(
                                              '${cities[index]['state']}/${cities[index]['country']}',
                                              style: const TextStyle(
                                                  color: Colors.white70),
                                            ),
                                            leading: const Icon(
                                              Icons.location_on,
                                              color: Colors.white,
                                            ),
                                            // trailing: Text(
                                            //   '${storeList[index].current.tempC.round().toString()}°',
                                            //   style: TextStyle(
                                            //       fontSize: width * 0.042),
                                            // ),
                                          );
                                        }));
                                      } else if (snapshot.hasError) {
                                        return Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(
                                            textAlign: TextAlign.center,
                                            'No Result Found!',
                                            style: TextStyle(
                                                fontSize: width * 0.042),
                                          ),
                                        );
                                      } else {
                                        return const Center(
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 100),
                                            child: CircularProgressIndicator(
                                              color: Colors.white70,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

List tempreture = [];
List storeList = [];
List cities = [
  {"city": "New York", "state": "New York", "country": "USA"},
  {"city": "Los Angeles", "state": "California", "country": "USA"},
  {"city": "Bangalore", "state": "Karnataka", "country": "India"},
  {"city": "Hyderabad", "state": "Telangana", "country": "India"},
  {"city": "New Delhi", "state": "Delhi", "country": "India"},
  {"city": "Toronto", "state": "Ontario", "country": "Canada"},
  {"city": "Vancouver", "state": "British Columbia", "country": "Canada"},
  {"city": "Sydney", "state": "New South Wales", "country": "Australia"},
  {"city": "Melbourne", "state": "Victoria", "country": "Australia"},
  {"city": "Lyon", "state": "Auvergne-Rhône-Alpes", "country": "France"},
  {"city": "Toulouse", "state": "Occitanie", "country": "France"},
  {"city": "Nice", "state": "Provence-Alpes-Côte d'Azur", "country": "France"},
  {"city": "Tokyo", "state": "Tokyo", "country": "Japan"},
  {"city": "Chennai", "state": "Tamil Nadu", "country": "India"},
  {"city": "Chicago", "state": "Illinois", "country": "USA"},
  {"city": "Houston", "state": "Texas", "country": "USA"},
  {"city": "Montreal", "state": "Quebec", "country": "Canada"},
  {"city": "Calgary", "state": "Alberta", "country": "Canada"},
  {"city": "Ottawa", "state": "Ontario", "country": "Canada"},
  {"city": "Phoenix", "state": "Arizona", "country": "USA"},
  {"city": "London", "state": "England", "country": "UK"},
  {"city": "Manchester", "state": "England", "country": "UK"},
  {"city": "Brisbane", "state": "Queensland", "country": "Australia"},
  {"city": "Perth", "state": "Western Australia", "country": "Australia"},
  {"city": "Adelaide", "state": "South Australia", "country": "Australia"},
  {"city": "Birmingham", "state": "England", "country": "UK"},
  {"city": "Glasgow", "state": "Scotland", "country": "UK"},
  {"city": "Edinburgh", "state": "Scotland", "country": "UK"},
  {"city": "Mumbai", "state": "Maharashtra", "country": "India"},
  {"city": "Osaka", "state": "Osaka", "country": "Japan"},
  {"city": "Nagoya", "state": "Aichi", "country": "Japan"},
  {"city": "Cologne", "state": "North Rhine-Westphalia", "country": "Germany"},
  {"city": "Shanghai", "state": "Shanghai", "country": "China"},
  {"city": "Beijing", "state": "Beijing", "country": "China"},
  {"city": "Chengdu", "state": "Sichuan", "country": "China"},
  {"city": "Moscow", "state": "Moscow", "country": "Russia"},
  {
    "city": "Saint Petersburg",
    "state": "Saint Petersburg",
    "country": "Russia"
  },
  {"city": "Novosibirsk", "state": "Novosibirsk", "country": "Russia"},
  {"city": "Paris", "state": "Île-de-France", "country": "France"},
  {
    "city": "Marseille",
    "state": "Provence-Alpes-Côte d'Azur",
    "country": "France"
  },
  {"city": "Sapporo", "state": "Hokkaido", "country": "Japan"},
  {"city": "Fukuoka", "state": "Fukuoka", "country": "Japan"},
  {"city": "Yekaterinburg", "state": "Sverdlovsk", "country": "Russia"},
  {"city": "Nizhny Novgorod", "state": "Nizhny Novgorod", "country": "Russia"},
  {"city": "Berlin", "state": "Berlin", "country": "Germany"},
  {"city": "Munich", "state": "Bavaria", "country": "Germany"},
  {"city": "Shenzhen", "state": "Guangdong", "country": "China"},
  {"city": "Guangzhou", "state": "Guangdong", "country": "China"},
  {"city": "Frankfurt", "state": "Hesse", "country": "Germany"},
  {"city": "Hamburg", "state": "Hamburg", "country": "Germany"},
];
