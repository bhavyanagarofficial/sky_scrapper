import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_scrapper/Screen/Modal/homeModel.dart';

import '../Provider/savedLocationProvider.dart';

class SavedLocation extends StatelessWidget {
  HomeModel hm;

  SavedLocation({super.key, required this.hm});

  @override
  Widget build(BuildContext context) {
    SavedLocationProvider savedLocationProviderFalse =
        Provider.of<SavedLocationProvider>(context, listen: false);
    SavedLocationProvider savedLocationProviderTrue =
        Provider.of<SavedLocationProvider>(context, listen: false);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 75,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text('Saved Location'),
          actions: [
            IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
            IconButton(icon: const Icon(Icons.add), onPressed: () {})
          ],
        ),
        body: Consumer<SavedLocationProvider>(
          builder: (BuildContext context, SavedLocationProvider value,
              Widget? child) {
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount:
                        savedLocationProviderTrue.savedWeatherList.length,
                    itemBuilder: (context, index) {
                      final name = savedLocationProviderTrue
                          .savedWeatherList[index]
                          .split('_')
                          .sublist(0, 1)
                          .join(' ');
                      final region = savedLocationProviderTrue
                          .savedWeatherList[index]
                          .split('_')
                          .sublist(1, 2)
                          .join(' ');
                      final country = savedLocationProviderTrue
                          .savedWeatherList[index]
                          .split('_')
                          .sublist(2, 3)
                          .join(' ');
                      final status = savedLocationProviderTrue
                          .savedWeatherList[index]
                          .split('_')
                          .sublist(3, 4)
                          .join(' ');
                      final temp = savedLocationProviderTrue
                          .savedWeatherList[index]
                          .split('_')
                          .sublist(4, 5)
                          .join(' ');
                      final isDay = savedLocationProviderTrue
                          .savedWeatherList[index]
                          .split('_')
                          .sublist(5, 6)
                          .join(' ');
                      final mintemp_c = savedLocationProviderTrue
                          .savedWeatherList[index]
                          .split('_')
                          .sublist(6, 7)
                          .join(' ');
                      final maxtemp_c = savedLocationProviderTrue
                          .savedWeatherList[index]
                          .split('_')
                          .sublist(7, 8)
                          .join(' ');
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              height: height * 0.128,
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: width * 0.02),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: (isDay == '1')
                                          ? [
                                              const Color(0xff0d5cc5),
                                              const Color(0xff439cf3),
                                            ]
                                          : [
                                              const Color(0xff19043D),
                                              const Color(0xff341152),
                                            ])),
                              child: ListTile(
                                title: Row(
                                  children: [
                                    Container(
                                      child: Text(
                                        name,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: width * 0.05,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Text(
                                      ' ($mintemp_c ~ $maxtemp_c °C)',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                subtitle: Text(
                                  '$status ',
                                  style: const TextStyle(color: Colors.white70),
                                ),
                                trailing: Text(
                                  '$temp °C',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: width * 0.055),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                savedLocationProviderFalse
                                    .removeFromSaved(index);
                              },
                              child: const Icon(
                                Icons.delete,
                                color: Colors.black54,
                              ))
                        ],
                      );
                    }));
          },
        ),
      ),
    );
  }
}
