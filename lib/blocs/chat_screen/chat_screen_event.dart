import 'package:flutter/widgets.dart';

@immutable
abstract class ChatScreenEvent {
  const ChatScreenEvent() : super();
}

class InitChatScreen extends ChatScreenEvent {
  const InitChatScreen();
}

class SendMessage extends ChatScreenEvent {
  final bool isGenerateImage;
  final String text;
  const SendMessage({this.isGenerateImage = false, required this.text});
}


