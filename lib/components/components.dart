import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';

import 'constant/constant.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({super.key, this.text, this.icon, this.onChanged,this.obSecureText=false});
  Function(String)? onChanged;
  String? text;
  IconData? icon;
  bool? obSecureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obSecureText!,
      validator: (data) {
        if (data!.isEmpty) {
          return 'field is required';
        }
      },
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        hintText: text,
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        prefixIcon: Icon(
          icon,
          color: Colors.white,
        ),
      ),
      onChanged: onChanged,
    );
  }
}

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.textButton,
    this.onPressed,
  });
  String textButton;
  VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            textButton,
            style: const TextStyle(color: Colors.black),
          ),
        ));
  }
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message
  });
final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.only(left: 16,top: 32,bottom: 32,right: 16),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        child:  Text(message.message,style: const TextStyle(color: Colors.white,),),
      ),
    );
  }
}

class ChatBubbleForUser extends StatelessWidget {
  const ChatBubbleForUser({
    super.key,
    required this.message
  });
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.only(left: 16,top: 32,bottom: 32,right: 16),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(
          color: Color(0xff006D84),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
        ),
        child:  Text(message.message,style: const TextStyle(color: Colors.white,),),
      ),
    );
  }
}