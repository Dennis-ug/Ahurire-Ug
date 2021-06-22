import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nabiituapp/testdata/services.dart';

import 'eventsDetails.dart';
import 'fundDeatils.dart';
import 'hep.dart';
import 'ministriesDetails.dart';

class ListsViewCustom extends StatefulWidget {
  final String _cardName;

  ListsViewCustom(
    this._cardName,
  );

  @override
  _EventsState createState() => _EventsState(
        _cardName,
      );
}

class _EventsState extends State<ListsViewCustom> {
  final String _cardName;

  _EventsState(
    this._cardName,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _cardName == "Events"
                ? FaIcon(FontAwesomeIcons.buffer)
                : _cardName == "Fundraising"
                    ? FaIcon(FontAwesomeIcons.donate)
                    : _cardName == "Ministries"
                        ? FaIcon(FontAwesomeIcons.church)
                        : Container(),
            Text(
              "  $_cardName",
              style: TextStyle(fontFamily: "Poppins-Regular"),
            ),
            Expanded(child: SizedBox())
          ],
        ),
      ),
      body: EventsView(
        _cardName,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: ()  {
          Navigator.push(context, MaterialPageRoute(builder: (_)=>Help()));
        },
        //() {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => About()),
        //   );
        // },
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              FaIcon(FontAwesomeIcons.question),
              Text("Help"),
            ],
          ),
        ),
      ),
    );
  }
}

class EventsView extends StatefulWidget {
  final String _cardName;

  EventsView(
    this._cardName,
  );

  @override
  _EventsViewState createState() => _EventsViewState(
        _cardName,
      );
}

class _EventsViewState extends State<EventsView> {
  String out = "Loading....";

  final String _cardName;

  _EventsViewState(
    this._cardName,
  );

  bool _connectionStatus = false;
  late Connectivity connectivity;
  late StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    super.initState();
    connectivity = new Connectivity();
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||result == ConnectivityResult.wifi) {
        setState(() {
          _connectionStatus = true;
        });
      }else if(result == ConnectivityResult.none){
        setState(() {
          _connectionStatus = false;
        });
        setState(() {

        });
      }
      // else if(result == ConnectivityResult.none ) {
      //     showDialog(
      //       context: context,
      //       builder: (_) => AlertDialog(
      //         title: Text("WARNING"),
      //         content: Text(
      //             "The device has no internet connection.\n Please contact your internet service provider"),
      //       ),
      //     );
      //   }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    subscription.cancel();
  }

  // ignore: unused_element

  @override
  Widget build(BuildContext context) {
    double _hyt = MediaQuery.of(context).size.height;
    double _wyd = MediaQuery.of(context).size.height;

    return Container(
      height: _hyt,
      width: _wyd,
      child: Column(
        children: [
          Column(
            children: [
              SizedBox(
                height: (_hyt * 0.0446428571428571),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Container(
                  height: _hyt * 0.8,
                  child: !_connectionStatus
                      ? Container(
                          child: Center(
                            child: Text("No internet connection"),
                          ),
                        )
                      : FutureBuilder(
                          future: _cardName == "Events"
                              ? Services.getEvent()
                              : _cardName == "Fundraising"
                                  ? Services.getfund()
                                  : _cardName == "Ministries"
                                      ? Services.getMinistries()
                                      : null,
                          builder: (_, AsyncSnapshot snapshot) {
                            if (snapshot.data == null) {
                              return Center(
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  child: CircularProgressIndicator(
                                    color: Theme.of(context).primaryColor,
                                  ), //Text("Loading....."),
                                ),
                              );
                            } else {
                              return ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (_, int index) {
                                    return ListTile(
                                      onTap: () async {
                                        if (_connectionStatus) {
                                          _cardName == "Events"
                                              ? Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailsPage(snapshot
                                                            .data[index]),
                                                  ),
                                                )
                                              : _cardName == "Fundraising"
                                                  ? Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            FundDetails(snapshot
                                                                .data[index]),
                                                      ),
                                                    )
                                                  : Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            Ministries(snapshot
                                                                .data[index]),
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
                                      leading: CircleAvatar(
                                        foregroundColor: Colors.white,
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        child: _cardName == "Events"
                                            ? FaIcon(FontAwesomeIcons.buffer)
                                            : _cardName == "Fundraising"
                                                ? FaIcon(
                                                    FontAwesomeIcons.donate,
                                                    size: 22,
                                                  )
                                                : _cardName == "Ministries"
                                                    ? FaIcon(
                                                        FontAwesomeIcons.church,
                                                        size: 20,
                                                      )
                                                    : Container(),
                                      ),
                                      title: Text(_cardName == "Events"
                                          ? snapshot.data[index].eventTitle
                                          : _cardName == "Fundraising"
                                              ? snapshot.data[index].fundTitle
                                              : _cardName == "Ministries"
                                                  ? snapshot
                                                      .data[index].ministryName
                                                  : null),
                                      subtitle: _cardName == "Events"
                                          ? Row(
                                              children: [
                                                Text(
                                                  "Stars on: ",
                                                  style: TextStyle(
                                                      fontFamily:
                                                          "Poppins-SemiBold"),
                                                ),
                                                Text(
                                                  snapshot.data[index].startOn,
                                                  style: TextStyle(
                                                      fontFamily:
                                                          "Poppins-SemiBold"),
                                                ),
                                              ],
                                            )
                                          : _cardName == "Fundraising"
                                              ? Row(
                                                  children: [
                                                    Text(
                                                      "Amount Ugx: ",
                                                    ),
                                                    Text(
                                                      snapshot.data[index]
                                                          .fundAmount,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Poppins-SemiBold"),
                                                    ),
                                                  ],
                                                )
                                              : null,
                                    );
                                  });
                            }
                          }, // context
                        ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
