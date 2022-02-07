import 'package:flutter/material.dart';

import 'User.dart';

class Message {
  final String payload;

  final User sender;
  final User empfaenger;

  final TimeOfDay date = TimeOfDay.now();

  Message(this.payload, this.sender, this.empfaenger);
}