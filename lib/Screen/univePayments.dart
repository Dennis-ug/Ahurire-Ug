import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutableflutter pu
class UniPayment extends StatefulWidget {
  String title;
  String id;
  UniPayment({required this.title, required this.id});

  @override
  _PaymentState createState() => _PaymentState(title: title, id: id);
}

class _PaymentState extends State<UniPayment> {
  String title;
  String id;
  _PaymentState({required this.title, required this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("$title Payments"),
      ),
      body: PayView(
        id: id,
      ),
    );
  }
}

class PayView extends StatefulWidget {
  String id;
  PayView({required this.id});
  @override
  _PayViewState createState() => _PayViewState(newid: id);
}

class _PayViewState extends State<PayView> {
  String newid;
  _PayViewState({required this.newid});

  late String _cnt;
  late String _amt;
  late String _name;
  late String _email;
  late String _address;
  bool _isPaid = false;
  late Map _resData;

  var _payResults;

  GlobalKey<FormState> _payForm = GlobalKey<FormState>();

  Future<dynamic> payPledge(String _id, String cont, String amt) async {
    var urlF = Uri.parse(
        "https://payments.yesuahuriire.org/ministries/pledges/transactions");

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
      'POST',
      urlF,
    );
    request.body =
        json.encode({"pledge": "$_id", "contact": "$_cnt", "amount": "$_amt"});
    request.headers.addAll(headers);

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        _payResults = json.decode(await response.stream.bytesToString());
        print("code state ${_payResults["success"]}");
        setState(() {
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
              // Text(
              //   "Please enter details to pay \n the pledge at this number \n ${_obj.munywanicontact}",
              //   textAlign: TextAlign.center,
              //   style: TextStyle(),
              // ),
              Form(
                key: _payForm,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Enter the following details"),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 1,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 1,
                          ),
                        ),
                        //helperText:
                        //"Enter a number that is registered on mobile money",
                        labelText: 'Name',
                        labelStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),

                        hintText: "Enter your name",
                        hintStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      validator: (value) {
                        if (value == "") {
                          return "This field cant be Empty";
                        }
                      },
                      onSaved: (value) {
                        setState(() {
                          _name = value!;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      autofillHints: [AutofillHints.email],
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 1,
                          ),
                        ),
                        //helperText:
                        //"Enter a number that is registered on mobile money",
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),

                        hintText: "Enter your email",
                      ),
                      // validator: (value) => !EmailValidator.validate(value)
                      //     ? "Invalid email"
                      //     : null,
                      onSaved: (value) {
                        setState(() {
                          _email = value!;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      maxLength: 10,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 1,
                          ),
                        ),
                        //helperText:
                        //"Enter a number that is registered on mobile money",
                        labelText: 'Payment Number',
                        labelStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),

                        hintText: "Enter a Number to use for payment",
                      ),
                      validator: (value) {
                        if (value == "") {
                          return "This field cant be Empty";
                        } else if (value!.startsWith("07") &&
                            value.length < 10) {
                          return "Invalid Number entered";
                        } else if (!value.startsWith("07")) {
                          return "Invalid Number entered";
                        }
                      },
                      onSaved: (value) {
                        setState(() {
                          _cnt = value!;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 1,
                          ),
                        ),
                        labelText: "Amount",
                        labelStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                        hintText: "Enter Amount ",
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
                    SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        "pay",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        FocusManager.instance.primaryFocus!.unfocus();
                        if (!_payForm.currentState!.validate()) {
                          return;
                        }
                        _payForm.currentState!.save();
                        payPledge(newid, _cnt, _amt);
                        print(_name);
                        print(_email);
                        print(newid);
                        print(_cnt);
                        print(_amt);
                        print("done");
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
