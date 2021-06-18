import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nabiituapp/testdata/services.dart';

import 'pledgepayment.dart';

String que1 = "";

class PledgeView extends StatefulWidget {
  const PledgeView({Key? key}) : super(key: key);

  @override
  _PledgeViewState createState() => _PledgeViewState();
}

class _PledgeViewState extends State<PledgeView> {
  bool isSearch = false;
  final TextEditingController _search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !isSearch,
        elevation: 0,
        title: !isSearch
            ? Text("Pledge Numbers")
            : Container(
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _search.text = "";
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Text(
                              "Clear",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      controller: _search,
                      onChanged: (txt) {
                        setState(() {
                          que1 = _search.text;
                        });
                      },
                    ),
                  ),
                ),
              ),
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                isSearch = !isSearch;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 14, right: 20),
              child: !isSearch
                  ? FaIcon(
                      FontAwesomeIcons.search,
                      color: Colors.white,
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text("Back"),
                    ),
            ),
          )
        ],
      ),
      body: _istGen(),
    );
  }
}

class _istGen extends StatefulWidget {
  @override
  __listGenState createState() => __listGenState();
}

class __listGenState extends State<_istGen> {
  final GlobalKey<FormState> _dia = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: Services.getPledge(que1),
          builder: (_, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: Container(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          ListTile(
                            leading: FaIcon(
                              FontAwesomeIcons.phone,
                              color: Theme.of(context).primaryColor,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Payment(snapshot.data[index]),
                                ),
                              );
                              // creatDialog(
                              //   context,
                              //   snapshot.data[index].pledgeid,
                              //   snapshot.data[index].munywanicontact,
                              // );
                            },
                            title: Text(snapshot.data[index].munywanicontact),
                            // subtitle: Text(
                            //   "Pledge amount ${snapshot.data[index].pledgeamount}",
                            // ),
                          ),
                          Divider(
                            indent: 20,
                            thickness: 1.2,
                          ),
                        ],
                      ),
                    );
                  });
            }
          }),
    );
  }
}
