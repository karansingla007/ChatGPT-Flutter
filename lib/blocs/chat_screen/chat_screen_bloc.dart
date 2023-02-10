import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_gpt_02/blocs/chat_screen/chat_screen_event.dart';
import 'package:chat_gpt_02/blocs/chat_screen/chat_screen_state.dart';
import 'package:chat_gpt_02/models/message.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatScreenBloc extends Bloc<ChatScreenEvent, ChatScreenState> {
  OpenAI? openAI;
  ChatScreenBloc() : super(ChatScreenInitializing()) {
    on<InitChatScreen>(mapEventToState);
    on<SendMessage>(mapEventToState);
  }

  void mapEventToState(
      ChatScreenEvent event, Emitter<ChatScreenState> emit) async {
    if (event is InitChatScreen) {
      openAI = OpenAI.instance.build(
          token: "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",
          baseOption: HttpSetup(receiveTimeout: 6000),isLogger: true
      );
      emit(const ChatScreenInitialized(messages: []));
    } else if(event is SendMessage) {
      if(state is ChatScreenInitialized) {
        List<Message> prevMessages = [];
        prevMessages.addAll((state as ChatScreenInitialized).messages);
        Message message = Message(
          text: event.text,
          sender: "user",
          isImage: false,
        );
        prevMessages.insert(0, message);
        emit(ChatScreenInitialized(messages: prevMessages, isTyping: true));

        if(event.isGenerateImage) {
          try {
            final request = GenerateImage(message.text, 1, size: "256x256");
            GenImgResponse? response = await openAI!.generateImage(request);

            if(response == null) {
              emit(ChatScreenInitialized(messages: prevMessages, isTyping: false));
            } else {
              Message newMessage = Message(
                text: response.data!.last!.url!,
                sender: "bot",
                isImage: true,
              );
              prevMessages.insert(0, newMessage);
              emit(ChatScreenInitialized(messages: prevMessages, isTyping: false));
            }
          } catch(err) {
            emit(ChatScreenInitialized(messages: prevMessages, isTyping: false));
          }


        } else {
          final request = CompleteText(
              prompt: message.text, model: kTranslateModelV3, maxTokens: 200);
          try {
            CTResponse? response = await openAI!.onCompleteText(request: request);
            if(response == null) {
              emit(ChatScreenInitialized(messages: prevMessages, isTyping: false));
            } else {
              Vx.log(response.choices[0].text);
              Message newMessage = Message(
                text: response.choices[0].text,
                sender: "bot",
                isImage: false,
              );
              prevMessages.insert(0, newMessage);
              emit(ChatScreenInitialized(messages: prevMessages, isTyping: false));
            }
          } catch(err) {
            emit(ChatScreenInitialized(messages: prevMessages, isTyping: false));
          }

        }
      }
    }
  }
}
