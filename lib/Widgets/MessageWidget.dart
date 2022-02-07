import 'package:alumnnet/Class/Message.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    Key? key,
    required this.message,
  }) : super(key: key);
  final Message message;
  @override
  Widget build(BuildContext context) {
    bool myMessage = message.sender.vorname != "Gerrit";
    
    return Align(
      alignment: myMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        width: 300,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          dense: true,
          title: Text(
            message.payload,
            style: TextStyle(),
          ),
          tileColor:
              myMessage ? Colors.white : Colors.blue[400]?.withOpacity(0.3),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          subtitle: Text(
            message.date.format(context),
            textAlign: TextAlign.right,
          ),
        ),
      ),
    );
  }
}
