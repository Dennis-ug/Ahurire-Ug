// To parse this JSON data, do
//
//     final eventsData = eventsDataFromJson(jsonString);

import 'dart:convert';

EventsData eventsDataFromJson(String str) =>
    EventsData.fromJson(json.decode(str));

String eventsDataToJson(EventsData data) => json.encode(data.toJson());

class EventsData {
  EventsData({
    required this.events,
  });

  List<Event> events;

  factory EventsData.fromJson(Map<String, dynamic> json) => EventsData(
        events: List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "events": List<dynamic>.from(events.map((x) => x.toJson())),
      };
}

class Event {
  Event({
    required this.eventId,
    required this.eventTitle,
    required this.eventDescription,
    required this.eventImg,
    required this.eventStartsOn,
    required this.eventEndsOn,
    required this.eventDuration,
    required this.eventUssdCode,
  });

  String eventId;
  String eventTitle;
  String eventDescription;
  String eventImg;
  DateTime eventStartsOn;
  DateTime eventEndsOn;
  String eventDuration;
  String eventUssdCode;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        eventId: json["event_id"],
        eventTitle: json["event_title"],
        eventDescription: json["event_description"],
        eventImg: json["event_img"],
        eventStartsOn: DateTime.parse(json["event_starts_on"]),
        eventEndsOn: DateTime.parse(json["event_ends_on"]),
        eventDuration: json["event_duration"],
        eventUssdCode: json["event_ussd_code"],
      );

  Map<String, dynamic> toJson() => {
        "event_id": eventId,
        "event_title": eventTitle,
        "event_description": eventDescription,
        "event_img": eventImg,
        "event_starts_on":
            "${eventStartsOn.year.toString().padLeft(4, '0')}-${eventStartsOn.month.toString().padLeft(2, '0')}-${eventStartsOn.day.toString().padLeft(2, '0')}",
        "event_ends_on":
            "${eventEndsOn.year.toString().padLeft(4, '0')}-${eventEndsOn.month.toString().padLeft(2, '0')}-${eventEndsOn.day.toString().padLeft(2, '0')}",
        "event_duration": eventDuration,
        "event_ussd_code": eventUssdCode,
      };
}
