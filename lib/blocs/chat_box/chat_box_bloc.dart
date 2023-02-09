import 'package:bloc/bloc.dart';
import 'package:chat_gpt_02/blocs/chat_box/chat_box_state.dart';
import 'package:chat_gpt_02/blocs/chat_box/chat_box_event.dart';

class ChatBoxBloc extends Bloc<ChatBoxEvent, ChatBoxState> {

  ChatBoxBloc() : super(ChatBoxInitializing()) {
    on<InitChatBox>(mapEventToState);
  }

  void mapEventToState(
      ChatBoxEvent event, Emitter<ChatBoxState> emit) async {
    if (event is InitChatBox) {

      emit(const ChatBoxInitialized());
    }
  }
}
