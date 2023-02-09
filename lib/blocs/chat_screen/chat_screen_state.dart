import 'package:chat_gpt_02/models/message.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ChatScreenState {
  const ChatScreenState([props = const []]) : super();
}

class ChatScreenInitializing extends ChatScreenState {}

class ChatScreenInitialized extends ChatScreenState {
  final List<Message> messages;
  final bool isTyping;
  const ChatScreenInitialized({required this.messages, this.isTyping = false});
}
