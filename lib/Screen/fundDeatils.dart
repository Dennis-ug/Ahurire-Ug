import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:nabiituapp/Screen/eventsPayments.dart';
import 'package:nabiituapp/testdata/services.dart';
import 'package:cupertino_progress_bar/cupertino_progress_bar.dart';

class FundDetails extends StatefulWidget {
  final Fund _obj;

  FundDetails(this._obj);

  @override
  _FundDetails createState() => _FundDetails(_obj);
}

class _FundDetails extends State<FundDetails> {
  final Fund _obj;

  _FundDetails(
    this._obj,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_obj.fundTitle),
        elevation: 0,
      ),
      body: Details(
        _obj,
      ),
    );
  }
}

class Details extends StatefulWidget {
  final Fund _obj;
  Details(
    this._obj,
  );

  @override
  _DetailState createState() => _DetailState(
        _obj,
      );
}

class _DetailState extends State<Details> {
  final Fund _obj;

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
                height: _hyt * 0.0236160714285714,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  // height: _hyt * 0.289,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  clipBehavior: Clip.antiAlias,
                  //*Exemption review */
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://pay.yesuahuriire.org/fundraising-images/${_obj.fundImage}",
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                            child: Container(
                                height: 50,
                                width: 50,
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).primaryColor,
                                ))),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  // Image(
                  //   fit: BoxFit.cover,
                  //     image: NetworkImage(
                  //         "https://pay.yesuahuriire.org/fundraising-images/${_obj.fundImage}",
                  //         headers: null),),
                ),
              ),
              SizedBox(
                height: _hyt * 0.3025,
              ),

              //Donate button
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UniPayment(
                                title: "Events",
                                id: _obj.fundId,
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
        //Descriptin Card
        //Deassion
        Positioned(
          top: _hyt * 0.2647321428571429,
          left: (_wyd * 0.1159420289855072),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black, blurRadius: 4, offset: Offset(0, 0))
              ],
            ),
            height: (_hyt * 0.3348214285714286),
            width: _wyd * 0.7536231884057971,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child:
                    //Funding deatils
                    Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Description",
                      style: TextStyle(fontFamily: "Poppins-SemiBold"),
                    ),
                    AutoSizeText(
                      _obj.fundDetails,
                      style: TextStyle(
                          fontSize: (_hyt * 0.3348214285714286) * 0.0521),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor),
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Text(
                              "Target",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins-SemiBold",
                                  fontSize:
                                      (_hyt * 0.3348214285714286) * 0.0501),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          _obj.fundAmount,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: (_hyt * 0.3348214285714286) * 0.0501),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor),
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Text(
                              "Target",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins-SemiBold",
                                  fontSize:
                                      (_hyt * 0.3348214285714286) * 0.0501),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          _obj.fundBal,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: (_hyt * 0.3348214285714286) * 0.0501),
                        ),
                      ],
                    ),
                    CupertinoProgressBar(
                      valueColor: Color.fromRGBO(255, 168, 0, 1),
                      value: 0.9,
                      trackColor: Colors.grey,
                    )
                  ],
                )),
          ),
        ),
      ],
    );
  }
}
