import 'package:flutter/material.dart';
import 'package:pintrest_ui/provider/walpepper_provider.dart';
import 'package:pintrest_ui/screens/HomeScreen.dart';
import 'package:pintrest_ui/utils/constant.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.width;

    return Consumer<WalpepperProvider>(
      builder: (context, WalpepperProvider, child) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: h * .01,
          ),
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              IndexedStack(
                index: WalpepperProvider.currentindex,
                children: const [
                  HomeScreenPintrest(),
                  Searchscreen(),
                  NotificationScreen(),
                  PRofilecreen(),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: h * .180,
                  margin: EdgeInsets.symmetric(
                      horizontal: w * .06, vertical: w * .1),
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade100),
                  ),
                  child: ClipRRect(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: w * .01,
                        ),
                        GestureDetector(
                          onTap: () {
                            WalpepperProvider.updateindex(0);
                          },
                          child: Container(
                            width: w * .10,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              WalpepperProvider.updateindex(1);
                            },
                            child: Icon(Icons.search)),
                        GestureDetector(
                          onTap: () {
                            WalpepperProvider.updateindex(2);
                          },
                          child: Icon(Icons.notifications),
                        ),
                        GestureDetector(
                            onTap: () {
                              WalpepperProvider.updateindex(3);
                            },
                            child: Icon(Icons.person)),
                        SizedBox(
                          width: w * .01,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
