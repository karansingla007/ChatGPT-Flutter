import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage(
      {super.key,
      required this.text,
      required this.sender,
      this.isImage = false});

  final String text;
  final String sender;
  final bool isImage;

  @override
  Widget build(BuildContext context) {
    if (sender == "bot") {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 40,),
          Container(
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8), topLeft: Radius.circular(8),),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
              child: Container(
                  constraints: BoxConstraints(minWidth: 40, maxWidth: MediaQuery.of(context).size.width - 110),
                  child: Text(text.trim()),),
            ),),
        ],
      ).py8();
    } else {
      return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8), topRight: Radius.circular(8),),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                      constraints: BoxConstraints(minWidth: 40, maxWidth: MediaQuery.of(context).size.width - 100),
                      child: Text(text)),
                  const SizedBox(width: 8,),
                  const Icon(Icons.copy, size: 14),
                ],
              ),
            ),
        ),
        const SizedBox(width: 40,),
      ],
    ).py8();
    }
  }
}
