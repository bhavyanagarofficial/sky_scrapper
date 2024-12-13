import 'package:flutter/material.dart';
import 'package:sky_scrapper/Screen/Modal/homeModel.dart';
import 'package:sky_scrapper/Screen/Provider/homeProvider.dart';
import 'package:provider/provider.dart';
import 'package:sky_scrapper/Screen/View/savedLocation.dart';
import 'package:sky_scrapper/Screen/View/searchLocation.dart';

import '../Provider/savedLocationProvider.dart';

bool changeTemp = false;
int isNightOrDay = 0;
HomeModel? hm;
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProviderFalse =
        Provider.of<HomeProvider>(context, listen: false);
    HomeProvider homeProviderTrue =
        Provider.of<HomeProvider>(context, listen: true);
    SavedLocationProvider savedLocationProviderFalse =
        Provider.of<SavedLocationProvider>(context, listen: false);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    int currentHour = DateTime.now().hour;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors:  [
                      Color(0xff0d5cc5),
                      Color(0xff439cf3),
                    ]),
              ),
            ),
            // Container(
            //   decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //         begin: Alignment.topCenter,
            //         end: Alignment.bottomCenter,
            //         colors: (isNightOrDay == 1)
            //             ? [
            //           const Color(0xff0d5cc5),
            //           const Color(0xff439cf3),
            //         ]
            //             : [
            //           const Color(0xff19043D),
            //           const Color(0xff341152),
            //         ]),
            //   ),
            // ),
            FutureBuilder(
              future: homeProviderFalse.fromMap(homeProviderFalse.search),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  hm = snapshot.data;
                  // homeProviderFalse.updateDrawerPageColor(hm!.current.isDay);
                  isNightOrDay = hm!.current.isDay;
                  print('Success');
                  return Stack(
                    children: [
                      (hm!.current.isDay == 1)
                          ? day(width, height)
                          : night(width, height),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(11, 15, 11, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //todo -------------------------------> Appbar
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // homeProviderFalse.updateDrawerPageColor(hm!.current.isDay);
                                    // print('------------------>${isNightOrDay}');
                                    _scaffoldKey.currentState!.openDrawer();
                                  },
                                  child: const Icon(
                                    Icons.menu,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.035,
                                ),
                                Text(
                                  hm!.location.name.toString(),
                                  style: TextStyle(
                                      fontSize: width * 0.048,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    controller = TextEditingController();
                                    isShow = false;
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          SearchLocation(hm: hm!),
                                    ));
                                  },
                                  child: const Icon(
                                      Icons.add_location_alt_outlined,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(height: height * 0.02),
                            //todo -------------------------------> F to C
                            Expanded(
                              child: Container(
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 35,
                                        width: 65, //width * 0.175
                                        padding: const EdgeInsets.all(2.5),
                                        decoration: BoxDecoration(
                                            color: Colors.black26,
                                            borderRadius:
                                            BorderRadius.circular(5)),
                                        child: GestureDetector(
                                          onTap: () {
                                            homeProviderFalse.changeTemperature();
                                          },
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                        color: (changeTemp)
                                                            ? Colors.white
                                                            : null),
                                                    child: Text(
                                                      'F',
                                                      style: TextStyle(
                                                          color: (changeTemp)
                                                              ? Colors.teal
                                                              : Colors.white),
                                                    ),
                                                  )),
                                              Expanded(
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                        color: (!changeTemp)
                                                            ? Colors.white
                                                            : null),
                                                    child: Text(
                                                      'C',
                                                      style: TextStyle(
                                                          color: (changeTemp)
                                                              ? Colors.white
                                                              : Colors.teal),
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: height * 0.3),
                                      //todo -------------------------------> Text
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${(changeTemp) ? hm!.current.tempF.round() : hm!.current.tempC.round()}°'
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: width * 0.2,
                                                color: Colors.white),
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(
                                                    width * 0.026),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        5),
                                                    color: Colors.white54
                                                        .withOpacity(0.2)),
                                                child: const Icon(
                                                  Icons.sunny,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  savedLocationProviderFalse
                                                      .addToSavedLocation(
                                                    hm!.location.name,
                                                    hm!.location.region,
                                                    hm!.location.country,
                                                    hm!.current.condition.text,
                                                    hm!.current.tempC.round(),
                                                    hm!.current.isDay,
                                                    hm!
                                                        .forecastModel
                                                        .forecastDay
                                                        .first
                                                        .day
                                                        .maxtemp_c
                                                        .round(),
                                                    hm!
                                                        .forecastModel
                                                        .forecastDay
                                                        .first
                                                        .day
                                                        .mintemp_c
                                                        .round(),
                                                  );
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(
                                                      width * 0.026),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5),
                                                      color: Colors.white54
                                                          .withOpacity(0.2)),
                                                  child: const Icon(
                                                    Icons.bookmark_border,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '${hm!.current.condition.text}'
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: width * 0.055,
                                            color: Colors.amber),
                                      ),
                                      //todo---------------------------> Hourly
                                      SizedBox(
                                        height: height * 0.048,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Hourly',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: width * 0.045),
                                          ),
                                          Text(
                                            '72 Hours >',
                                            style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: width * 0.038),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                            children: List.generate(
                                                hm!
                                                    .forecastModel
                                                    .forecastDay
                                                    .first
                                                    .hour
                                                    .length, (index) {
                                              final hour = hm!.forecastModel
                                                  .forecastDay.first.hour[index];
                                              return Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: width * 0.025,
                                                    vertical: width * 0.03),
                                                decoration: BoxDecoration(
                                                    border: (index == 0)
                                                        ? const Border(
                                                      top: BorderSide(
                                                          width: 1,
                                                          color:
                                                          Colors.white12),
                                                      bottom: BorderSide(
                                                          width: 1,
                                                          color:
                                                          Colors.white12),
                                                      right: BorderSide(
                                                          width: 1,
                                                          color:
                                                          Colors.white12),
                                                    )
                                                        : const Border(
                                                      top: BorderSide(
                                                          width: 1,
                                                          color:
                                                          Colors.white12),
                                                      bottom: BorderSide(
                                                          width: 1,
                                                          color:
                                                          Colors.white12),
                                                      left: BorderSide(
                                                          width: 1,
                                                          color:
                                                          Colors.white12),
                                                    )),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      '${hour.time.split(" ").sublist(1, 2).join(" ")} ',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: width * 0.034,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 9),
                                                    Align(
                                                        alignment:
                                                        Alignment.centerRight,
                                                        child: Text(
                                                          '${hour.chance_of_rain}%'
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize:
                                                              width * 0.032,
                                                              color: Colors.amber),
                                                        )),
                                                    Image.network(
                                                        'https:${hour.hourConditionModal.icon}'),
                                                    const SizedBox(height: 14),
                                                    Text(
                                                      '${hour.temp_c.round()}°',
                                                      style: TextStyle(
                                                          fontSize: width * 0.034,
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              );
                                            })),
                                      ),
                                      //todo---------------------------> Current Condition
                                      SizedBox(
                                        height: height * 0.048,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Current Conditions',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: width * 0.045),
                                          ),
                                          Text(
                                            'More >',
                                            style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: width * 0.038),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      const Divider(
                                          thickness: 1.5,
                                          color: Colors.white12),
                                      SizedBox(height: height * 0.014),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.04,
                                            vertical: height * 0.016),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.thermostat_auto,
                                                      size: width * 0.086,
                                                      color: Colors.white70,
                                                    ),
                                                    const SizedBox(
                                                      width: 17,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Text(
                                                          'Feels like',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white70,
                                                              fontSize: width *
                                                                  0.0368),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          '${hm!.forecastModel.forecastDay.first.hour[currentHour].feelslike_c.round()}°',
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500,
                                                              color:
                                                              Colors.white,
                                                              fontSize: width *
                                                                  0.042),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: height * 0.04),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.air_outlined,
                                                      size: width * 0.086,
                                                      color: Colors.white70,
                                                    ),
                                                    const SizedBox(
                                                      width: 17,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Text(
                                                          'Wind Speed',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white70,
                                                              fontSize: width *
                                                                  0.0368),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          '${hm!.forecastModel.forecastDay.first.hour[currentHour].wind_kph.round()} km/h',
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500,
                                                              color:
                                                              Colors.white,
                                                              fontSize: width *
                                                                  0.042),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: height * 0.04),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.visibility_outlined,
                                                      size: width * 0.086,
                                                      color: Colors.white70,
                                                    ),
                                                    const SizedBox(
                                                      width: 17,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Text(
                                                          'Visibility',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white70,
                                                              fontSize: width *
                                                                  0.0368),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          '${hm!.forecastModel.forecastDay.first.hour[currentHour].feelslike_c} miles',
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500,
                                                              color:
                                                              Colors.white,
                                                              fontSize: width *
                                                                  0.042),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.water,
                                                      size: width * 0.086,
                                                      color: Colors.white70,
                                                    ),
                                                    const SizedBox(
                                                      width: 17,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Text(
                                                          'Precipitation',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white70,
                                                              fontSize: width *
                                                                  0.0368),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          '${hm!.forecastModel.forecastDay.first.hour[currentHour].precip_mm}°',
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                              color:
                                                              Colors.white,
                                                              fontSize: width *
                                                                  0.039),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: height * 0.04),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.water_drop_outlined,
                                                      size: width * 0.086,
                                                      color: Colors.white70,
                                                    ),
                                                    const SizedBox(
                                                      width: 17,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Text(
                                                          'Humidity',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white70,
                                                              fontSize: width *
                                                                  0.0368),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          '${hm!.forecastModel.forecastDay.first.hour[currentHour].humidity}%',
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                              color:
                                                              Colors.white,
                                                              fontSize: width *
                                                                  0.039),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: height * 0.04),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.dew_point,
                                                      size: width * 0.086,
                                                      color: Colors.white70,
                                                    ),
                                                    const SizedBox(
                                                      width: 17,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Text(
                                                          'Dew Point',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white70,
                                                              fontSize: width *
                                                                  0.0368),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          '${hm!.forecastModel.forecastDay.first.hour[currentHour].dewpoint_c.round()}°',
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                              color:
                                                              Colors.white,
                                                              fontSize: width *
                                                                  0.039),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      //todo---------------------------> SunRise And SunSet
                                      SizedBox(
                                        height: height * 0.048,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Sunrise And Sunset',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: width * 0.045),
                                          ),
                                          Text(
                                            'More >',
                                            style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: width * 0.038),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      const Divider(
                                          thickness: 1.5,
                                          color: Colors.white12),
                                      SizedBox(height: height * 0.014),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.04,
                                            vertical: height * 0.015),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Sunrise',
                                                  style: TextStyle(
                                                      color: Colors.white70,
                                                      fontSize: width * 0.0368),
                                                ),
                                                Text(
                                                  '${hm!.forecastModel.forecastDay.first.astro.sunrise}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize: width * 0.039),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Sunset',
                                                  style: TextStyle(
                                                      color: Colors.white70,
                                                      fontSize: width * 0.0368),
                                                ),
                                                Text(
                                                  '${hm!.forecastModel.forecastDay.first.astro.sunset}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize: width * 0.039),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                          thickness: 1.5,
                                          color: Colors.white12),
                                      //todo---------------------------> MoonRise And MoonSet
                                      SizedBox(
                                        height: height * 0.048,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Moonrise And Moonset',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: width * 0.045),
                                          ),
                                          Text(
                                            'More >',
                                            style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: width * 0.038),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      const Divider(
                                          thickness: 1.5,
                                          color: Colors.white12),
                                      SizedBox(height: height * 0.014),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.04,
                                            vertical: height * 0.016),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'MoonRise',
                                                  style: TextStyle(
                                                      color: Colors.white70,
                                                      fontSize: width * 0.0368),
                                                ),
                                                Text(
                                                  '${hm!.forecastModel.forecastDay.first.astro.moonrise}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize: width * 0.039),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'MoonSet',
                                                  style: TextStyle(
                                                      color: Colors.white70,
                                                      fontSize: width * 0.0368),
                                                ),
                                                Text(
                                                  '${hm!.forecastModel.forecastDay.first.astro.moonset}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize: width * 0.039),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                          thickness: 1.5,
                                          color: Colors.white12),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                }
                else if (snapshot.hasError) {
                  return Center(child: Padding(
                    padding: const EdgeInsets.all(9),
                    child: Text(snapshot.error.toString(),style:const TextStyle(color:Colors.white)),
                  ));
                }
                else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white70,
                    ),
                  );
                }
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors:  [
                        Color(0xff0d5cc5),
                        Color(0xff439cf3),
                      ]),
                ),
              ),
              // Container(
              //   decoration: BoxDecoration(
              //     gradient: LinearGradient(
              //       begin: Alignment.topCenter,
              //       end: Alignment.bottomCenter,
              //       colors: (isNightOrDay == 1)
              //           ? [
              //         const Color(0xff0659c6),
              //         const Color(0xff4389f3),
              //       ]
              //           : [
              //         const Color(0xff19043D),
              //         const Color(0xff290c41),
              //       ],
              //     ),
              //   ),
              // ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 65,
                      child: Stack(
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 18),
                                child: Text(
                                  'Weather',
                                  style: TextStyle(
                                      fontSize: width * 0.04,
                                      color: Colors.white),
                                ),
                              )),
                          Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.settings,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )),
                        ],
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: buildListTile(Icons.home, 'Home')),
                    GestureDetector(
                        onTap: () {
                          controller = TextEditingController();
                          isShow = false;
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                            builder: (context) =>
                                SearchLocation(hm: hm!),
                          ));
                        },
                        child: buildListTile(
                            Icons.location_on, 'Location Management')),
                    buildListTileWithSwitch(
                        Icons.notifications,
                        'Notification Bar',
                        homeProviderFalse,
                        homeProviderTrue),
                    buildListTileWithSwitch(Icons.calendar_month_outlined,
                        'Daily Weather', homeProviderFalse, homeProviderTrue),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SavedLocation(hm: hm!),
                              ));
                        },
                        child: buildListTile(Icons.favorite, 'Favorites')),
                    buildListTile(Icons.dashboard_customize, 'Custom'),
                    buildListTile(Icons.widgets, 'Widgets'),
                    buildListTile(Icons.share, 'Share'),
                    buildListTile(Icons.app_registration, 'Our Apps'),
                    buildListTile(Icons.private_connectivity, 'Privacy Policy')
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListTileWithSwitch(
      var icon, String text, var homeProviderFalse, var homeProviderTrue) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            icon,
            color: Colors.white,
          ),
          title: Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          trailing: Switch(
            value: homeProviderTrue.isOn,
            onChanged: (value) {
              homeProviderFalse.switchOnOff(value);
            },
          ),
        ),
        const Divider(
          color: Colors.white54,
          indent: 16,
          endIndent: 16,
        ),
      ],
    );
  }
}

