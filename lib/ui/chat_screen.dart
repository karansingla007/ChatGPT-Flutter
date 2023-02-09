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
          child: TextField(
            controller: _controller,
            onSubmitted: (value) => _sendMessage(false),
            decoration: const InputDecoration.collapsed(
                hintText: "Question/description"),
          ),
        ),
        ButtonBar(
          children: [
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                _sendMessage(false);
              },
            ),
            TextButton(
                onPressed: () {
                  _sendMessage(true);
                },
                child: const Text("Generate Image"))
          ],
        ),
      ],
    ).px16();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("ChatGPT Flutter Demo")),
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
                    const Divider(
                      height: 1.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: context.cardColor,
                      ),
                      child: _buildTextComposer(),
                    )
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
