import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pintrest_ui/api/pinterest_api.dart';

import 'package:pintrest_ui/provider/walpepper_provider.dart';

import 'package:pintrest_ui/utils/constant.dart';
import 'package:pintrest_ui/widgets/appText.dart';
import 'package:provider/provider.dart';

class HomeScreenPintrest extends StatefulWidget {
  const HomeScreenPintrest({super.key});

  @override
  State<HomeScreenPintrest> createState() => _HomeScreenPintrestState();
}

class _HomeScreenPintrestState extends State<HomeScreenPintrest> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.width;

    final walpepperProvider =
        Provider.of<WalpepperProvider>(context, listen: false);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: w * .020,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              Row(
                children: [
                  Container(
                    width: w * .150,
                    height: h * .200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Container(
                      width: w * .140,
                      height: h * .190,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: w * .050,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: w * .250,
                    height: h * .150,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(w * .05),
                    ),
                    child: Text(
                      'Follow',
                      style: TextStyle(
                        fontSize: w * .050,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: h * .050,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () => walpepperProvider.selected(0),
              child: Container(
                width: w * .30,
                height: h * .150,
                decoration: BoxDecoration(
                  color: walpepperProvider.selectedTopic == 0
                      ? Colors.black
                      : Colors.black,
                  borderRadius: BorderRadius.circular(w * .05),
                ),
                alignment: Alignment.center,
                child: AppText(
                  text: 'Activity',
                  color: Colors.white,
                  weight: FontWeight.bold,
                  size: w * .05,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => walpepperProvider.selected(1),
              child: Container(
                width: w * .30,
                height: h * .150,
                decoration: BoxDecoration(
                  color: walpepperProvider.selectedTopic == 1
                      ? Colors.black
                      : Colors.black,
                  borderRadius: BorderRadius.circular(w * .05),
                ),
                alignment: Alignment.center,
                child: AppText(
                  text: 'Community',
                  color: Colors.white,
                  weight: FontWeight.bold,
                  size: w * .05,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => walpepperProvider.selected(2),
              child: Container(
                width: w * .30,
                height: h * .150,
                decoration: BoxDecoration(
                  color: walpepperProvider.selectedTopic == 2
                      ? Colors.blue
                      : white,
                  borderRadius: BorderRadius.circular(w * .05),
                ),
                alignment: Alignment.center,
                child: AppText(
                  text: 'Shop',
                  color: Colors.black,
                  weight: FontWeight.bold,
                  size: w * .05,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: h * .05,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(w * .10),
                topRight: Radius.circular(w * .10),
              ),
            ),
            child: Column(children: [
              SizedBox(
                height: h * .02,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                AppText(
                  text: 'All product',
                  weight: FontWeight.bold,
                  size: w * .05,
                ),
              ]),
              FutureBuilder(
                future: ApiService().fetchData(),
                builder: (context, snapshot) {
                  log(snapshot.data.toString());
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.custom(
                            padding: EdgeInsets.symmetric(vertical: w * .05),
                            gridDelegate: SliverStairedGridDelegate(
                                crossAxisSpacing: 10,
                                tileBottomSpace: 20,
                                mainAxisSpacing: 10,
                                pattern: [
                                  const StairedGridTile(0.5, 1),
                                  const StairedGridTile(0.5, 1),
                                ]),
                            childrenDelegate: SliverChildBuilderDelegate(
                              childCount: snapshot.data!.length,
                              (context, index) => Container(
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(w * .02),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              snapshot.data![index]['urls']
                                                      ['raw'] ??
                                                  '',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                          // color: Colors.red,
                                          ),
                                      child: Column(
                                        children: [
                                          Text(Tittile[index]),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(subTittile[index]),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ),
                    );
                  }
                },
              )
            ]),
          ),
        ),
      ],
    );
  }
}