Widget buildListTile(var icon, String text) {
  return Column(
    children: [
      ListTile(
        leading: Icon(
          icon,
          color: Colors.white,
        ),
        title: Text(
          text,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      const Divider(
        color: Colors.white54,
        indent: 16,
        endIndent: 16,
      ),
    ],
  );
}

Stack day(double width, double height) {
  return Stack(
    children: [
      Container(
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
      ),
      Positioned(
        right: width * -0.38,
        top: height * -0.185,
        child: Container(
          height: width * 1.04,
          width: width * 1.04,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xffF8ED6F).withOpacity(0.24)),
          child: Container(
            height: width * 0.75,
            width: width * 0.75,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xffF8ED6F).withOpacity(0.64)),
            child: Container(
                height: width * 0.45,
                width: width * 0.45,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xffF8ED6F))),
          ),
        ),
      ),
    ],
  );
}

Stack night(double width, double height) {
  return Stack(
    children: [
      Container(
        height: height,
        width: width,
        padding: const EdgeInsets.only(top: 10),
        alignment: Alignment.topCenter,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff19043D),
              Color(0xff290c41),
            ],
          ),
        ),
        child: Image.asset(
          'assets/images/star.png',
        ),
      ),
      Positioned(
        top: height * -0.11,
        right: width * -0.175,
        child: Container(
          height: width * 0.72,
          width: width * 0.72,
          alignment: Alignment.topRight,
          decoration: const BoxDecoration(
              color: Colors.white70, shape: BoxShape.circle),
        ),
      ),
      Positioned(
        top: height * -0.194,
        right: width * -0.304,
        child: Container(
          height: width * 0.8,
          width: width * 0.8,
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
              color: Color(0xff19043D),
              blurRadius: 30,
            )
          ], shape: BoxShape.circle),
        ),
      ),
    ],
  );
}
