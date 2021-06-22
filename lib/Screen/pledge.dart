import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nabiituapp/testdata/services.dart';
import 'package:http/http.dart' as http;

import 'pledgepayment.dart';

String que1 = "";

class PledgeView extends StatefulWidget {
  const PledgeView({Key? key}) : super(key: key);

  @override
  _PledgeViewState createState() => _PledgeViewState();
}

class _PledgeViewState extends State<PledgeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text("Pay Pledge"),
      ),
      body: _ListGen(),
    );
  }
}

class _ListGen extends StatefulWidget {
  @override
  __listGenState createState() => __listGenState();
}

class __listGenState extends State<_ListGen> {
  final GlobalKey<FormState> _dia = GlobalKey<FormState>();

  Future<List?> getPledge(String query) async {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        child: Center(
          child: Column(
            children: [
              Text(
                "Pay your Pledge",
                style: TextStyle(
                  fontFamily: "Poppins-SemiBold",
                ),
              ),
              Text(
                "You can only pay your pledge if you are registered as the a 'Munywani'\n( Friend of the community) ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Poppins-Regular",
                ),
              ),
              TypeAheadFormField<Pledge>(
                textFieldConfiguration: TextFieldConfiguration(
                    autofocus: false,
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
                    )),
                suggestionsCallback: (pattern) async {
                  return await Services.getPledge(pattern);
                },
                onSuggestionSelected: (data) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Payment(data),
                    ),
                  );
                },
                itemBuilder: (context, Pledge? data) {
                  return ListTile(
                    title: Text(data!.munywanicontact),
                    subtitle: Text(data!.pledgeamount),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
