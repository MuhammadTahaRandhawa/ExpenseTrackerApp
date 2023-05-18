import 'package:flutter/material.dart';

class AddCloseButton extends StatelessWidget {
  const AddCloseButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  final void Function() onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14)),
      child: Text(text),
    );
  }
}
