import 'dart:async';

import 'package:chat_gpt_02/blocs/chat_screen/chat_screen.dart';
import 'package:chat_gpt_02/models/message.dart';
import 'package:chat_gpt_02/ui/chatmessage.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'threedots.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key}) {
    _chatScreenBloc.add(const InitChatScreen());
  }

  final TextEditingController _controller = TextEditingController();
  final ChatScreenBloc _chatScreenBloc = ChatScreenBloc();

  void _sendMessage(bool isImageSearch) {
    if (_controller.text.isEmpty) return;
    _chatScreenBloc.add(SendMessage(text: _controller.text, isGenerateImage: isImageSearch));
    _controller.clear();
  }

  Widget _buildTextComposer() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 4, right: 4),
            child: TextField(
              controller: _controller,
              maxLines: 4,
              minLines: 1,
              onSubmitted: (value) => _sendMessage(false),
              decoration: const InputDecoration.collapsed(
                  hintText: "Message", ),
            ),
          ),
        ),
        const SizedBox(width: 8,),
        Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(1000)),
          ),
          child: IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              _sendMessage(false);
            },
          ),
        ),
      ],
    ).px16();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Real Assist AI",  style: TextStyle(fontSize: 18,)),
            Text("This is private message, between you and Assistant", style: TextStyle(fontSize: 12,)),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.chat),
          )
        ],
        elevation: 2,
        backgroundColor: Colors.white,),
        backgroundColor: Colors.white.withOpacity(0.9),
        body: SafeArea(
          child: BlocBuilder<ChatScreenBloc, ChatScreenState>(
            bloc: _chatScreenBloc,
            builder: (context, state) {
              if(state is ChatScreenInitialized) {
                return Column(
                  children: [
                    Flexible(
                        child: ListView.builder(
                          reverse: true,
                          padding: Vx.m8,
                          itemCount: state.messages.length,
                          itemBuilder: (context, index) {
                            Message message = state.messages[index];
                            return ChatMessage(
                              text: message.text,
                              sender: message.sender,
                              isImage: message.isImage,
                            );
                          },
                        )),
                    if (state.isTyping) const ThreeDots(),
                    _buildTextComposer(),
                    const SizedBox(height: 8,),
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        ));
  }
}
