import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({required this.text, required this.onPressed});

  final String text;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 60 / 100,
      child: RawMaterialButton(
          fillColor: Color.fromARGB(255, 14, 255, 183),
          splashColor: Color.fromARGB(255, 52, 255, 221),
          child: Center(
              child: Text(
            this.text,
            style: TextStyle(color: Color.fromARGB(255, 99, 99, 99)),
          )),
          onPressed: this.onPressed),
    );
  }
}
