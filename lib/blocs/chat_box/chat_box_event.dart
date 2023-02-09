import 'package:flutter/widgets.dart';

@immutable
abstract class ChatBoxEvent {
  const ChatBoxEvent() : super();
}

class InitChatBox extends ChatBoxEvent {
  const InitChatBox();
}


