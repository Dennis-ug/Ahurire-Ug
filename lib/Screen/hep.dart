import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("Help"),
      ),
      body: Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            foregroundColor: Colors.white,
                            backgroundColor: Color.fromRGBO(255, 168, 0, 1),
                            child: FaIcon(
                              FontAwesomeIcons.church,
                              size: 30,
                            ),
                          ),
                          Text(
                            "1. Select activity\n to support",
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            foregroundColor: Colors.white,
                            backgroundColor: Color.fromRGBO(255, 168, 0, 1),
                            child: FaIcon(
                              FontAwesomeIcons.list,
                              size: 30,
                            ),
                          ),
                          Text(
                            "2. Enter your Details\n",
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            foregroundColor: Colors.white,
                            backgroundColor: Color.fromRGBO(255, 168, 0, 1),
                            child: FaIcon(
                              FontAwesomeIcons.donate,
                              size: 30,
                            ),
                          ),
                          Text(
                            "3. Enter Amount &\nClick pay",
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            foregroundColor: Colors.white,
                            backgroundColor: Color.fromRGBO(255, 168, 0, 1),
                            child: FaIcon(
                              FontAwesomeIcons.key,
                              size: 30,
                            ),
                          ),
                          Text(
                            "4. Enter MM PIN to \nconfirm",
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
