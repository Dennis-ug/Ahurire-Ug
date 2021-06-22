import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'eventsData.dart';

List eventsClean = [];
List fundraisingsClean = [];
List ministrisClean = [];
bool isData = false;

class Services {
  // static Future fetchNotes() async {
  //
  //
  //   var urlM = Uri.parse("https://app.yesuahuriire.org/ministries/");
  //   try {
  //
  //
  //     var resM = await http.get(urlM);
  //     print("data read");
  //     if (res.statusCode == 200 && resM.statusCode == 200) {
  //       //final eventsData = eventsDataFromJson(res.body);
  //       var data = json.decode(res.body);
  //
  //       var dataM = json.decode(resM.body);
  //       // print(eventsClean);
  //       // print(data["events"]);
  //       eventsClean = data["events"];
  //       print("event cleaned.........");
  //
  //       print("f cleaned.....");
  //       ministrisClean = dataM["ministries"];
  //       print("M cleaned.....");
  //       isData = true;
  //       // print("_______<>_______");
  //       // print(data["events"]);
  //       // print("_______<>_______");
  //       // print("_______<>_______");
  //       // print(
  //       //   data["events"][0]['event_title'],
  //       //);
  //     } else {
  //       print('not data found');
  //     }
  //   } catch (e) {
  //     print(e as String);
  //   }
  // }

  static Future<dynamic> getfund() async {
    var urlF = Uri.parse("https://app.yesuahuriire.org/fundraising/");
    try {
      var resF = await http.get(urlF);
      if (resF.statusCode == 200) {
        var dataF = json.decode(resF.body);
        List<Fund> fundData = [];
        List fundraisingsClean = dataF["fundraisings"];
        for (var i in fundraisingsClean) {
          fundData.add(
            Fund(
              fundId: i["fundraising_id"],
              fundTitle: i["fundraising_title"],
              fundDetails: i["fundraising_details"],
              fundAmount: i["fundraising_amount"],
              fundImage: i["fundraising_img"],
              fundBal: i["fundraising_account_balance"],
              fundCode: i["fundraising_ussd_code"],
            ),
          );
        }
        return fundData;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> getEvent() async {
    var urlF = Uri.parse("https://app.yesuahuriire.org/events/");
    try {
      var resF = await http.get(urlF);
      if (resF.statusCode == 200) {
        var dataF = json.decode(resF.body);
        List<Events> eventsData = [];
        List clean = dataF["events"];
        for (var i in clean) {
          eventsData.add(
            Events(
              eventId: i["event_id"],
              eventTitle: i["event_title"],
              eventDetails: i["event_description"],
              startOn: i["event_starts_on"],
              eventImage: i["event_img"],
              endOn: i["event_ends_on"],
              eventCode: i["event_ussd_code"],
              eventDuration: i["event_duration"],
            ),
          );
        }
        return eventsData;
      }
    } catch (e) {
      print("error");
      return null;
    }
  }

  static Future<dynamic> getMinistries() async {
    var urlF = Uri.parse("https://app.yesuahuriire.org/ministries/");
    try {
      var resF = await http.get(urlF);
      if (resF.statusCode == 200) {
        var dataF = json.decode(resF.body);
        List<Min> ministriesData = [];
        List clean = dataF["ministries"];
        for (var i in clean) {
          ministriesData.add(
            Min(
                ministryId: i["ministry_id"],
                ministryName: i["ministry_name"],
                ministryImg: i["ministry_img"],
                ministryUssdCode: i["ministry_ussd_code"]),
          );
        }
        return ministriesData;
      }
    } catch (e) {
      print("error");
      return null;
    }
  }

  static Future<dynamic> getPledge(String query) async {
    var urlF = Uri.parse("https://app.yesuahuriire.org/pledges/");
    try {
      var resF = await http.get(urlF);
      if (resF.statusCode == 200) {
        var dataF = json.decode(resF.body);
        List<Pledge> pledgeData = [];
        List clean = dataF["pledges"];
        for (var i in clean) {
          pledgeData.add(
            Pledge(
              pledgeid: i["pledge_id"],
              pledgeamount: i["pledge_amount"],
              munywanicontact: i["munywani_contact"],
            ),
          );
        }
        return pledgeData
            .where((plg) => plg.munywanicontact.startsWith(query))
            .toList();
      }
    } catch (e) {
      print("error");
      return null;
    }
  }
}

class Fund {
  late final fundId;
  late final fundTitle;
  late final fundDetails;
  late final fundAmount;
  late final fundImage;
  late final fundBal;
  late final fundCode;
  Fund(
      {this.fundId,
      this.fundTitle,
      this.fundDetails,
      this.fundAmount,
      this.fundImage,
      this.fundBal,
      this.fundCode});
}

class Events {
  late final eventId;
  late final eventTitle;
  late final eventDetails;
  late final startOn;
  late final eventImage;
  late final endOn;
  late final eventCode;
  late final eventDuration;
  Events(
      {this.eventId,
      this.eventTitle,
      this.eventDetails,
      this.startOn,
      this.eventImage,
      this.endOn,
      this.eventCode,
      this.eventDuration});
}

class Min {
  late final ministryId;
  late final ministryName;
  late final ministryImg;
  late final ministryUssdCode;

  Min({
    this.ministryId,
    this.ministryName,
    this.ministryImg,
    this.ministryUssdCode,
  });
}

class Pledge {
  late final pledgeid;
  late final pledgeamount;
  late final munywanicontact;

  Pledge({
    this.pledgeid,
    this.pledgeamount,
    this.munywanicontact,
  });
}
