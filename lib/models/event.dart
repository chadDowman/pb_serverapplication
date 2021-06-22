
import 'package:flutter/material.dart';

class EventID{
  final String id;

  EventID({this.id});
}

class Event {
  final String id;
  final String eventName;
  final String eventDescription;
  final String pickedDate;
  final int hour;
  final int minute;

  Event({this.id, this.eventName, this.eventDescription, this.pickedDate, this.hour, this.minute});
}