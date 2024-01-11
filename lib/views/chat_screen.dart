import 'package:chat_app/components/constant/constant.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/components.dart';
import 'chat_cubit/chat_cubit.dart';


class ChatScreen extends StatelessWidget {
  final _controller = ScrollController();
  static String chatId = 'ChatScreen';
  TextEditingController controller = TextEditingController();
  List<Message> messageList = [];
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute
        .of(context)!
        .settings
        .arguments as String;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kLogo,
              height: 50,
            ),
            const Text(
              'Chat ',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                var messageList = BlocProvider.of<ChatCubit>(context).messagesList;
                return ListView.builder(
                    controller: _controller,
                    reverse: true,
                    itemCount: messageList.length,
                    itemBuilder: (context, index) {
                      return messageList[index].id == email
                          ? ChatBubble(
                        message: messageList[index],
                      )
                          : ChatBubbleForUser(
                        message: messageList[index],
                      );
                    });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
                BlocProvider.of<ChatCubit>(context).sendMessage(message: data, email: email);

                controller.clear();
                _controller.animateTo(
                  0,
                  duration: const Duration(
                    seconds: 1,
                  ),
                  curve: Curves.fastOutSlowIn,
                );
              },
              decoration: InputDecoration(
                hintText: 'Send a Message',
                hintStyle: const TextStyle(),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: kPrimaryColor,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: kPrimaryColor,
                  ),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    //BlocProvider.of<ChatCubit>(context).sendMessage(message: 'data', email: email);
                  },
                  icon: const Icon(
                    Icons.send,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
