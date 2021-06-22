import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

bool isEnabled = true;

// ignore: must_be_immutableflutter pu
class FundPayment extends StatefulWidget {
  String title;
  String id;
  FundPayment({required this.title, required this.id});

  @override
  _PaymentState createState() => _PaymentState(title: title, id: id);
}

class _PaymentState extends State<FundPayment> {
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
  late String _dia ="";

  late String _cnt;
  late String _amt;
  late String _name;
  late String _email;

  bool _isPaid = false;

  var _payResults;


  GlobalKey<FormState> _payForm = GlobalKey<FormState>();

  Future<dynamic> payFund(String _id, String cont, String amt) async {
    print("Started....");
    setState(() {
      _dia ="sending request...";
      isEnabled = false;
    });
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://payments.yesuahuriire.org/fundraisings/transactions'));
    request.body = json.encode({
      "fundraising": 1,
      "name": "$_name",
      "address": "N/L",
      "amount": _amt,
      "email": _email,
      "contact": _cnt
    });
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      print(response.statusCode);

      if (response.statusCode == 201) {
        _payResults = json.decode(await response.stream.bytesToString());
        setState(() {
          isEnabled = true;
                });
        return AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.BOTTOMSLIDE,
          title: '${_payResults["messages"][0]}',
          desc: "Please approve the payment request \n sent to your phone",
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        )..show();
      }

    } on Exception catch (e) {
       return AwesomeDialog(
              context: context,
              dialogType: DialogType.ERROR,
              animType: AnimType.BOTTOMSLIDE,
              title: 'Sorry',
              desc: " Some Thing went Wrong",
              btnCancelOnPress: () {
                Navigator.pop(context);
              },
              btnOkOnPress: () {
                setState(() {

                });
              },
            )..show();
    }
  }

  @override
  Widget build(BuildContext context) {
    ProgressDialog pd = ProgressDialog(context: context);

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
                      keyboardType: TextInputType.emailAddress,
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
                      validator: (value) => !EmailValidator.validate(value)
                          ? "Invalid email"
                          : null,
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
                      child: isEnabled
                          ? Text(
                              "Make payment",
                              style: TextStyle(color: Colors.white),
                            )
                          : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        FocusManager.instance.primaryFocus!.unfocus();
                        if (!_payForm.currentState!.validate()) {
                          return;
                        }
                        _payForm.currentState!.save();
                        setState(() {
                          isEnabled = false;
                        });
                        payFund(newid, _cnt, _amt);



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
