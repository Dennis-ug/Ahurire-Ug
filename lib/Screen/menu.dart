import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';

// import 'package:google_fonts/google_fonts.dart';

import 'package:nabiituapp/testdata/testdata.dart';

import 'ListViewCust.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Yesu Ahuriire Community",
        ),
        elevation: 0,
      ),
      body: MenuLayout(),
      drawer: Drawer(),
    );
  }
}

class MenuLayout extends StatefulWidget {
  const MenuLayout({Key? key}) : super(key: key);

  @override
  _MenuLayoutState createState() => _MenuLayoutState();
}

class _MenuLayoutState extends State<MenuLayout> {
  late CarouselSliderController _sliderController;

  @override
  void initState() {
    super.initState();
    _sliderController = CarouselSliderController();
  }

  @override
  Widget build(BuildContext context) {
    double sqr = 0.2507589285714286;
    double hyt = MediaQuery.of(context).size.height;
    double wyd = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Container(
          child: Column(
            children: [
              SizedBox(
                height: hyt * 0.0323660714285714,
              ),
              Container(
                height: hyt * 0.3388392857142857,
                child: CarouselSlider.builder(
                  unlimitedMode: true,
                  controller: _sliderController,
                  slideBuilder: (index) {
                    return Container(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data[index]["title"],
                              // style: GoogleFonts.poppins(
                              //     color: Colors.black,
                              //     fontSize: hyt * 0.025,
                              //     fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: hyt * 0.0223214285714286,
                            ),
                            Text(
                              data[index]["body"],
                              // style: GoogleFonts.poppins(
                              //     color: Colors.black,
                              //     fontSize: hyt * 0.0195,
                              //     fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: hyt * 0.0580357142857143,
                            ),
                            data[index]["pleg"] == "true"
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          print(hyt);
                                          print(wyd);
                                        },
                                        child: Container(
                                          width: wyd * 0.3816425120772947,
                                          height: hyt * 0.0558035714285,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color:
                                                Color.fromRGBO(255, 168, 0, 1),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Donate",
                                              // style: GoogleFonts.poppins(
                                              //     color: Colors.white,
                                              //     fontSize: hyt * 0.025,
                                              //     fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: wyd * 0.3816425120772947,
                                        height: hyt * 0.0558035714285,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          //color: Color.fromRGBO(0, 0, 0, 1),
                                          border: Border.all(
                                              width: 1,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Pay Pledge",
                                            // style: GoogleFonts.poppins(
                                            //     color: Theme.of(context)
                                            //         .primaryColor,
                                            //     fontSize: hyt * 0.025,
                                            //     fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                : Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        print(hyt);
                                        print(wyd);
                                      },
                                      child: Container(
                                        width: wyd * 0.3816425120772947,
                                        height: hyt * 0.0558035714285,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Color.fromRGBO(255, 168, 0, 1),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Donate",
                                            // style: GoogleFonts.poppins(
                                            //     color: Colors.white,
                                            //     fontSize: hyt * 0.025,
                                            //     fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                          ],
                        ),
                      ),
                    );
                  },
                  slideTransform: DefaultTransform(),
                  slideIndicator: CircularSlideIndicator(
                    padding: EdgeInsets.only(bottom: 0),
                    indicatorBorderColor: Colors.transparent,
                  ),
                  itemCount: data.length,
                  initialPage: 0,
                  enableAutoSlider: true,
                ),
              ),
              SizedBox(
                height: hyt * 0.0603571428571429,
              ),
              //Green card
              Expanded(
                child: Container(
                  //height: hyt * 0.4386160714285714,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: hyt * 0.0288214285714286,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ///card 1
                              GestureDetector(
                                onTap: () async {
                                  if (await ConnectivityWrapper
                                      .instance.isConnected) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ListsViewCustom(
                                          "Events",
                                        ),
                                      ),
                                    );
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        title: Text("WARNING"),
                                        content: Text(
                                            "The device has no internet connection.\n Please contact your internet service provider"),
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  height: wyd * sqr,
                                  width: wyd * sqr,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: (wyd * sqr) * 0.2,
                                      ),
                                      Center(
                                          child: Container(
                                        height: (wyd * sqr) / 2,
                                        width: (wyd * sqr) / 2,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        child: Center(
                                          child: FaIcon(
                                            FontAwesomeIcons.buffer,
                                            size: ((wyd * sqr) / 2) / 2,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )),
                                      Text(
                                        "Events",
                                        style: TextStyle(
                                          fontFamily: "Poppins-Regular",
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (await ConnectivityWrapper
                                      .instance.isConnected) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ListsViewCustom(
                                                "Fundraising",
                                              )),
                                    );
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        title: Text("WARNING"),
                                        content: Text(
                                            "The device has no internet connection.\n Please contact your internet service provider"),
                                      ),
                                    );
                                  }
                                  ;
                                },
                                child: Container(
                                  height: wyd * sqr,
                                  width: wyd * sqr,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: (wyd * sqr) * 0.2,
                                      ),
                                      Center(
                                          child: Container(
                                        height: (wyd * sqr) / 2,
                                        width: (wyd * sqr) / 2,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        child: Center(
                                          child: FaIcon(
                                            FontAwesomeIcons.donate,
                                            size: ((wyd * sqr) / 2) / 2,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )),
                                      AutoSizeText(
                                        "Fundraising",
                                        style: TextStyle(
                                          fontFamily: "Poppins-Regular",
                                          fontSize: 13.5,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              ///card 3
                              GestureDetector(
                                onTap: () async {
                                  if (await ConnectivityWrapper
                                      .instance.isConnected) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ListsViewCustom(
                                          "Ministries",
                                        ),
                                      ),
                                    );
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        title: Text("WARNING"),
                                        content: Text(
                                            "The device has no internet connection.\n Please contact your internet service provider"),
                                      ),
                                    );
                                  }
                                  ;
                                },
                                child: Container(
                                  height: wyd * sqr,
                                  width: wyd * sqr,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: (wyd * sqr) * 0.2,
                                      ),
                                      Center(
                                          child: Container(
                                        height: (wyd * sqr) / 2,
                                        width: (wyd * sqr) / 2,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        child: Center(
                                          child: FaIcon(
                                            FontAwesomeIcons.church,
                                            size: ((wyd * sqr) / 2) / 2,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )),
                                      Text(
                                        "Ministries",
                                        // style: GoogleFonts.poppins(
                                        //   color:
                                        //       Color.fromRGBO(115, 115, 115, 1),
                                        //   fontSize: (wyd * sqr) * 0.15,
                                        //   fontWeight: FontWeight.w600,
                                        // ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],

                            ///card 3
                          ),
                        ),
                        SizedBox(
                          height: hyt * 0.0179,
                        ),
                        Container(
                          height: (wyd * sqr) / 1.5,
                          width: wyd * 0.7898550724637681,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: (wyd * sqr) * 0.2,
                                ),
                                Center(
                                  child: Container(
                                    height: (wyd * sqr) / 2,
                                    width: (wyd * sqr) / 2,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    child: Center(
                                      child: FaIcon(
                                        FontAwesomeIcons.info,
                                        size: ((wyd * sqr) / 2) / 2,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(),
                                ),
                                Text(
                                  "About",
                                  // style: GoogleFonts.poppins(
                                  //   color: Color.fromRGBO(115, 115, 115, 1),
                                  //   fontSize: (wyd * sqr) * 0.15,
                                  //   fontWeight: FontWeight.w600,
                                  // ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: hyt * 0.05,
                width: wyd,
              ),
            ],
          ),
        ),

        //float card
        Positioned(
          top: hyt * 0.4084821428571429,
          left: wyd * 0.1038647342995169,
          child: Container(
            width: wyd * 0.789855072463768,
            height: hyt * 0.0491071428571429,
            decoration: BoxDecoration(
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey,
              //     offset: Offset.zero,
              //     blurRadius: 8,
              //   )
              // ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: Text(
                "Campaigns",
                style: TextStyle(
                  //   color: Color.fromRGBO(115, 115, 115, 1),
                  fontSize: hyt * 0.025,
                  //   fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
