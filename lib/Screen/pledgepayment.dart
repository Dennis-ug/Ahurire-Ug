import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nabiituapp/testdata/services.dart';
import 'package:http/http.dart' as http;

bool isEnabled = true;

class Payment extends StatefulWidget {
  late Pledge _obj;
  Payment(this._obj);

  @override
  _PaymentState createState() => _PaymentState(_obj);
}

class _PaymentState extends State<Payment> {
  late Pledge _obj;
  _PaymentState(this._obj);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Payments"),
      ),
      body: PayView(_obj),
    );
  }
}

class PayView extends StatefulWidget {
  late Pledge _obj;
  PayView(this._obj);

  @override
  _PayViewState createState() => _PayViewState(_obj);
}

class _PayViewState extends State<PayView> {
  late Pledge _obj;
  late String _cnt;
  late String _amt;
  bool _isPaid = false;
  late Map _resData;

  _PayViewState(this._obj);
  var _payResults;

  GlobalKey<FormState> _payForm = GlobalKey<FormState>();

  Future<dynamic> payPledge(String id, String cont, String amt) async {
    setState(() {
      isEnabled = false;
    });
    var urlF = Uri.parse(
        "https://payments.yesuahuriire.org/ministries/pledges/transactions");

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
      'POST',
      urlF,
    );
    request.body = json.encode(
        {"pledge": "${_obj.pledgeid}", "contact": "$_cnt", "amount": "$_amt"});
    request.headers.addAll(headers);

    try {
      var response = await request.send();
      if (response.statusCode == 201) {
        _payResults = json.decode(await response.stream.bytesToString());

        setState(() {
          isEnabled = true;
          _isPaid = true;
          _resData = _payResults;
        });
        return _payResults;
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: _isPaid == false
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              Text(
                "Please enter details to pay the following pledge\n\n",
                textAlign: TextAlign.center,
                style: TextStyle( fontSize: 20),
              ),
              Text("Pledge Number: ${_obj.munywanicontact}\n",textAlign: TextAlign.left,),
              Text("Pledge Number: ${_obj.pledgeamount}\n"),

              SizedBox(height: 40,),
              Form(
                key: _payForm,
                child: Column(
                  children: [
                    TextFormField(
                      maxLength: 10,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        //helperText:
                        //"Enter a number that is registered on mobile money",
                        labelText: 'Payment Number',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor)),
                        fillColor: Theme.of(context).primaryColor,
                        hintText: "Enter a Number to use for payment",
                      ),
                      validator: (value) {
                        if (value == "") {
                          return "This field cant be Empty";
                        } else if (value!.startsWith("07") &&
                            value.length < 10) {
                          return "Invalid Number entered";
                        }
                      },
                      onSaved: (value) {
                        setState(() {
                          _cnt = value!;
                        });
                      },
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        fillColor: Theme.of(context).primaryColor,
                        hintText: "Enter Amount pledged",
                      ),
                      validator: (value) {
                        late int _amt;

                        value == "" ? null : _amt = int.parse(value!);
                        if (value == "") {
                          return "This field cant be Empty";
                        } else if (_amt < 500) {
                          return "Minimum money required is 500";
                        }
                      },
                      onSaved: (value) {
                        setState(() {
                          _amt = value!;
                        });
                      },
                    ),
                    MaterialButton(
                      enableFeedback: isEnabled,
                      color: Theme.of(context).primaryColor,
                      child: isEnabled
                          ? Text(
                              "Make payment",
                              style: TextStyle(color: Colors.white),
                            )
                          : Text(
                              "Loading.....",
                              style: TextStyle(color: Colors.white),
                            ),
                      onPressed: () {
                        FocusManager.instance.primaryFocus!.unfocus();

                        if (!_payForm.currentState!.validate()) {
                          return;
                        }
                        _payForm.currentState!.save();
                        payPledge(_obj.pledgeid, _cnt, _amt);
                        print(_cnt);
                        print(_amt);
                        print("done");
                      },
                    )
                  ],
                ),
              ),
              !_isPaid == false
                  ? Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        height: 300,
                        width: 400,
                        decoration: BoxDecoration(
                            color: Theme.of(context)
                                .primaryColor
                                .withOpacity(0.25)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Text(_resData["messages"][0]),
                            SizedBox(
                              height: 5,
                            ),
                            Text("Details"),
                            SizedBox(
                              height: 5,
                            ),
                            Text("Pledge No. ${_resData["data"]["pledge"]}"),
                            Text("Payment No. ${_resData["data"]["contact"]}"),
                            Text("Amount ${_resData["data"]["amount"]}"),
                            Text(
                                "Transaction No. ${_resData["data"]["transaction"]}"),
                          ],
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
