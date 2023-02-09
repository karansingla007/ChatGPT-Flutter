import 'package:meta/meta.dart';

@immutable
abstract class ChatBoxState {
  const ChatBoxState([props = const []]) : super();
}

class ChatBoxInitializing extends ChatBoxState {}

class ChatBoxInitialized extends ChatBoxState {

  const ChatBoxInitialized();
}
