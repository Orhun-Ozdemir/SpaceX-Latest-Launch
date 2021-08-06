import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:spacex_app/base/base_event.dart';
import 'package:spacex_app/base/base_state.dart';
import 'package:spacex_app/base/const/const.dart';
import 'package:spacex_app/views/homepage/model/homepage_model.dart';
import 'package:spacex_app/views/homepage/viewmodel/homepage_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextButton linkText(String url) {
    return TextButton(
      onPressed: () {
        launchURL(url);
      },
      child: Text(
        url,
        style: TextStyle(fontSize: 12),
      ),
    );
  }

  void launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : print("Bir sorun oluştu");

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return BlocProvider(
      create: (context) => SpaceXBloc(HomePageRepository()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.blueGrey.shade200,
          body: SafeArea(
            child: Container(
              child: BlocBuilder<SpaceXBloc, SpaceXState>(
                builder: (context, state) {
                  if (state is SpaceXInitial) {
                    BlocProvider.of<SpaceXBloc>(context)
                        .add(SpaceXFetchEvent());
                  }
                  if (state is SpaceXError) {
                    return Center(
                      child: Text('failed to fetch quote'),
                    );
                  }
                  if (state is SpaceXLoaded) {
                    List<String> resimler =
                        state.spaceX.links!.flickr!.original!;
                    String? image = state.spaceX.links!.patch!.large;
                    String? campaign = state.spaceX.links!.reddit!.campaign!;
                    String? launch = state.spaceX.links!.reddit!.launch!;
                    String? recovery = state.spaceX.links!.reddit!.recovery!;
                    List<Image> resim = [];
                    for (var item in resimler) {
                      resim.add(
                        Image.network(
                          item,
                          fit: BoxFit.contain,
                        ),
                      );
                    }

                    return SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          sizedBox(5),
                          Image.network(
                            image!,
                            width: deviceWidth * 4 / 10,
                            height: deviceWidth * 4 / 10,
                          ),
                          sizedBox(5),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            //height: MediaQuery.of(context).size.height * 6.6 / 10,
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.white,
                                        offset: Offset(-2, -2),
                                        spreadRadius: 3,
                                        blurRadius: 15),
                                    BoxShadow(
                                        offset: Offset(4, 4),
                                        color: Colors.black.withOpacity(0.4),
                                        blurRadius: 10,
                                        spreadRadius: 4)
                                  ],
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.blueGrey.shade600,
                                        Colors.blueGrey.shade300,
                                        Colors.blueGrey.shade200,
                                        Colors.blueGrey.shade50
                                      ])),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Name:  ${state.spaceX.name!}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "Date:  ${state.spaceX.dateUtc!.split("T")[0]}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  ImageSlideshow(
                                    width: deviceWidth,
                                    height: deviceHeight * 3.5 / 10,
                                    children: resim,
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "DETAİLS",
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade100,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            '${state.spaceX.details}',
                                            style: TextStyle(fontSize: 10.0),
                                          ),
                                          ExpansionTile(
                                            title: Text(
                                              "REDDİT",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            children: [
                                              linkText(campaign),
                                              linkText(launch),
                                              linkText(recovery),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          sizedBox(5)
                        ],
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox sizedBox(double height) {
    return SizedBox(
      height: height,
    );
  }
}
