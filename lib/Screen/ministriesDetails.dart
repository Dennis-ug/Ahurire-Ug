import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nabiituapp/testdata/services.dart';

import 'ministryPayments.dart';
import 'pledge.dart';

class Ministries extends StatefulWidget {
  final Min _obj;

  Ministries(this._obj);

  @override
  _Ministries createState() => _Ministries(_obj);
}

class _Ministries extends State<Ministries> {
  final Min _obj;

  _Ministries(
    this._obj,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_obj.ministryName),
        elevation: 0,
      ),
      body: Details(
        _obj,
      ),
    );
  }
}

class Details extends StatefulWidget {
  final Min _obj;
  Details(
    this._obj,
  );

  @override
  _DetailState createState() => _DetailState(
        _obj,
      );
}

class _DetailState extends State<Details> {
  final Min _obj;
  _DetailState(
    this._obj,
  );
  @override
  Widget build(BuildContext context) {
    double _hyt = MediaQuery.of(context).size.height;
    double _wyd = MediaQuery.of(context).size.width;
    return _detailsBody(_hyt, _wyd, context);
  }

  Stack _detailsBody(double _hyt, double _wyd, BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Column(
            children: [
              SizedBox(
                height: _hyt * 0.0136160714285714,
              ),

              SizedBox(
                height: _hyt * 0.0167410714285714,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  clipBehavior: Clip.antiAlias,
                  //*Exemption review */
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://pay.yesuahuriire.org/ministry-images/${_obj.ministryImg}",
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: Container(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              SizedBox(
                height: _hyt * 0.1025,
              ),

              //Donate button
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MinistryPayment(
                                title: _obj.ministryName,
                                id: _obj.ministryId,
                              )));
                },
                child: Container(
                  height: _hyt * 0.0558035714285714,
                  width: _wyd * 0.7536231884057971,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 168, 0, 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "Donate",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 14),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PledgeView()));
                  },
                  child: Container(
                    height: _hyt * 0.0558035714285714,
                    width: _wyd * 0.7536231884057971,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Pay Pledge",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: _hyt * 0.1025,
              ),
              SizedBox(
                height: _hyt * 0.015,
              ),

              SizedBox(
                height: _hyt * 0.0213839285714286,
              ),

              Expanded(
                child: Container(
                  width: _wyd,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Powered by..",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "MOBiTUNGO",
                          style: TextStyle(
                              fontFamily: "Poppins-SemiBold",
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
